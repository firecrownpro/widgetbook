import 'package:flutter/material.dart';

import '../icons/icons.dart';
import '../icons/resolve_icon.dart';
import '../nodes/nodes.dart';

class NavigationTreeItem extends StatelessWidget {
  const NavigationTreeItem({
    super.key,
    required this.data,
    this.level = 0,
    this.onTap,
    this.isExpanded = false,
    this.isSelected = false,
  });

  static const double indentation = 25;
  static const double iconSize = 34;

  final int level;
  final TreeNode data;
  final VoidCallback? onTap;
  final bool isExpanded;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final _isSelected = data.isLeaf && isSelected;

    return Material(
      elevation: _isSelected ? 3 : 0,
      shadowColor: _isSelected ? Colors.black : Colors.transparent,
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(iconSize),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(iconSize),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 2,
          ),
          color: _isSelected
              ? Theme.of(context).colorScheme.secondaryContainer
              : Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(iconSize),
            child: Row(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    level,
                    (index) => const SizedBox(width: indentation),
                  ),
                ),
                SizedBox(
                  width: indentation,
                  child: !data.isLeaf
                      ? ExpanderIcon(
                          isExpanded: isExpanded,
                          size: indentation,
                        )
                      : Container(),
                ),
                SizedBox(
                  width: indentation,
                  child: resolveIcon(data),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    data.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
