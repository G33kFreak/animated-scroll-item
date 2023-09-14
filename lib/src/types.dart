import 'package:flutter/rendering.dart';

typedef ItemTransformAnimation = Matrix4 Function(
  double animationValue,
  Size itemSize,
  Matrix4 matrix,
);
typedef ItemOpacityTransform = double Function(double animationValue);

class AnimationRange {
  ///
  /// where animation starts `animationValue` will be `0` here. Has to be in range from `0` to `1`
  ///
  final double min;

  ///
  /// where animation ends `animationValue` will be `1` here. Has to be in range from `0` to `1`
  ///
  final double max;

  ///
  /// Defines the part of visible scrollable widget where animation starts and ends
  /// * [min] - where animation starts `animationValue` will be `0` here
  /// * [max] - where animation ends `animationValue` will be `1` here
  ///
  /// ```dart
  /// const AnimationRange(min: 0, max: .5) // animation applies at the first half of the visible scrollable widget
  /// ```
  ///
  const AnimationRange({
    this.min = 0,
    this.max = 1,
  })  : assert(max > min),
        assert(max >= 0 && max <= 1),
        assert(min >= 0 && min <= 1);
}

class ItemAnimationConfig {
  ///
  /// Defines how your widget will be transformed based on its [animationValue]
  /// * [animationValue] value from `0` to `1` in provided range, where `0` - start of range, `1` - end of range
  /// * [itemSize] size of provided widget, can be useful for transitions or other types of transform
  /// * [matrix] the [Matrix4] of your widget, you should to apply your transforms on this field
  ///
  /// ```dart
  /// itemTransform: (
  ///   double animationValue,
  ///   Size size,
  ///   Matrix4 matrix,
  /// ) {
  ///   return matrix
  ///     ..scale(animationValue)
  ///     ..setTranslation(
  ///         Vector3(size.width * (1 - animationValue) * .5, 0, 0));
  /// },
  /// ```
  ///
  final ItemTransformAnimation itemTransform;

  ///
  /// Defines opacitry behavior based on [animationValue]
  ///
  /// ```dart
  /// opacityTransform: (animationValue) => animationValue // will not be visible at the end of [animationRange]
  /// ```
  ///
  final ItemOpacityTransform? opacityTransform;

  ///
  /// The range which defines part of visible scrollable widget where animation starts and ends
  ///
  /// ```dart
  /// animationRange: const AnimationRange(min: 0, max: .5) // animation applies at the first half of the visible scrollable widget
  /// ```
  ///
  final AnimationRange animationRange;

  ///
  /// Configuration of animation for your item
  /// * [itemTransform] - defines how your widget will transform based on animation value
  /// * [animationRange] - the range which defines part of visible scrollable widget where animation starts and ends
  /// * [opacityTransform] - opacity which also can be changed based on animation value
  ///
  /// ```dart
  /// ItemAnimationConfig(
  ///   animationRange: const AnimationRange(min: 0, max: .1),
  ///   itemTransform: (
  ///     double animationValue,
  ///     Size size,
  ///     Matrix4 matrix,
  ///   ) {
  ///     return matrix
  ///       ..scale(animationValue)
  ///       ..setTranslation(
  ///           Vector3(size.width * (1 - animationValue) * .5, 0, 0));
  ///   },
  ///   opacityTransform: (animationValue) => animationValue,
  /// )
  /// ```
  ///
  const ItemAnimationConfig({
    required this.itemTransform,
    this.animationRange = const AnimationRange(),
    this.opacityTransform,
  });
}
