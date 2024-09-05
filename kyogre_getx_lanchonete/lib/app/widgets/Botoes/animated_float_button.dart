import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AnimatedFloatingActionButton extends HookWidget {
  final VoidCallback onPress;

  const AnimatedFloatingActionButton(this.onPress, {super.key});
  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 0.2,
    );

    useEffect(() {
      Future<void> startShake() async {
        while (true) {
          await Future.delayed(const Duration(milliseconds: 100));
          controller.reverse();
          await Future.delayed(const Duration(seconds: 3));
          controller.forward();
          await Future.delayed(const Duration(milliseconds: 100));
          controller.reverse();
        }
      }

      startShake();
      return null; // Dispose logic goes here
    }, const []);

    return FloatingActionButton(
      onPressed: onPress,
      child: RotationTransition(
        turns: controller,
        child: const Icon(Icons.shopping_cart_rounded, size: 26),
      ),
    );
  }
}
