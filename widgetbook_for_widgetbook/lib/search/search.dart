import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

@UseCase(name: 'Default', type: SearchField)
Widget searchFieldDefaultUseCase(BuildContext context) {
  return const SearchField();
}
