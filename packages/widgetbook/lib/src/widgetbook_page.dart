import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/addon_injector_widget.dart';
import 'package:widgetbook/src/addons/addon_provider.dart';
import 'package:widgetbook/src/settings_panel/settings_panel.dart';
import 'package:widgetbook/src/styled_widgets/styled_scaffold.dart';
import 'package:widgetbook/src/workbench/workbench.dart';

class WidgetbookPage extends StatelessWidget {
  const WidgetbookPage({
    required this.disableProperties,
    required this.disableAddOns,
    required this.routerData,
    super.key,
  });

  final bool disableProperties;
  final bool disableAddOns;
  final Map<String, String> routerData;

  @override
  Widget build(BuildContext context) {
    return StyledScaffold(
      body: Builder(
        builder: (context) {
          final addons = context.watch<AddOnProvider>().value;

          return AddonInjectorWidget(
            addons: addons,
            routerData: routerData,
            child: Row(
              children: [
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 2),
                    child: Workbench(),
                  ),
                ),
                if (!disableProperties)
                  SizedBox(
                    width: 400,
                    child: SettingsPanel(
                      disableAddOns: disableAddOns,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
