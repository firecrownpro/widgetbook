import 'package:meta/meta.dart';

import '../navigation/navigation.dart';

@internal
class WidgetbookCatalog {
  WidgetbookCatalog._(
    Map<String, WidgetbookUseCase> useCases,
  ) : _useCases = useCases;

  factory WidgetbookCatalog.fromRoot(WidgetbookNode root) {
    final entries = root.leaves
        .whereType<WidgetbookUseCase>()
        .map((node) => MapEntry(node.path, node));

    final useCases = Map.fromEntries(entries);

    return WidgetbookCatalog._(useCases);
  }

  final Map<String, WidgetbookUseCase> _useCases;

  WidgetbookUseCase? get(String path) => _useCases[path];
}
