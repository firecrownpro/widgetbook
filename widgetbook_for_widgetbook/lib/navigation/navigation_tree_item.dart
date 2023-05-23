import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

@UseCase(name: 'Default', type: NavigationTreeItem)
Widget navigationTreeItemWithout(BuildContext context) {
  final nodeType = context.knobs.list<NavigationNodeType>(
    label: 'Node Type',
    options: NavigationNodeType.values,
  );

  return Column(
    children: [
      NavigationTreeItem(
        data: NavigationTreeNodeData(
          path: 'name',
          name: context.knobs.string(
            label: 'Name',
            initialValue: 'Category',
          ),
          type: nodeType,
        ),
        level: context.knobs.double
            .slider(
              label: 'Level',
              initialValue: 0,
              min: 0,
              max: 20,
              divisions: 20,
            )
            .toInt(),
        onTap: () {},
        onMoreIconPressed: () {},
        isExpanded: context.knobs.boolean(
          label: 'Is Expanded',
          description: 'Only '
              '(${NavigationNodeType.expandableTypes.map(
                    (e) => e.name,
                  ).join(', ')}) '
              'type(s) can be expanded',
        ),
        isSelected: context.knobs.boolean(
          label: 'Is Selected',
          description: 'Only '
              '(${NavigationNodeType.selectableTypes.map(
                    (e) => e.name,
                  ).join(', ')}) '
              'type(s) can be selected',
        ),
      ),
    ],
  );
}
