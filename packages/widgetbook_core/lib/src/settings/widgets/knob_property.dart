import 'package:flutter/material.dart';

import 'setting.dart';

class KnobProperty<T> extends StatefulWidget {
  const KnobProperty({
    super.key,
    required this.name,
    this.description,
    required this.value,
    required this.child,
    this.isNullable = false,
    this.trailing,
    this.changedNullable,
  });

  final String name;
  final String? description;
  final T value;
  final bool isNullable;

  final Widget child;
  final Widget? trailing;
  final void Function(bool isNull)? changedNullable;

  @override
  State<KnobProperty<T>> createState() => _KnobPropertyState<T>();
}

class _KnobPropertyState<T> extends State<KnobProperty<T>> {
  late bool isNull;

  @override
  void initState() {
    super.initState();
    isNull = widget.value == null;
  }

  @override
  Widget build(BuildContext context) {
    final trailingWidget = widget.trailing;
    return Setting(
      name: widget.name,
      trailing: trailingWidget != null || widget.isNullable
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (trailingWidget != null) trailingWidget,
                if (trailingWidget != null && widget.isNullable)
                  const SizedBox(
                    width: 8,
                  ),
                if (widget.isNullable)
                  Checkbox(
                    value: isNull,
                    onChanged: (value) {
                      setState(() {
                        isNull = value!;
                      });
                      widget.changedNullable?.call(value!);
                    },
                  ),
              ],
            )
          : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.description != null) ...{
              Text(widget.description!),
              const SizedBox(
                height: 4,
              ),
            },
            widget.child
          ],
        ),
      ),
    );
  }
}
