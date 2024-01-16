import 'dart:async';

import 'package:args/src/arg_results.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:path/path.dart' as p;
import 'package:process/process.dart';

import '../../widgetbook_cli.dart';
import '../api/models/build_draft_request.dart';
import '../api/models/build_ready_request.dart';
import '../utils/executable_manager.dart';
import 'push_args.dart';

class PushCommand extends CliCommand<PushArgs> {
  PushCommand({
    required super.context,
    this.processManager = const LocalProcessManager(),
    this.fileSystem = const LocalFileSystem(),
    this.zipEncoder = const ZipEncoder(),
    this.useCaseReader = const UseCaseReader(),
  })  : client = WidgetbookHttpClient(
          environment: context.environment,
        ),
        super(
          name: 'push',
          description: 'Pushes a new build to Widgetbook Cloud',
        ) {
    argParser
      ..addOption(
        'api-key',
        help: 'The project specific API key for Widgetbook Cloud.',
        mandatory: true,
      );
  }

  final WidgetbookHttpClient client;
  final ProcessManager processManager;
  final FileSystem fileSystem;
  final ZipEncoder zipEncoder;
  final UseCaseReader useCaseReader;

  @override
  FutureOr<PushArgs> parseResults(Context context, ArgResults results) {
    return PushArgs(
      apiKey: results['api-key'] as String,
      versionControlProvider: 'github', // TODO
      repository: 'widgetbook', // TODO
      actor: 'widgetbook', // TODO
      branch: 'main', // TODO
      headSha: 'TODO', // TODO
      baseSha: 'TODO', // TODO
    );
  }

  @override
  FutureOr<int> runWith(Context context, PushArgs args) async {
    final lockPath = p.join('pubspec.lock'); // TODO: custom path
    final versions = await VersionsMetadata.from(
      lockFile: fileSystem.file(lockPath),
      flutterVersionOutput: await processManager.runFlutter(['--version']),
    );

    final draftProgress = logger.progress('Creating build draft');
    final buildDraft = await client.createBuildDraft(
      versions,
      BuildDraftRequest(
        apiKey: args.apiKey,
        versionControlProvider: args.versionControlProvider,
        repository: args.repository,
        actor: args.actor,
        branch: args.branch,
        headSha: args.headSha,
        baseSha: args.baseSha,
        useCases: await useCaseReader.read('.'), // TODO: custom path
      ),
    );

    final buildId = buildDraft.buildId;
    final signedUrl = buildDraft.storageUrl;
    draftProgress.complete('Build draft [$buildId] created');

    final archiveProgress = logger.progress('Creating build archive');
    final buildDirPath = p.join('build', 'web'); // TODO: custom path
    final buildDir = fileSystem.directory(buildDirPath);
    final zipFile = await zipEncoder.zip(buildDir, '$buildId.zip');

    if (zipFile == null) {
      archiveProgress.fail('Failed to create build archive');
      return 23;
    }

    archiveProgress.complete('Build archive created at ${zipFile.path}');

    final uploadProgress = logger.progress('Uploading build archive');
    await client.uploadBuildFile(signedUrl, zipFile);
    uploadProgress.complete('Build archive uploaded');

    final submitProgress = logger.progress('Submitting build');
    final response = await client.submitBuildDraft(
      BuildReadyRequest(
        apiKey: args.apiKey,
        buildId: buildId,
      ),
    );

    submitProgress.complete('Build ready at ${response.buildUrl}');

    return 0;
  }
}