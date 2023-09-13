import 'package:animated_scroll_item/animated_scroll_item.dart';
import 'package:flutter/material.dart';

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
              animationRange: AnimationRange(max: .5),
              itemTransform: (double animationValue, Matrix4 matrix) {
                return matrix..scale(animationValue);
              },
              opacityTransform: (animationValue) => animationValue,
            ),
          ],
          size: const Size(double.infinity, 120),
          child: SizedBox(
            height: 120,
            child: Card(
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
