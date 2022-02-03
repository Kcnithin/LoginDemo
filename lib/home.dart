import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_demo/detail_page.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_bar_widgets.dart';
import 'login.dart';
import 'my_stack.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CarouselController buttonCarouselController = CarouselController();

  int currentPos = 0;

  List<Widget> listPaths = [
    MyStack(
      currentLocation: "Current location",
      cityName: "Dhaka",
      currentStatus: "Thunder",
      temp: "20°C",
      displayImage: MdiIcons.weatherLightning,
      color: Colors.white,
      buttonAction: () {},
    ),
    MyStack(
      currentLocation: "United states",
      cityName: "California",
      currentStatus: "Clear",
      temp: "6°C",
      displayImage: MdiIcons.weatherPartlyCloudy,
      color: Colors.white,
      buttonAction: () {},
    ),
    MyStack(
      currentLocation: "China",
      cityName: "Beijing",
      currentStatus: "Mostly sunny",
      temp: "5°C",
      displayImage: MdiIcons.weatherSunny,
      color: Colors.orange,
      buttonAction: () {},
    ),
    MyStack(
      currentLocation: "Russia",
      cityName: "Moscow",
      currentStatus: "Cloudy",
      temp: "-04°C",
      displayImage: MdiIcons.weatherCloudy,
      color: Colors.white,
      buttonAction: () {},
    ),
  ];
  DateTime pre_backpress = DateTime.now();

  get listname => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Hello Arian,\nDiscover the weather",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          AppBarWidgets(buttonAction: () {}, buttonIcon: Icons.search),
          AppBarWidgets(
              buttonAction: () async {
                final sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.remove('username');
                Navigator.pop(context, true);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              buttonIcon: MdiIcons.logout),
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          final timegap = DateTime.now().difference(pre_backpress);
          final cantExit = timegap >= const Duration(seconds: 2);
          pre_backpress = DateTime.now();
          if (cantExit) {
            //show snackbar
            const snack = SnackBar(
              content: Text('Press Back button again to Exit'),
              duration: Duration(seconds: 2),
            );
            ScaffoldMessenger.of(context).showSnackBar(snack);
            return false;
          } else {
            SystemNavigator.pop();
            return true;
          }
        },
        child: SafeArea(
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: CarouselSlider(
                      options: CarouselOptions(
                          height: 160,
                          autoPlay: false,
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentPos = index;
                            });
                          }),
                      items: [
                        MyStack(
                          currentLocation: "Current location",
                          cityName: "Dhaka",
                          currentStatus: "Thunder",
                          temp: "20°C",
                          displayImage: MdiIcons.weatherLightning,
                          color: Colors.white,
                          buttonAction: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                          text: "Dhaka",
                                          degree: "20°C",
                                          status: "Thunder",
                                        )));
                          },
                        ),
                        MyStack(
                          currentLocation: "United states",
                          cityName: "California",
                          currentStatus: "Clear",
                          temp: "6°C",
                          displayImage: MdiIcons.weatherPartlyCloudy,
                          color: Colors.white,
                          buttonAction: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                          text: "California",
                                          degree: "6°C",
                                          status: "Clear",
                                        )));
                          },
                        ),
                        MyStack(
                          currentLocation: "China",
                          cityName: "Beijing",
                          currentStatus: "Mostly sunny",
                          temp: "5°C",
                          displayImage: MdiIcons.weatherSunny,
                          color: Colors.orange,
                          buttonAction: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                          text: "Beijing",
                                          degree: "5°C",
                                          status: "Mostly sunny",
                                        )));
                          },
                        ),
                        MyStack(
                          currentLocation: "Russia",
                          cityName: "Moscow",
                          currentStatus: "Cloudy",
                          temp: "-04°C",
                          displayImage: MdiIcons.weatherCloudy,
                          color: Colors.white,
                          buttonAction: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                          text: "Moscow",
                                          degree: "-04°C",
                                          status: "Cloudy",
                                        )));
                          },
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: listPaths.map((url) {
                      int index = listPaths.indexOf(url);
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentPos == index
                              ? Colors.indigo
                              : Colors.white,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.all(15.0),
                child: const Text(
                  "Around the world",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              MyStack(
                currentLocation: "United states",
                cityName: "California",
                currentStatus: "Clear",
                temp: "6°C",
                displayImage: MdiIcons.weatherPartlyCloudy,
                color: Colors.white,
                buttonAction: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailPage(
                                text: "California",
                                degree: "6°C",
                                status: "Clear",
                              )));
                },
              ),
              MyStack(
                currentLocation: "China",
                cityName: "Beijing",
                currentStatus: "Mostly sunny",
                temp: "5°C",
                displayImage: MdiIcons.weatherSunny,
                color: Colors.orange,
                buttonAction: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailPage(
                                text: "Beijing",
                                degree: "5°C",
                                status: "Mostly sunny",
                              )));
                },
              ),
              MyStack(
                currentLocation: "Russia",
                cityName: "Moscow",
                currentStatus: "Cloudy",
                temp: "-04°C",
                displayImage: MdiIcons.weatherCloudy,
                color: Colors.white,
                buttonAction: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailPage(
                              text: "Moscow",
                              degree: "-04°C",
                              status: "Cloudy")));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
