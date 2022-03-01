import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_demo/detail_page.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'app_bar_widgets.dart';
import 'login.dart';
import 'my_stack.dart';
import 'package:bottom_sheet_expandable_bar/bottom_sheet_expandable_bar.dart';
import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _textController = TextEditingController();

  static List<String> mainDataList = [
    "Dhaka",
    "California",
    "Beijing",
    "Moscow",
  /*  "Apple",
    "Apricot",
    "Banana",
    "Blackberry",
    "Coconut",
    "Date",
    "Fig",
    "Gooseberry",
    "Grapes",
    "Lemon",
    "Litchi",
    "Mango",
    "Orange",
    "Papaya",
    "Peach",
    "Pineapple",
    "Pomegranate",
    "Starfruit"*/
  ];
  List<String> location = [
    "Current location"
    "United states"
    "China"
    "Russia"
  ];

  List<String> newDataList = List.from(mainDataList);

  onItemChanged(String value) {
    setState(() {
      newDataList = mainDataList
          .where((string) => string.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

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

  _onAlertButtonsPressed(context) {
    Alert(
      context: context,
      title: "ALERT",
      desc: "Are you sure to logout and exit?",
      buttons: [
        DialogButton(
            child: const Text(
              "CANCEL",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            onPressed: () => Navigator.pop(context),
            color: Colors.indigo),
        DialogButton(
            child: const Text(
              "YES",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            onPressed: () async {
              final sharedPreferences = await SharedPreferences.getInstance();
              sharedPreferences.remove('username');
              Navigator.pop(context, true);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
            color: Colors.indigo)
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
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
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.black12,
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            title: const Text(
              "Hello Arian,\nDiscover the weather",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              AppBarWidgets(
                  buttonAction: () {
                    _showModalBottomSheet();
                  },
                  buttonIcon: Icons.settings),
              AppBarWidgets(
                  buttonAction: () async {
                    _onAlertButtonsPressed(context);
                  },
                  buttonIcon: MdiIcons.logout),
            ],
          ),
          body: SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SegmentedTabControl(
                    // Customization of widget
                    radius: const Radius.circular(3),
                    backgroundColor: Colors.grey.shade300,
                    indicatorColor: Colors.orange.shade200,
                    tabTextColor: Colors.black45,
                    selectedTabTextColor: Colors.white,
                    squeezeIntensity: 2,
                    height: 45,
                    tabPadding: const EdgeInsets.symmetric(horizontal: 8),
                    textStyle: Theme.of(context).textTheme.bodyText1,
                    // Options for selection
                    // All specified values will override the [SegmentedTabControl] setting
                    tabs: const [
                      SegmentTab(
                        label: 'HOME',
                        // For example, this overrides [indicatorColor] from [SegmentedTabControl]
                        color: Colors.indigo,
                      ),
                      SegmentTab(
                        label: 'HISTORY',
                        color: Colors.indigo,
                        selectedTextColor: Colors.black45,
                        textColor: Colors.black26,
                      ),
                      SegmentTab(
                        label: 'NEW',
                        color: Colors.indigo,
                      ),
                    ],
                  ),
                ),
                // Sample pages
                Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: TabBarView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      ListView(
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
                                                builder: (context) =>
                                                    DetailPage(
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
                                      displayImage:
                                          MdiIcons.weatherPartlyCloudy,
                                      color: Colors.white,
                                      buttonAction: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailPage(
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
                                                builder: (context) =>
                                                    DetailPage(
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
                                                builder: (context) =>
                                                    DetailPage(
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
                      SampleWidget(
                        label: 'HOME',
                        color: Colors.blue.shade100,
                      ),
                     Scaffold(
                          backgroundColor: Colors.black,
                          body: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: TextField(
                                  style: TextStyle(color: Colors.indigo),
                                  controller: _textController,
                                  decoration: InputDecoration(
                                    enabledBorder:  OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.indigo,
                                        width: 4,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    hintText: 'Search Here...',
                                    hintStyle: const TextStyle(
                                      color: Colors.indigo
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onChanged: onItemChanged,
                                ),
                              ),

                              Expanded(
                                child: ListView(
                                  padding: EdgeInsets.all(12.0),
                                  children: newDataList.map((data) {
                                    return   MyStack(
                                      currentLocation: "Russia",
                                      cityName: data,
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
                                    );
                              /*      return ListTile(
                                      title: Text(data,style: const TextStyle(
                                          color: Colors.indigo
                                      ),),
                                      onTap: () {
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: Colors.indigo,
                                            margin: const EdgeInsets.all(10),
                                            content: Text("You have Selected $data")));
                                      },
                                    );*/
                                  }).toList(),
                                ),
                              )
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showModalBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Container(
            height: 500,
            width: double.infinity,
            color: Colors.black,
            alignment: Alignment.center,
            child: ListView(
              children: [
                ListTile(
                  title: const Text(
                    "Settings",
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.of(context).pop()),
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey[300],
                ),
                ListTile(
                  title: const Text(
                    "Share to your story",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.of(context).pop(ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.black,
                            margin: EdgeInsets.all(10),
                            content: Text(
                              "Succesfully shared to Your Story",
                              style: TextStyle(color: Colors.white),
                            ))));
                  },
                  leading: Icon(Icons.add_circle_outline_rounded,
                      color: Colors.white),
                ),
                ListTile(
                  title: const Text(
                    "Send in WhatsApp",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.of(context).pop(ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.black,
                            margin: EdgeInsets.all(10),
                            content: Text(
                              "Succesfully shared to WhatsApp",
                              style: TextStyle(color: Colors.white),
                            ))));
                  },
                  leading: const Icon(MdiIcons.whatsapp, color: Colors.white),
                ),
                ListTile(
                  title: const Text(
                    "Share in Facebook",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.of(context).pop(ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.black,
                            margin: EdgeInsets.all(10),
                            content: Text(
                              "Succesfully shared to Facebook",
                              style: TextStyle(color: Colors.white),
                            ))));
                  },
                  leading: const Icon(Icons.facebook, color: Colors.white),
                ),
                ListTile(
                  title: const Text(
                    "Share in Instagram",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.of(context).pop(ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.black,
                            margin: EdgeInsets.all(10),
                            content: Text(
                              "Succesfully shared to Instagram",
                              style: TextStyle(color: Colors.white),
                            ))));
                  },
                  leading: const Icon(MdiIcons.instagram, color: Colors.white),
                ),
                ListTile(
                  title: const Text(
                    "More options",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.of(context).pop(ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.black,
                            margin: EdgeInsets.all(10),
                            content: Text(
                              "Succesfully shared",
                              style: TextStyle(color: Colors.white),
                            ))));
                  },
                  leading: Icon(Icons.share, color: Colors.white),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SampleWidget extends StatelessWidget {
  const SampleWidget({
    Key? key,
    required this.label,
    required this.color,
  }) : super(key: key);

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(10))),
      child: Text(label),
    );
  }
}
