import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_core/widgetbook_core.dart';
import 'package:widgetbook_for_widgetbook/settings/widgets/helper.dart';

@UseCase(name: 'Default', type: SettingSection)
Widget settingSection(BuildContext context) {
  return frameSettingSection(context);
}
