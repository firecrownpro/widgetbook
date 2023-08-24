import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:path/path.dart' as path;
import 'package:source_gen/source_gen.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../instances/instance.dart';
import '../instances/list_instance.dart';
import '../instances/widgetbook_folder_instance.dart';
import '../instances/widgetbook_widget_instance.dart';
import '../models/use_case_metadata.dart';
import 'tree_service.dart';

/// Generates the code for Widgetbook
///
/// The code is located at the same location in which the [App]
/// annotation is used.
class AppGenerator extends GeneratorForAnnotation<App> {
  @override
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    final useCases = await loadDataFromJson<UseCaseMetadata>(
      buildStep,
      '**.usecase.widgetbook.json',
      UseCaseMetadata.fromJson,
    );

    // The directory containing the `widgetbook.dart` file
    // without the leading `/`
    final inputPath = element.librarySource!.fullName;
    final inputDir = path.dirname(inputPath).substring(1);

    final buffer = StringBuffer()
      ..writeln(generateImports(useCases, inputDir))
      ..writeln(generateDirectories(useCases));

    return buffer.toString();
  }

  Future<List<T>> loadDataFromJson<T>(
    BuildStep buildStep,
    String extension,
    T Function(Map<String, dynamic> map) fromMap,
  ) async {
    final glob = Glob(extension);
    final widgetbookData = <T>[];

    await for (final id in buildStep.findAssets(glob)) {
      final dynamic content = jsonDecode(await buildStep.readAsString(id));
      final decodedJson = content as List;
      final jsons = decodedJson.cast<Map<String, dynamic>>();
      final something = jsons.map<T>((json) {
        return fromMap(json);
      }).toList();

      widgetbookData.addAll(something);
    }

    return widgetbookData;
  }

  /// Generates the directories of Widgetbook
  String generateDirectories(
    List<UseCaseMetadata> useCases,
  ) {
    final directories = _generateDirectoriesInstances(useCases);

    final instance = ListInstance(
      instances: directories,
      type: 'WidgetbookNode',
    ).toCode();

    return 'final directories = $instance;';
  }

  /// generates the imports for all the types used
  ///
  /// the code returned likely contains unneccesary imports
  /// but this implementation is simple in comparison to a complex approach
  String generateImports(
    List<UseCaseMetadata> useCases,
    String inputDir,
  ) {
    final set = <String>{
      'package:widgetbook/widgetbook.dart',
      ...useCases.map((useCase) => useCase.importUriRelative(inputDir)),
    };

    final statements = set.map((uri) => "import '$uri';").toList()
      ..sort((a, b) => a.compareTo(b));

    return statements.join('\n');
  }

  List<Instance> _generateDirectoriesInstances(
    List<UseCaseMetadata> useCases,
  ) {
    final service = TreeService();

    for (final useCase in useCases) {
      final folder = service.addFolderByImport(
        useCase.component.importUri,
      );

      service.addStoryToFolder(folder, useCase);
    }

    return [
      ...service.folders.values.map(
        (e) => WidgetbookFolderInstance(folder: e),
      ),
      ...service.rootFolder.widgets.values.map(
        (e) => WidgetbookComponentInstance(
          name: e.name,
          stories: e.stories,
        ),
      ),
    ];
  }
}
