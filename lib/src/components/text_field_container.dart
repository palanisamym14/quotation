import 'package:flutter/material.dart';
import 'package:quotation/src/constants.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget? child;
  const TextFieldContainer({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 64,
      width: size.width * 0.8,
      child: child,
    );
  }
}
