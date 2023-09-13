import 'package:flutter/rendering.dart';

typedef ItemTransformAnimation = Matrix4 Function(
  double animationValuen,
  Matrix4 matrix,
);
typedef ItemOpacityTransform = double Function(double animationValue);

class AnimationRange {
  final double min;
  final double max;

  const AnimationRange({
    this.min = 0,
    this.max = 1,
  })  : assert(max > min),
        assert(max >= 0 && max <= 1),
        assert(min >= 0 && min <= 1);
}

class ItemAnimationConfig {
  final ItemTransformAnimation itemTransform;
  final ItemOpacityTransform? opacityTransform;
  final AnimationRange animationRange;

  const ItemAnimationConfig({
    required this.itemTransform,
    this.animationRange = const AnimationRange(),
    this.opacityTransform,
  });
}
