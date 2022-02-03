import 'package:flutter/material.dart';
import 'package:login_demo/datas.dart';
import 'package:login_demo/day_data.dart';
import 'package:login_demo/temp.dart';

import 'home.dart';

class DetailPage extends StatelessWidget {
  late final String text;
  late final String degree;
  late final String status;

  DetailPage(
      {Key? key,
      required this.text,
      required this.degree,
      required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, MaterialPageRoute(builder: (context) => Home()));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
        ),
        backgroundColor: Colors.indigo,
        body: SafeArea(
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20),
                child: Text(
                  text,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, left: 20),
                child: const Text(
                  "Wednesday 4 December 2019",
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              DayData(
                  day: "Today",
                  displayImage: "assets/moon.png",
                  temp: degree,
                  status: status),
              const SizedBox(
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Datas(text: "Wind", data: "11km/h"),
                  Datas(text: "Humidity", data: "78%"),
                  Datas(text: "Feels Like", data: "32°"),
                ],
              ),
              const SizedBox(
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Temp(
                      displayImage: "assets/storm.png",
                      day: "FRI",
                      temp: "16°"),
                  Temp(displayImage: "assets/sun.png", day: "SAT", temp: "26°"),
                  Temp(
                      displayImage: "assets/cloudy.png",
                      day: "SUN",
                      temp: "23°"),
                  Temp(
                      displayImage: "assets/cloudy.png",
                      day: "MON",
                      temp: "22°"),
                  Temp(
                      displayImage: "assets/cloudy.png",
                      day: "TUE",
                      temp: "32°"),
                  Temp(
                      displayImage: "assets/cloudy.png",
                      day: "WED",
                      temp: "23°"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
