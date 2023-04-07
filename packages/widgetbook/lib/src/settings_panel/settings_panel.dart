import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/addon_provider.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_core/widgetbook_core.dart' as core;

class SettingsPanel extends StatelessWidget {
  const SettingsPanel({
    required this.disableAddOns,
    super.key,
  });

  final bool disableAddOns;

  @override
  Widget build(BuildContext context) {
    final addons = context.watch<AddOnProvider>().value;
    final knobs = context.watch<KnobsNotifier>().all();
    return Card(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: core.SettingsPanel(
                settings: [
                  if (!disableAddOns) ...{
                    core.SettingsPanelData(
                      name: 'Properties',
                      settings: addons.map((e) => e.build(context)).toList(),
                    ),
                  },
                  core.SettingsPanelData(
                    name: 'Knobs',
                    settings: knobs.map((e) => e.build(context)).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
