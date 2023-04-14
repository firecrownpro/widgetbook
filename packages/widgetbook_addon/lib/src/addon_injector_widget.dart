import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

import 'widgetbook_addon.dart';

class AddonInjectorWidget extends StatelessWidget {
  const AddonInjectorWidget({
    required this.addons,
    required this.routerData,
    required this.child,
    super.key,
  });

  final List<WidgetbookAddOn> addons;
  final Widget child;
  final Map<String, String> routerData;

  @override
  Widget build(BuildContext context) {
    return addons.isEmpty
        ? child
        : Nested(
            key: ValueKey(routerData),
            children: [
              ...addons.map(
                (e) => SingleChildBuilder(
                  builder: (context, child) => e.buildProvider(
                    context,
                    routerData,
                    child!,
                  ),
                ),
              ),
            ],
            child: child,
          );
  }
}
