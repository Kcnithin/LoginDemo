import 'package:flutter/material.dart';

class AppBarWidgets extends StatelessWidget {
  late final IconData buttonIcon;
  late final void Function() buttonAction;
  late final Color iconColor;

  AppBarWidgets(
      {required this.buttonAction,
      required this.buttonIcon,
      this.iconColor = Colors
          .black}) //to pass optional parameter..here black will be default and can change only if required
  {}

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.grey[300], //to set intensity[req value]
          shape: BoxShape.circle),
      child: IconButton(
        icon: Icon(
          buttonIcon,
          color: iconColor,
          size: 25,
        ),
        onPressed: buttonAction,
      ),
    );
  }
}
