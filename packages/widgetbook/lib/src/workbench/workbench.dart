import 'package:flutter/material.dart';

import '../state/state.dart';
import 'renderer.dart';
import 'safe_boundaries.dart';

class Workbench extends StatelessWidget {
  const Workbench({super.key});

  @override
  Widget build(BuildContext context) {
    final state = WidgetbookState.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(
            8,
          ),
        ),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: SafeBoundaries(
        child: state.useCase == null
            ? Container()
            : Renderer(
                appBuilder: state.appBuilder,
                useCaseBuilder: state.useCase!.builder,
              ),
      ),
    );
  }
}
