import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';
import 'login.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  bool flag = false;
  @override
  void initState() {
    getSaved(context);
    Timer(
        const Duration(seconds: 3),
            () => flag?Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
        ) : Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Login(),
          ),
        )
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          "assets/storm.png",
          color: Colors.white,
          width: 100,
          height: 100,
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> getSaved(BuildContext context) async {
    WidgetsFlutterBinding.ensureInitialized();
    final sharedPreferences = await SharedPreferences.getInstance();
    final savedUsername = sharedPreferences.getString('username');
    if (savedUsername != null) {
     flag = true;
    }else{
      flag = false;
    }
  }
}
