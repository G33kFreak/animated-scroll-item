import 'package:animated_scroll_item/animated_scroll_item.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 30,
        itemBuilder: (context, index) => AnimatedScrollItem(
          configs: [
            ItemAnimationConfig(
              animationRange: const AnimationRange(min: 0, max: .1),
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
              opacityTransform: (animationValue) => animationValue,
            ),
            ItemAnimationConfig(
              animationRange: const AnimationRange(min: .9),
              itemTransform: (
                double animationValue,
                Size size,
                Matrix4 matrix,
              ) {
                return matrix
                  ..scale(1 - animationValue)
                  ..setTranslation(Vector3(size.width * animationValue, 0, 0));
              },
              opacityTransform: (animationValue) => 1 - animationValue,
            ),
          ],
          size: const Size(double.infinity, 120),
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
      ),
    );
  }
}
