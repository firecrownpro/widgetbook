// The MIT License (MIT)
// Copyright (c) 2022 Widgetbook GmbH
// Copyright (c) 2022 Felix Angelov

// Permission is hereby granted, free of charge, to any person
// obtaining a copy of this software and associated documentation
// files (the "Software"), to deal in the Software without restriction,
// including without limitation the rights to use, copy, modify, merge,
// publish, distribute, sublicense, and/or sell copies of the Software,
// and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:

// The above copyright notice and this permission notice shall be included
// in all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
// DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
// OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
// USE OR OTHER DEALINGS IN THE SOFTWARE.

import 'dart:io';

import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;
import 'package:platform/platform.dart';

import '../api/widgetbook_http_client.dart';
import '../ci_parser/ci_parser.dart';
import '../git-provider/github/github.dart';
import '../git/branch_reference.dart';
import '../git/git_dir.dart';
import '../git/git_wrapper.dart';
import '../helpers/exceptions.dart';
import '../helpers/widgetbook_zip_encoder.dart';
import '../models/models.dart';
import '../models/publish_args.dart';
import '../review/use_cases/use_case_parser.dart';
import 'command.dart';

class PublishCommand extends WidgetbookCommand {
  PublishCommand({
    super.logger,
    this.ciParserRunner,
    this.platform = const LocalPlatform(),
    WidgetbookHttpClient? widgetbookHttpClient,
    WidgetbookZipEncoder? widgetbookZipEncoder,
    FileSystem? fileSystem,
    CiWrapper? ciWrapper,
    GitWrapper? gitWrapper,
    UseCaseParser? useCaseParser,
  })  : _widgetbookHttpClient = widgetbookHttpClient ?? WidgetbookHttpClient(),
        _widgetbookZipEncoder = widgetbookZipEncoder ?? WidgetbookZipEncoder(),
        _ciWrapper = ciWrapper ?? CiWrapper(),
        _gitWrapper = gitWrapper ?? GitWrapper(),
        _useCaseParser = useCaseParser,
        _fileSystem = fileSystem ?? const LocalFileSystem() {
    progress = logger.progress('Publishing Widgetbook');
    argParser
      ..addOption(
        'path',
        help: 'The path to the build folder of your application.',
        defaultsTo: './',
      )
      ..addOption(
        'api-key',
        help: 'The project specific API key for Widgetbook Cloud.',
        mandatory: true,
      )
      ..addOption(
        'branch',
        help: 'The name of the branch for which the Widgetbook is uploaded.',
      )
      ..addOption(
        'repository',
        help:
            'The name of the repository for which the Widgetbook is uploaded.',
      )
      ..addOption(
        'commit',
        help:
            'The SHA hash of the commit for which the Widgetbook is uploaded.',
      )
      ..addOption(
        'actor',
        help: 'The username of the actor which triggered the build.',
      )
      ..addOption(
        'git-provider',
        help: 'The name of the Git provider.',
        defaultsTo: 'Local',
        allowed: [
          'GitHub',
          'GitLab',
          'BitBucket',
          'Azure',
          'Local',
        ],
      )
      ..addOption(
        'base-branch',
        help:
            'The base branch of the pull-request. For example, main or master.',
      )
      ..addOption(
        'base-commit',
        help: 'The SHA hash of the commit of the base branch.',
      )
      ..addOption(
        'github-token',
        help: 'GitHub API token.',
      )
      ..addOption(
        'pr',
        help: 'The number of the PR.',
      );
  }

  @override
  final String description = 'Publish a new build';

  @override
  final String name = 'publish';

  CiParserRunner? ciParserRunner;
  final Platform platform;
  final WidgetbookHttpClient _widgetbookHttpClient;
  final WidgetbookZipEncoder _widgetbookZipEncoder;
  final FileSystem _fileSystem;
  final CiWrapper _ciWrapper;
  final GitWrapper _gitWrapper;
  final UseCaseParser? _useCaseParser;

  late final Progress progress;

  @visibleForTesting
  Future<void> checkIfPathIsGitDirectory(String path) async {
    final isGitDir = await _gitWrapper.isGitDir(path);
    if (!isGitDir) {
      throw GitDirectoryNotFound();
    }
  }

  @visibleForTesting
  Future<GitDir> getGitDir(String path) {
    return _gitWrapper.fromExisting(
      path,
      allowSubdirectory: true,
    );
  }

