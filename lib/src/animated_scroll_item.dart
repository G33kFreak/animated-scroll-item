import 'package:animated_scroll_item/src/animated_scroll_item_delegate.dart';
import 'package:animated_scroll_item/src/types.dart';
import 'package:flutter/material.dart';

class AnimatedScrollItem extends StatelessWidget {
  ///
  /// How much space your item takes, required field
  ///
  final Size size;

  ///
  /// List of transforms configs, it's where you actually define how your animation looks like, cannot be empty
  ///
  final List<ItemAnimationConfig> configs;

  ///
  /// Your list item [Widget]
  ///
  final Widget child;

  ///
  /// Wrap your list item widget with this and provide its configuration
  ///
  /// * [size] - How much space your item takes, required field
  /// * [configs] - List of transforms configs, it's where you actually define how your animation looks like, cannot be empty
  /// * [child] - Your list item [Widget]
  ///
  /// ```dart
  /// AnimatedScrollItem(
  ///   configs: [
  ///     ItemAnimationConfig(
  ///       animationRange: const AnimationRange(min: 0, max: .1),
  ///       itemTransform: (
  ///         double animationValue,
  ///         Size size,
  ///         Matrix4 matrix,
  ///       ) {
  ///         return matrix
  ///           ..scale(animationValue)
  ///           ..setTranslation(
  ///               Vector3(size.width * (1 - animationValue) * .5, 0, 0));
  ///       },
  ///       opacityTransform: (animationValue) => animationValue,
  ///     ),
  ///   ],
  ///   size: const Size(double.infinity, 120),
  ///   child: SizedBox(
  ///     height: 120,
  ///     child: Card(
  ///       color: Colors.blue,
  ///       child: Center(
  ///         child: Text('$index'),
  ///       ),
  ///     ),
  ///   ),
  /// ),
  /// ```
  ///
  const AnimatedScrollItem({
    Key? key,
    required this.size,
    required this.configs,
    required this.child,
  })  : assert(configs.length > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.loose(size),
      child: Builder(
        builder: (context) => Flow(
          delegate: AnimatedScrollItemDelegate(
            scrollableState: Scrollable.of(context),
            listItemContext: context,
            itemAnimationConfigs: configs,
          ),
          children: [child],
        ),
      ),
    );
  }
}
