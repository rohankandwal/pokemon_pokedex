import 'package:flutter/cupertino.dart';

class CustomSpacerWidget extends StatelessWidget {
  final double height, width;

  const CustomSpacerWidget({
    this.height = 0,
    this.width = 0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
    );
  }
}
