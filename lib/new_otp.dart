import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'home.dart';

class NewOtp extends StatefulWidget {

  late final String? phoneNumber = "8281212017";

  @override
  State<NewOtp> createState() => _NewOtpState();
}

class _NewOtpState extends State<NewOtp> {
  TextEditingController textEditingController = TextEditingController();

  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  // snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: Duration(seconds: 2),
      ),
    );
  }

  DateTime pre_backpress = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final timegap = DateTime.now().difference(pre_backpress);
        final cantExit = timegap >= Duration(seconds: 2);
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
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black,
        body: SafeArea(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(left: 20, top: 20),
                    child: const Text(
                      "One more thing...",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: "My Font"),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, top: 10),
                    child: const Text(
                      "We've sent a 6-digit code to \nyour mobile device.",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.normal,
                          fontFamily: "bold"),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: formKey,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 30),
                        child: PinCodeTextField(
                          appContext: context,
                          pastedTextStyle: TextStyle(
                            color: Colors.green.shade600,
                            fontWeight: FontWeight.bold,
                          ),
                          length: 6,
                          obscureText: true,
                          blinkWhenObscuring: true,
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                            activeColor: Colors.white,
                            inactiveColor: Colors.white,
                            selectedColor: Colors.white,
                            selectedFillColor: Colors.black,
                            inactiveFillColor: Colors.black,
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(10),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            activeFillColor: Colors.white,
                          ),
                          cursorColor: Colors.white,
                          animationDuration: Duration(milliseconds: 300),
                          enableActiveFill: true,
                          errorAnimationController: errorController,
                          controller: textEditingController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            print(value);
                            setState(() {
                              currentText = value;
                            });
                          },
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      hasError ? "*Please fill up all the cells properly" : "",
                      style: const TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 30),
                    child: ButtonTheme(
                      height: 50,
                      child: TextButton(
                        onPressed: () async {
                          formKey.currentState!.validate();
                          // conditions for validating
                          if (currentText.length != 6 ||
                              currentText != "123456") {
                            errorController!.add(ErrorAnimationType
                                .shake); // Triggering error shake animation
                            setState(() => hasError = true);
                          } else {
                            setState(
                              () {
                                hasError = false;
                                snackBar("OTP Verified!!");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()));
                              },
                            );
                          }
                        },
                        child: Center(
                            child: Text(
                          "VERIFY".toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue[800],
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Didn't receive your code?",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      TextButton(
                          onPressed: () => snackBar("OTP resend!!"),
                          child: const Text(
                            "Resend it",
                            style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                            ),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
