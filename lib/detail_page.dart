import 'package:flutter/material.dart';
import 'package:login_demo/datas.dart';
import 'package:login_demo/day_data.dart';
import 'package:login_demo/temp.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'home.dart';

class DetailPage extends StatefulWidget {
  late String text;
  late String degree;
  late String status;

  DetailPage(
      {Key? key,
      required this.text,
      required this.degree,
      required this.status})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String dayHolder = 'Today';
  String displayImageHolder = "assets/moon.png";




  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, MaterialPageRoute(builder: (context) => Home()));
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.indigo,
        body: SafeArea(
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20, left: 5),
                alignment: Alignment.topLeft,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    },
                    icon: const Icon(
                      MdiIcons.arrowLeft,
                      color: Colors.white,
                      size: 30,
                    )),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20),
                child: Text(
                  widget.text,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, left: 20),
                child: const Text(
                  "Thursday 3 February 2022",
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              DayData(
                  day: dayHolder,
                  displayImage: displayImageHolder,
                  temp: widget.degree,
                  status: widget.status),
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
                    temp: "16°",
                    buttonAction: () {
                      setState(() {
                        dayHolder = 'Friday';
                        displayImageHolder = "assets/storm.png";
                        widget.degree = "16°C";
                        widget.status = "ThunderStorm";
                      });
                    },
                  ),
                  Temp(
                    displayImage: "assets/sun.png",
                    day: "SAT",
                    temp: "26°",
                    buttonAction: () {
                      setState(() {

                        dayHolder = 'Saturday';
                        displayImageHolder = "assets/sun.png";
                        widget.degree = "26°C";
                        widget.status = "Clear";
                      });
                    },
                  ),
                  Temp(
                    displayImage: "assets/cloudy.png",
                    day: "SUN",
                    temp: "23°",
                    buttonAction: () {
                      setState(() {
                        dayHolder = 'Sunday';
                        displayImageHolder = "assets/cloudy.png";
                        widget.degree = "23°C";
                        widget.status = "Cloudy";
                      });
                    },
                  ),
                  Temp(
                    displayImage: "assets/sun.png",
                    day: "MON",
                    temp: "22°",
                    buttonAction: () {
                      setState(() {
                        dayHolder = 'Monday';
                        displayImageHolder = "assets/sun.png";
                        widget.degree = "22°C";
                        widget.status = "Clear";
                      });
                    },
                  ),
                  Temp(
                    displayImage: "assets/cloudy.png",
                    day: "TUE",
                    temp: "32°",
                    buttonAction: () {
                      setState(() {
                        dayHolder = 'Tuesday';
                        displayImageHolder = "assets/cloudy.png";
                        widget.degree = "32°C";
                        widget.status = "Cloudy";
                      });
                    },
                  ),
                  Temp(
                    displayImage: "assets/cloudy.png",
                    day: "WED",
                    temp: "23°",
                    buttonAction: () {
                      setState(() {
                        dayHolder = 'Wednesday';
                        displayImageHolder = "assets/cloudy.png";
                        widget.degree = "23°C";
                        widget.status = "Cloudy";
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