  @visibleForTesting
  Future<void> checkIfWorkingTreeIsClean(
    GitDir gitDir,
  ) async {
    final isWorkingTreeClean = await gitDir.isWorkingTreeClean();
    if (!isWorkingTreeClean) {
      logger
        ..warn('You have un-commited changes')
        ..warn('Uploading a new build to Widgetbook Cloud requires a commit '
            'SHA. Due to un-committed changes, we are using the commit SHA '
            'of your previous commit which can lead to the build being '
            'rejected due to an already existing build.');

      var proceedWithUnCommitedChanges = 'yes';

      if (stdin.hasTerminal) {
        proceedWithUnCommitedChanges = logger.chooseOne(
          'Would you like to proceed anyways?',
          choices: ['no', 'yes'],
          defaultValue: 'no',
        );
      }

      if (proceedWithUnCommitedChanges == 'no') {
        progress.cancel();
        throw ExitedByUser();
      }
    }
  }

  @visibleForTesting
  Future<CiArgs> getArgumentsFromCi(GitDir gitDir) async {
    // Due to the fact that the CiParserRunner requires a gitDir to be
    // initialized, we have this implementation to make the code testable
    ciParserRunner ??= CiParserRunner(argResults: results, gitDir: gitDir);
    final args = await ciParserRunner!.getParser()?.getCiArgs();

    if (args == null) {
      throw CiVendorNotSupported();
    }

    return args;
  }

  @visibleForTesting
  String? gitProviderSha() {
    if (_ciWrapper.isGithub()) {
      return platform.environment['GITHUB_SHA'];
    }

    if (_ciWrapper.isCodemagic()) {
      return platform.environment['CM_COMMIT'];
    }

    return null;
  }

  @visibleForTesting
  Future<PublishArgs> getArguments({
    required GitDir gitDir,
  }) async {
    final path = results['path'] as String;
    final apiKey = results['api-key'] as String;
    final currentBranch = await gitDir.currentBranch();
    final branch = results['branch'] as String? ?? currentBranch.branchName;

    final commit =
        results['commit'] as String? ?? gitProviderSha() ?? currentBranch.sha;

    final gitProvider = results['git-provider'] as String;
    final gitHubToken = results['github-token'] as String?;
    final prNumber = results['pr'] as String?;

    final baseBranch = await getBaseBranch(
      gitDir: gitDir,
      branch: results['base-branch'] as String?,
      sha: results['base-commit'] as String?,
    );

    final ciArgs = await getArgumentsFromCi(gitDir);
    final actor = ciArgs.actor;

    if (actor == null) {
      throw ActorNotFoundException();
    }

    final repository = ciArgs.repository;
    if (repository == null) {
      throw RepositoryNotFoundException();
    }

    return PublishArgs(
      apiKey: apiKey,
      branch: branch,
      commit: commit,
      gitProvider: gitProvider,
      path: path,
      vendor: ciArgs.vendor,
      actor: actor,
      repository: repository,
      baseBranch: baseBranch?.reference,
      baseSha: baseBranch?.sha,
      prNumber: prNumber,
      gitHubToken: gitHubToken,
    );
  }

  @override
  Future<int> run() async {
    final path = results['path'] as String;

    await checkIfPathIsGitDirectory(path);
    final gitDir = await getGitDir(path);
    await checkIfWorkingTreeIsClean(gitDir);
    final args = await getArguments(gitDir: gitDir);

    await publishBuilds(
      args: args,
      gitDir: gitDir,
      getZipFile: getZipFile,
      useCaseParser: _useCaseParser,
    );

    return ExitCode.success.code;
  }

  @visibleForTesting
  void deleteZip(File zip) {
    zip.delete();
  }

  @visibleForTesting
  File? getZipFile(Directory directory) =>
      _widgetbookZipEncoder.encode(directory);

  @visibleForTesting
  Future<BuildUploadResponse?> uploadDeploymentInfo({
    required File file,
    required PublishArgs args,
  }) {
    return _widgetbookHttpClient.uploadBuild(
      deploymentFile: file,
      data: CreateBuildRequest(
        branchName: args.branch,
        repositoryName: args.repository,
        commitSha: args.commit,
        actor: args.actor,
        apiKey: args.apiKey,
        provider: args.vendor,
      ),
    );
  }

  @visibleForTesting
  Future<ReviewUploadResponse?> uploadReview({
    required File file,
    required PublishArgs args,
    required ReviewData reviewData,
  }) async {
    return await _widgetbookHttpClient.uploadReview(
      apiKey: args.apiKey,
      useCases: reviewData.useCases,
      buildId: reviewData.buildId,
      projectId: reviewData.projectId,
      baseBranch: args.baseBranch!,
      baseSha: reviewData.baseSha,
      headBranch: args.branch,
      headSha: args.commit,
    );
  }

