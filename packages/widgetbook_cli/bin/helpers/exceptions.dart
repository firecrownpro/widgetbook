/// {@template widgetbook_exception}
/// An exception thrown by an internal widgetbook command.
/// {@endtemplate}
abstract class WidgetbookException implements Exception {
  /// {@macro widgetbook_exception}
  WidgetbookException(this.message);

  /// The error message which will be displayed to the user .
  final String message;

  @override
  String toString() => message;
}

class CiVendorNotSupported extends WidgetbookException {
  CiVendorNotSupported({
    String? message,
  }) : super(
          message ?? 'Your CI/CD pipeline provider is currently not supported.',
        );
}

class ExitedByUser extends WidgetbookException {
  ExitedByUser({
    String? message,
  }) : super(message ?? 'Program exited based on user input.');
}

class DirectoryNotFoundException implements WidgetbookException {
  DirectoryNotFoundException({String? message})
      : _message = message ??= 'Directory does not exist.';

  final String? _message;

  @override
  String get message => _message!;
}

class GitDirectoryNotFound extends WidgetbookException {
  GitDirectoryNotFound({
    String? message,
  }) : super(message ?? 'Argument "path" is not a Git directory.');
}

class ReviewNotFoundException extends WidgetbookException {
  ReviewNotFoundException({String? message})
      : super(
          message ?? 'No review information found',
        );
}

class FileNotFoundException implements WidgetbookException {
  FileNotFoundException({String? message})
      : _message = message ??= 'File does not exist.';

  final String? _message;

  @override
  String get message => _message!;
}

class ActorNotFoundException implements WidgetbookException {
  ActorNotFoundException({String? message})
      : _message = message ??= 'Actor is a required parameter.';

  final String? _message;

  @override
  String get message => _message!;
}

class RepositoryNotFoundException implements WidgetbookException {
  RepositoryNotFoundException({String? message})
      : _message = message ??= 'Respository is a required parameter.';

  final String? _message;

  @override
  String get message => _message!;
}

class WidgetbookApiException implements WidgetbookException {
  WidgetbookApiException({String? message})
      : _message = message ??=
            'An Error occurred while uploading the build to Widgetbook Cloud.';

  final String? _message;

  @override
  String get message => _message!;
}

class UnableToCreateZipFileException implements WidgetbookException {
  UnableToCreateZipFileException({String? message})
      : _message = message ??= 'Could not create .zip file for upload.';

  final String? _message;

  @override
  String get message => _message!;
}
