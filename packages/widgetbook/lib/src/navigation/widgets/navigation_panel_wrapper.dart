import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

import '../../state/state.dart';

class NavigationPanelWrapper extends StatelessWidget {
  const NavigationPanelWrapper({
    super.key,
    this.initialPath,
  });

  final String? initialPath;

  @override
  Widget build(BuildContext context) {
    return NavigationPanel(
      initialPath: initialPath,
      onNodeSelected: (path, _) {
        context.read<KnobsNotifier>().clear();
        WidgetbookScope.of(context).updatePath(path);
      },
    );
  }
}
