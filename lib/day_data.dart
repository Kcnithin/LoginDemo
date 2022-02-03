import 'package:flutter/material.dart';

class DayData extends StatelessWidget {
  late final String day;
  late final String temp;
  late final String status;
  late final String displayImage;

  DayData({
    required this.day,
    required this.displayImage,
    required this.temp,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            day,
            style: const TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                displayImage,
                color: Colors.white,
                width: 70,
                height: 70,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                temp,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            status,
            style: const TextStyle(color: Colors.grey, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
