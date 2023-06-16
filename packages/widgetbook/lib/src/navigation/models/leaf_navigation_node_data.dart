import 'navigation_node_data_interface.dart';

class LeafNavigationNodeData extends NavigationNodeDataInterface {
  const LeafNavigationNodeData({
    required super.name,
    required super.type,
    super.data,
    super.isInitiallyExpanded = true,
  });

  @override
  String toString() {
    return 'LeafNavigationNodeData('
        'name: $name, '
        'type: $type, '
        'data: $data, '
        'isInitiallyExpanded: $isInitiallyExpanded '
        ')';
  }
}
