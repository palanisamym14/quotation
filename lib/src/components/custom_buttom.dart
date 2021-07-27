import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {this.label,
      required this.onTap,
      required this.height,
      required this.width,
      this.backgroundColor = Colors.white,
      this.labelColor = Colors.black,
      this.icon});

  final String? label;
  final Function onTap;
  final double height;
  final double width;
  final Color backgroundColor;
  final Color labelColor;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    print(width);
    print(label != null);
    return Container(
        child: Ink(
      width: width,
      height: height,
      child: label != null
          ? TextButton(
              onPressed: () => onTap(),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    backgroundColor), //Background Color
              ),
              child: Center(
                  child: Text(
                label!,
                style: TextStyle(fontSize: 24, color: labelColor),
              )),
            )
          : IconButton(
              icon: new Icon(icon),
              onPressed: () => onTap(),
              color: Colors.green,
            ),
    ));
  }
}
