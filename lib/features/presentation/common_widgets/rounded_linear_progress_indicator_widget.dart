import 'package:flutter/material.dart';

class RoundedLinearProgressIndicator extends StatelessWidget {
  final double width, height, radius, progress;
  final Color valueColor, backgroundColor;

  const RoundedLinearProgressIndicator(
      {Key? key,
      required this.width,
      this.height = 4,
      required this.radius,
      required this.valueColor,
      required this.backgroundColor,
      required this.progress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, boxConstraints) {
        var x = boxConstraints.maxWidth;
        var percent = (progress / 100) * x;
        return Stack(
          children: [
            Container(
              width: x,
              height: 7,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(radius),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: percent,
              height: 7,
              decoration: BoxDecoration(
                color: valueColor,
                borderRadius: BorderRadius.circular(radius),
              ),
            ),
          ],
        );
      },
    );
  }
}
