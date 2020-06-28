import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  final Function onPressed;
  final IconData icon;
  final Color iconColor;
  final Color color;

  BottomButton({this.onPressed, this.color, this.icon, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 40.0,
        width: 70.0,
        decoration: BoxDecoration(
          color: color, //Color(0xFF4C79FF),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
      onTap: onPressed,
    );
  }
}