  // TODO sha is pretty much not used an is just being overriden with the most
  // recent sha of the branch
  // If this will be included do we need to check if the sha exists on the
  // branch?
  @visibleForTesting
  Future<BranchReference?> getBaseBranch({
    required GitDir gitDir,
    required String? branch,
    required String? sha,
  }) async {
    if (branch == null) {
      return null;
    }

    progress.update('fetching remote branches');
    await gitDir.fetch();

    progress.update('reading existing branches');
    final branches = await gitDir.allBranches();
    final branchesMap = {
      for (var k in branches) k.reference: k,
    };

    final branchRef = BranchReference(
      // This is not used, we are just using BranchReference to check if this is
      // a heads or remote branch (if at all)
      'a' * 40,
      branch,
    );

    const headsPrefix = 'refs/heads/';
    const headsPrefixRegex = '(?<=$headsPrefix)';
    const remotesPrefix = 'refs/remotes/origin/';
    const remotesPrefixRegex = '(?<=$remotesPrefix)';
    const endOfLine = r'$';

    if (branchRef.isHeads || branchRef.isRemote) {
      if (branchesMap.containsKey(branchRef.reference)) {
        return branchesMap[branchRef.reference];
      }

      // Azure provides the ref as 'refs/heads/<branch-name>'
      // This branch won't be found as of default.
      // But a branch 'refs/remotes/origin/<branch-name>' will exist
      final headsRefAsRemoteRef = '$remotesPrefix${branchRef.branchName}';
      if (branchesMap.containsKey(headsRefAsRemoteRef)) {
        return branchesMap[headsRefAsRemoteRef];
      }

      return null;
    } else {
      final headsRegex = RegExp(
        '$headsPrefixRegex${branchRef.reference}$endOfLine',
      );
      final remotesRegex = RegExp(
        '$remotesPrefixRegex${branchRef.reference}$endOfLine',
      );
      for (final branch in branches) {
        if (headsRegex.hasMatch(branch.reference)) {
          return branch;
        }
      }

      for (final branch in branches) {
        if (remotesRegex.hasMatch(branch.reference)) {
          return branch;
        }
      }
    }

    return null;
  }

  @visibleForTesting
  Future<void> publishBuilds({
    required PublishArgs args,
    required GitDir gitDir,
    required File? Function(Directory dir) getZipFile,
    UseCaseParser? useCaseParser,
  }) async {
    progress.update('Getting branches');

    final buildPath = p.join(
      args.path,
      'build',
      'web',
    );

    final baseBranch = args.baseBranch;
    final baseSha = args.baseSha;
    final directory = _fileSystem.directory(buildPath);
    final useCases = await _useCaseParser?.parse() ??
        (baseBranch == null
            ? []
            : await UseCaseParser(
                projectPath: args.path,
                baseBranch: baseBranch,
              ).parse());

    progress.update('Detected ${useCases.length} changed use-case(s)');

    try {
      progress.update('Generating zip');
      final file = getZipFile(directory);

      if (file != null) {
        progress.update('Uploading build');
        final buildUploadResponse = await uploadDeploymentInfo(
          file: file,
          args: args,
        );

        if (buildUploadResponse == null) {
          throw WidgetbookApiException();
        }

        for (final task in buildUploadResponse.tasks) {
          if (task.status == UploadTaskStatus.success) {
            logger.success('\n✅ ${task.message}');
          } else if (task.status == UploadTaskStatus.warning) {
            logger.info('\n⚠️ ${task.message}');
          } else {
            logger.err('\n❌ ${task.message}');
          }
        }

        if (baseBranch == null) {
          logger.info(
            '💡Tip: you can upload a review by specifying a `base-branch` parameter.'
            '\nSee https://docs.widgetbook.io/widgetbook-cloud/review '
            'for more information',
          );
        }

        progress.complete('Build upload completed');

        String? reviewId;
        if (baseBranch != null && baseSha != null) {
          // If generator is not run or not properly configured
          if (useCases.isEmpty) {
            logger.err(
              'Could not find generator files. '
              'Therefore, no review has been created. '
              'Make sure to use widgetbook_generator and '
              'run build_runner before this CLI. '
              'See https://docs.widgetbook.io/widgetbook-cloud/review for more '
              'information.',
            );
            throw ReviewNotFoundException();
          }

          progress.update('Uploading review');
          try {
            final reviewUploadResponse = await uploadReview(
              file: file,
              args: args,
              reviewData: ReviewData(
                useCases: useCases,
                buildId: buildUploadResponse.build,
                projectId: buildUploadResponse.project,
                baseSha: baseSha,
              ),
            );
            reviewId = reviewUploadResponse?.review.id;
            progress.complete('Uploaded review');
          } catch (_) {
            throw WidgetbookApiException();
          }
        }

        if (args.prNumber != null) {
          if (args.gitHubToken != null) {
            await GithubProvider(
              apiKey: args.gitHubToken!,
            ).addBuildComment(
              buildInfo: buildUploadResponse,
              number: args.prNumber!,
              reviewId: reviewId,
            );
          }
        }

        deleteZip(file);
      } else {
        logger.err('Could not create .zip file for upload.');
        throw UnableToCreateZipFileException();
      }
    } catch (e) {
      progress.fail();
      rethrow;
    }
  }
}
