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

  bool _checkIfNeedAnimate(AnimationRange range, double currentFraction) {
    return currentFraction >= range.min && currentFraction <= range.max;
  }

  double _calculateRangeFraction(
    AnimationRange range,
    double currentFraction,
  ) {
    final rangeLength = range.max - range.min;
    final fractionInRange = currentFraction - range.min;

    return fractionInRange / rangeLength;
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    if (itemAnimationConfigs.isEmpty) {
      return context.paintChild(0);
    }

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

    Matrix4 matrix = Matrix4.identity();
    double opacity = 1;

    for (final config in itemAnimationConfigs) {
      final needAnimate = _checkIfNeedAnimate(
        config.animationRange,
        scrollFraction,
      );

      if (needAnimate) {
        final animationValue = _calculateRangeFraction(
          config.animationRange,
          scrollFraction,
        );

        matrix = config.itemTransform.call(animationValue, matrix);
        opacity = config.opacityTransform?.call(animationValue) ?? opacity;
      }
    }

    return context.paintChild(0, transform: matrix, opacity: opacity);
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) => false;
}
