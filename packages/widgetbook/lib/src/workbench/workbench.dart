import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/builder/provider/builder_provider.dart';
import 'package:widgetbook/src/constants/radii.dart';
import 'package:widgetbook/src/navigation/providers/use_cases_provider.dart';

import 'renderer.dart';
import 'safe_boundaries.dart';

class Workbench extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appBuilder = context.watch<BuilderProvider>().value.appBuilder;
    final state = context.watch<UseCasesProvider>().value;
    final useCaseBuilder = state.selectedUseCase?.builder;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: Radii.defaultRadius,
        color: Theme.of(context).colorScheme.surface,
      ),
      child: SafeBoundaries(
        child: useCaseBuilder == null
            ? Container()
            : Renderer(
                appBuilder: appBuilder,
                useCaseBuilder: useCaseBuilder,
              ),
      ),
    );
  }
}
