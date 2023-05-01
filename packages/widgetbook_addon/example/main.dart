import 'package:flutter/material.dart';
import 'package:widgetbook_addon/widgetbook_addon.dart';

class CustomAddOnSetting extends WidgetbookAddOnModel<CustomAddOnSetting> {
  const CustomAddOnSetting({
    required this.data,
  });

  final String data;

  @override
  Map<String, String> toMap() {
    return {
      'data': data,
    };
  }

  @override
  CustomAddOnSetting fromMap(Map<String, String> map) {
    return CustomAddOnSetting(
      data: map['data']!,
    );
  }
}

class CustomAddOn extends WidgetbookAddOn<CustomAddOnSetting> {
  CustomAddOn({
    required super.initialSetting,
  }) : super(
          name: 'Custom',
        );

  @override
  Widget buildSetting(BuildContext context) {
    return Placeholder();
  }
}
