import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

import '../../../helper/callback_mock.dart';
import '../../../helper/widget_tester_extension.dart';

void main() {
  group(
    '$NavigationTree',
    () {
      const directories = [
        MultiChildNavigationNodeData(
          name: 'Component',
          type: NavigationNodeType.component,
          children: [
            MultiChildNavigationNodeData(
              name: 'Use Case 1',
              type: NavigationNodeType.useCase,
              children: [],
            ),
          ],
        ),
        MultiChildNavigationNodeData(
          name: 'Category',
          type: NavigationNodeType.category,
          children: [],
        ),
      ];

      testWidgets(
        'selectedNode gets updated when a node is tapped',
        (WidgetTester tester) async {
          await tester.pumpWidgetWithMaterial(
            child: const NavigationTree(
              directories: directories,
            ),
          );

          const node = NavigationTreeNodeData(
            path: 'component/use-case-1',
            name: 'Use Case 1',
            type: NavigationNodeType.useCase,
          );

          await tester.tap(
            find.byWidgetPredicate(
              (widget) =>
                  widget is NavigationTreeItem && widget.data.name == node.name,
            ),
          );

          final state = tester.state<NavigationTreeState>(
            find.byType(NavigationTree),
          );

          expect(state.selectedNode?.name, node.name);
        },
      );

      testWidgets(
        'Calls onNodeSelected when a node is tapped',
        (WidgetTester tester) async {
          final callbackMock = OnNodeSelectedCallbackMock<String, dynamic>();

          await tester.pumpWidgetWithMaterial(
            child: NavigationTree(
              directories: directories,
              onNodeSelected: callbackMock.call,
            ),
          );

          const node = NavigationTreeNodeData(
            path: 'component/use-case-1',
            name: 'Use Case 1',
            type: NavigationNodeType.useCase,
          );

          await tester.tap(
            find.byWidgetPredicate(
              (widget) =>
                  widget is NavigationTreeItem && widget.data.name == node.name,
            ),
          );

          verify(
            () => callbackMock(node.path, node.data),
          ).called(1);
        },
      );
    },
  );
}
