Wrapper for the scrollable items (e.g. SingleChildScrollView, ListView). It allows you to highly customize behavior of visible items. Based on [Flow widget](https://api.flutter.dev/flutter/widgets/Flow-class.html)

<p>
  <img src="https://github.com/G33kFreak/animated-scroll-item/blob/main/doc/example1.gif?raw=true"
    alt="example" height="400"/>
  &nbsp;&nbsp;&nbsp;&nbsp;
</p>


> **_NOTE:_** keep in mind it hasn't been tested for large lists

## Getting started

### Installing

```yaml
dependencies:
  animated_scroll_item: ^0.0.3
```

### Import

```dart
import 'package:animated_scroll_item/animated_scroll_item.dart';
```

## How to use

Wrap your item widget with `AnimatedScrollItem` and provide its configuration:

```dart
AnimatedScrollItem(
  configs: [
    ItemAnimationConfig(
        // ...animation config
    ),
    ItemAnimationConfig(
        // ...another animation config
    ),
  ],
  size: const Size(double.infinity, 120), // The size is required
  // Provide your widget
  child: SizedBox(
    height: 120,
    child: Card(
      color: Colors.blue,
      child: Center(
        child: Text('$index'),
      ),
    ),
  ),
),
```

## Configuration

### `AnimatedScrollItem`

| Param     | Description                                                                          | Type                          | Default value  |
| --------- | ------------------------------------------------------------------------------------ | ----------------------------- | -------------- |
| `size`    | The size of space each item takes                                                    | `Size`                        | required field |
| `configs` | List of animation configs, you can define as many as you want, but not less than one | `List\<ItemAnimationConfig\>` | required field |
| `child`   | Your list item                                                                       | `Widget`                      | required field |

### `ItemAnimationConfig`

| Param              | Description                                                                                                          | Type                     | Default value                    |
| ------------------ | -------------------------------------------------------------------------------------------------------------------- | ------------------------ | -------------------------------- |
| `itemTransform`    | Callback which defines behavior of animated item based on animation value.                                           | `ItemTransformAnimation` | required field                   |
| `opacityTransform` | Defines the opacity of animated item based on animation value                                                        | `ItemOpacityTransform`   | `null`                           |
| `animationRange`   | Range of position on visible area of list, where item has to be animated. `1` - the end of visible area, `0` - start | `AnimationRange`         | `AnimationRange(min: 0, max: 1)` |

### `ItemTransformAnimation`

Callback which provides you `animationValue` in range from `0` to `1`, `itemSize` also can be useful for your animations, and `matrix`, the object of `Matrix4` on which you have to apply your transforms.

Example:
```dart
itemTransform: (
  double animationValue,
  Size size,
  Matrix4 matrix,
) {
  return matrix
    ..scale(animationValue)
    ..setTranslation(
        Vector3(size.width * (1 - animationValue) * .5, 0, 0));
},
```

### `ItemOpacityTransform`

This callback allows you to define opacity depending on `animationValue`

Example:
```dart
opacityTransform: (animationValue) => animationValue
```

### `AnimationRange`

Here you can define part of visible list where items has to be animated. It takes values from `0` to `1`.
Example:
```dart
animationRange: const AnimationRange(min: 0, max: .1),
```

## Contributing

Feel free to create PR or open issue :)
