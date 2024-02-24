import 'package:flutter/material.dart';

class BasicShadow extends StatelessWidget {
  const BasicShadow({super.key, required this.topDown});
  final bool topDown;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          end: topDown ? Alignment.topCenter : Alignment.bottomCenter,
          begin: topDown ? Alignment.bottomCenter : Alignment.topCenter,
          colors: const [
            Colors.transparent,
            Colors.black87,
          ],
        ),
      ),
    );
  }
}
