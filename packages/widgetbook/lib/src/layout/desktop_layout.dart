import 'package:flutter/material.dart';
import 'package:resizable_widget/resizable_widget.dart';

import '../settings/settings.dart';
import '../state/state.dart';
import 'base_layout.dart';

class DesktopLayout extends StatelessWidget implements BaseLayout {
  const DesktopLayout({
    super.key,
    required this.navigationBuilder,
    required this.addonsBuilder,
    required this.knobsBuilder,
    required this.workbench,
  });

  final Widget Function(BuildContext context) navigationBuilder;
  final List<Widget> Function(BuildContext context) addonsBuilder;
  final List<Widget> Function(BuildContext context) knobsBuilder;
  final Widget workbench;

  @override
  Widget build(BuildContext context) {
    final state = WidgetbookState.of(context);

    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: ResizableWidget(
        separatorSize: 2,
        percentages: [0.2, 0.6, 0.2],
        separatorColor: Colors.white24,
        children: [
          ExcludeSemantics(
            child: navigationBuilder(context),
          ),
          workbench,
          ExcludeSemantics(
            child: SettingsPanel(
              settings: [
                if (state.addons != null) ...{
                  SettingsPanelData(
                    name: 'Addons',
                    builder: addonsBuilder,
                  ),
                },
                SettingsPanelData(
                  name: 'Knobs',
                  builder: knobsBuilder,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
