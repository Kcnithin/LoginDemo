import 'package:flutter/material.dart';

class Temp extends StatelessWidget {
  late final String day;
  late final String temp;
  late final String displayImage;
  late final void Function() buttonAction;

  Temp({required this.displayImage, required this.day, required this.temp,required this.buttonAction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonAction,
      child: Container(
        child: Column(
          children: [
            Text(
                day,
                style: const TextStyle(color: Colors.grey, fontSize: 20),
              ),
            const SizedBox(
              height: 10,
            ),
            Container(
              child: Image.asset(
                displayImage,
                color: Colors.white,
                width: 40,
                height: 40,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              temp,
              style: const TextStyle(
                  color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
