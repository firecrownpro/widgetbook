import 'package:code_builder/code_builder.dart';
import 'package:test/test.dart';
import 'package:widgetbook_generator/src/code/widgetbook_category_instance.dart';
import 'package:widgetbook_generator/widgetbook_generator.dart';

import '../../helpers/mock_use_case_metadata.dart';

void main() {
  group('$Tree', () {
    test('[getPathParts] for package path', () {
      final parts = Tree.getPathParts(
        'package:name/tree/tree.dart',
      );

      expect(parts, equals(['tree']));
    });

    test('[getPathParts] for package path with src', () {
      final parts = Tree.getPathParts(
        'package:name/src/tree/tree.dart',
      );

      expect(parts, equals(['tree']));
    });

    test('[build] creates the correct tree', () {
      final useCases = [
        MockUseCaseMetadata(
          componentName: 'Alpha',
          pathInWidgetbook: 'widgets/alpha',
        ),
        MockUseCaseMetadata(
          componentName: 'Beta',
          pathInWidgetbook: 'widgets/beta',
        ),
      ];

      final root = Tree.build(useCases);

      expect(
        root.children.keys,
        equals(['widgets']),
      );

      expect(
        root.children['widgets']!.children.keys,
        equals(['alpha', 'beta']),
      );

      expect(
        root.children['widgets']!.children['alpha']!.children.keys,
        equals(['Alpha']),
      );

      expect(
        root.children['widgets']!.children['beta']!.children.keys,
        equals(['Beta']),
      );
    });

    test('[instances] creates Categories for bracket path segments', () {
      final useCases = [
        MockUseCaseMetadata(
          componentName: 'PrimaryButton',
          pathInWidgetbook: '[Interactions]/buttons',
        ),
      ];

      final root = Tree.build(useCases);

      expect(root.children.keys, equals(['[Interactions]']));
      expect(root.instances.single, isA<WidgetbookCategoryInstance>());
      expect(
        root.children['[Interactions]']!.instances.single,
        isA<WidgetbookFolderInstance>(),
      );
      final categoryNameExpression =
          root.instances.single.namedArguments['name'];
      expect(categoryNameExpression, isA<LiteralExpression>());
      expect(
        (categoryNameExpression as LiteralExpression).literal,
        // literalString wraps the input in single quotes
        equals("'Interactions'"),
      );
    });

    test('[build] throws exception if duplicates exist', () {
      expect(
        () => Tree.build([
          MockUseCaseMetadata(),
          MockUseCaseMetadata(),
        ]),
        throwsA(isA<DuplicateUseCasesError>()),
      );
    });

    test('[build] returns normally for unique use-cases', () {
      expect(
        () => Tree.build([
          MockUseCaseMetadata(name: 'UseCase 1'),
          MockUseCaseMetadata(name: 'UseCase 2'),
        ]),
        returnsNormally,
      );
    });
  });
}
