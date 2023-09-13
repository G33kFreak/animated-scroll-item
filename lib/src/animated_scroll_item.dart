import 'package:animated_scroll_item/src/animated_scroll_item_delegate.dart';
import 'package:animated_scroll_item/src/types.dart';
import 'package:flutter/material.dart';

class AnimatedScrollItem extends StatelessWidget {
  final Size size;
  final List<ItemAnimationConfig> configs;
  final Widget child;

  const AnimatedScrollItem({
    Key? key,
    required this.size,
    this.configs = const [],
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.loose(size),
      child: Builder(
        builder: (context) => Flow(
          delegate: AnimatedScrollItemDelegate(
            scrollableState: Scrollable.of(context),
            listItemContext: context,
          ),
          children: [child],
        ),
      ),
    );
  }
}
