import 'package:animated_scroll_item/src/types.dart';
import 'package:flutter/widgets.dart';

class AnimatedScrollItemDelegate extends FlowDelegate {
  final ScrollableState scrollableState;
  final BuildContext listItemContext;
  final List<ItemAnimationConfig> itemAnimationConfigs;

  AnimatedScrollItemDelegate({
    required this.scrollableState,
    required this.listItemContext,
    this.itemAnimationConfigs = const [],
  }) : super(repaint: scrollableState.position);

  @override
  void paintChildren(FlowPaintingContext context) {
    if (itemAnimationConfigs.isNotEmpty) {
      final scrollableBox =
          scrollableState.context.findRenderObject() as RenderBox;
      final listItemBox = listItemContext.findRenderObject() as RenderBox;
      final listItemOffset = listItemBox.localToGlobal(
        listItemBox.size.centerLeft(Offset.zero),
        ancestor: scrollableBox,
      );

      final viewportDimension = scrollableState.position.viewportDimension;
      final scrollFraction = (listItemOffset.dy / viewportDimension).clamp(
        0.0,
        1.0,
      );

      for (final config in itemAnimationConfigs) {
        final needAnimate = config.threshold.comparer.call(scrollFraction);

        if (needAnimate) {
          final animationValue =
              (1 - scrollFraction) / config.threshold.threshold;

          context.paintChild(
            0,
            transform: config.itemTransform.call(animationValue),
            opacity: config.opacityTransform?.call(animationValue) ?? 1,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) => false;
}
