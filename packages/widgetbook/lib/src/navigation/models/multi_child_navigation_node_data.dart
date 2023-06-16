import 'navigation_node_data_interface.dart';

class MultiChildNavigationNodeData extends NavigationNodeDataInterface {
  const MultiChildNavigationNodeData({
    required super.name,
    required super.children,
    required super.type,
    super.data,
    super.isInitiallyExpanded,
  });

  @override
  String toString() {
    return 'MultiChildNavigationNodeData('
        'name: $name, '
        'type: $type, '
        'data: $data, '
        'children: $children, '
        'isInitiallyExpanded: $isInitiallyExpanded '
        ')';
  }
}
