import 'package:inspector/inspector.dart';

import 'base/builder_addon.dart';

class InspectorAddon extends BuilderAddon {
  InspectorAddon()
      : super(
          name: 'Inspector',
          builder: (context, child) {
            return Inspector(
              child: child,
            );
          },
        );
}
