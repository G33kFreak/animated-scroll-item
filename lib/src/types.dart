import 'package:flutter/rendering.dart';

typedef ThresholdComparer = bool Function(double scrollFraction);
typedef ItemTransformAnimation = Matrix4 Function(double animationValue);
typedef ItemOpacityTransform = double Function(double animationValue);

class Threshold {
  final double threshold;
  final ThresholdComparer comparer;

  const Threshold._({required this.threshold, required this.comparer});

  factory Threshold.greaterThen(double threshold) => Threshold._(
      threshold: threshold,
      comparer: (double scrollFraction) => scrollFraction > threshold);

  factory Threshold.lowerThen(double threshold) => Threshold._(
      threshold: threshold,
      comparer: (double scrollFraction) => scrollFraction < threshold);

  factory Threshold.equalTo(double threshold) => Threshold._(
      threshold: threshold,
      comparer: (double scrollFraction) => scrollFraction == threshold);

  factory Threshold.greaterOrEqual(double threshold) => Threshold._(
      threshold: threshold,
      comparer: (double scrollFraction) => scrollFraction >= threshold);

  factory Threshold.lowerOrEqual(double threshold) => Threshold._(
      threshold: threshold,
      comparer: (double scrollFraction) => scrollFraction <= threshold);
}

class ItemAnimationConfig {
  final Threshold threshold;
  final ItemTransformAnimation itemTransform;
  final ItemOpacityTransform? opacityTransform;

  const ItemAnimationConfig({
    required this.threshold,
    required this.itemTransform,
    this.opacityTransform,
  });
}
