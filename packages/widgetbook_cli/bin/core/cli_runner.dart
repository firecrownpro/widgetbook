import 'dart:io';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:pub_updater/pub_updater.dart';

import '../commands/publish.dart';
import '../commands/upgrade.dart';
import '../helpers/helpers.dart';
import 'context.dart';

class CliRunner extends CommandRunner<int> {
  CliRunner({
    required this.context,
    Logger? logger,
    PubUpdater? pubUpdater,
  })  : _logger = logger ?? Logger(),
        _pubUpdater = pubUpdater ?? PubUpdater(),
        super(executableName, packageDescription) {
    argParser.addFlag(
      'version',
      negatable: false,
      help: 'Print the current version.',
    );

    addCommand(
      UpgradeCommand(
        context: context,
        logger: _logger,
        pubUpdater: _pubUpdater,
      ),
    );

    addCommand(
      PublishCommand(
        context: context,
        logger: _logger,
      ),
    );
  }

  final Context context;
  final Logger _logger;
  final PubUpdater _pubUpdater;

  @override
  Future<int> run(Iterable<String> args) async {
    try {
      return await runCommand(parse(args)) ?? ExitCode.success.code;
    } on FormatException catch (e) {
      _logger
        ..err(e.message)
        ..info('')
        ..info(usage);
      return ExitCode.usage.code;
    } on UsageException catch (e) {
      _logger
        ..err(e.message)
        ..info('')
        ..info(e.usage);
      return ExitCode.usage.code;
    } on ProcessException catch (error) {
      _logger.err(error.message);
      return ExitCode.unavailable.code;
    } on GitDirectoryNotFound catch (error) {
      _logger.err(error.message);
      return ExitCode.data.code;
    } on DirectoryNotFoundException catch (error) {
      _logger.err(error.message);
      return ExitCode.usage.code;
    } on ExitedByUser catch (error) {
      _logger.info(error.message);
      return ExitCode.success.code;
    } on FileNotFoundException catch (error) {
      _logger.err(error.message);
      return ExitCode.usage.code;
    } on ReviewNotFoundException catch (error) {
      _logger.warn(error.message);
      return ExitCode.success.code;
    } on WidgetbookApiException catch (error) {
      _logger.err(error.message);
      return ExitCode.software.code;
    } on UnableToCreateZipFileException catch (error) {
      _logger.err(error.message);
      return ExitCode.ioError.code;
    } catch (error) {
      _logger.err(error.toString());
      return ExitCode.software.code;
    }
  }

  @override
  Future<int?> runCommand(ArgResults topLevelResults) async {
    int? exitCode = ExitCode.unavailable.code;
    if (topLevelResults['version'] == true) {
      _logger.info(packageVersion);
      exitCode = ExitCode.success.code;
    } else {
      exitCode = await super.runCommand(topLevelResults);
    }

    if (topLevelResults.command?.name != 'update') {
      await _checkForUpdates();
    }

    return exitCode;
  }

  Future<void> _checkForUpdates() async {
    try {
      final isUpToDate = await _pubUpdater.isUpToDate(
        packageName: packageName,
        currentVersion: packageVersion,
      );

      if (isUpToDate) return;

      final latestVersion = await _pubUpdater.getLatestVersion(
        packageName,
      );

      final changelogLink = lightCyan.wrap(
        styleUnderlined.wrap(
          link(
            uri: Uri.parse(
              'https://pub.dev/packages/widgetbook_cli/versions/$latestVersion/changelog',
            ),
          ),
        ),
      );

      _logger.info(
        '\n${lightYellow.wrap('Update available!')} ${lightCyan.wrap(packageVersion)} \u2192 ${lightCyan.wrap(latestVersion)}\n'
        '${lightYellow.wrap('Changelog:')} $changelogLink\n'
        'Run ${cyan.wrap('$executableName update')} to update',
      );
    } catch (_) {}
  }
}
