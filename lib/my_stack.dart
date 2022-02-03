import 'package:flutter/material.dart';

class MyStack extends StatelessWidget {
  late final String currentLocation;
  late final String cityName;
  late final String currentStatus;
  late final String temp;
  late final Color color;
  late final IconData displayImage;
  late final void Function() buttonAction;

  MyStack(
      {required this.currentLocation,
      required this.cityName,
      required this.currentStatus,
      required this.temp,
      required this.displayImage,
      required this.color,
      required this.buttonAction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonAction,
      child: Stack(children: [
        ClipPath(
            child: Container(
                padding: const EdgeInsets.all(5.0),
                margin: const EdgeInsets.all(15.0),
                height: 160.0,
                decoration: const BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.all(Radius.circular(30))))),
        Container(
            padding: const EdgeInsets.all(15.0),
            margin: const EdgeInsets.all(15.0),
            height: 160.0,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Row(
              children: [
                Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                      Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.all(0),
                          child: Text(
                            currentLocation,
                            style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 18,
                                color: Colors.white),
                          )),
                      Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            cityName,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.white),
                          )),
                      Container(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            currentStatus,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 18,
                                color: Colors.white),
                          )),
                    ])),
                Container(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      displayImage,
                      color: color,
                      size: 80,
                    ),
                  ),
                ),
                Container(
                    alignment: Alignment.bottomRight,
                    margin: const EdgeInsets.all(5),
                    child: Text(
                      temp,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                          color: Colors.white),
                    )),
              ],
            ))
      ]),
    );
  }
}
