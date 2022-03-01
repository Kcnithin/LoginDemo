import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_demo/home.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'new_otp.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

GlobalKey myFormKey = new GlobalKey();

class _LoginState extends State<Login> {
  bool _obscureText = true;

  late final VoidCallback onPressed;
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _errorMessage = 'Email and Password does not match';
  final _errorPassword = 'Password Must Contain atleast 5 characters';
  final _errorEmail = 'Enter a valid Email';

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  DateTime pre_backpress = DateTime.now();

  @override
  Widget build(BuildContext context) {
    bool? checkboxIconFormFieldValue = false;
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
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20, top: 20),
                  child: const Text(
                    "Welcome back!",
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
                    "Let's get your finances back \nin check.",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.normal,
                        fontFamily: "bold"),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, top: 30, right: 20),
                  child: TextFormField(
                    controller: nameController,
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.white),
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: "Email address",
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: TextFormField(
                    controller: passwordController,
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.white),
                    textInputAction: TextInputAction.done,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: _toggle,
                        icon: const Icon(
                          Icons.visibility_outlined,
                          color: Colors.white,
                        ),
                      ),
                      hintText: "Password",
                      hintStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                ListTile(
                    horizontalTitleGap: -8,
                    leading: RoundCheckBox(
                      onTap: (selected) async {
                        final sharedPreference =
                            await SharedPreferences.getInstance();
                        sharedPreference.setString(
                            'username', nameController.text);
                      },
                      border: Border.all(
                        width: 2,
                        color: Colors.white,
                      ),
                      uncheckedColor: Colors.black,
                      checkedColor: Colors.blue,
                      size: 25,
                      isChecked: false,
                    ),
                    title: const Text(
                      "Keep me signed in",
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: TextButton(
                        onPressed: () {
                          const snack = SnackBar(
                            content: Text(
                                'link to change your password has been sent to your device'),
                            duration: Duration(seconds: 2),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snack);
                        },
                        child: const Text(
                          "Forgot password?",
                          style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ))),
                Container(
                  margin: const EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (nameController.text == "nithin@gmail.com" &&
                          passwordController.text == "12345") {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => NewOtp()));
                      } else if (nameController.text == "nithin@gmail.com" &&
                          passwordController.text.length < 5) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.red,
                            margin: const EdgeInsets.all(10),
                            content: Text(_errorPassword)));
                      } else if (nameController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.red,
                            margin: const EdgeInsets.all(10),
                            content: Text(_errorEmail)));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.red,
                            margin: const EdgeInsets.all(10),
                            content: Text(_errorMessage)));
                      }
                    },
                    child: const Text("Sign In"),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue[800]),
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(13)),
                        textStyle: MaterialStateProperty.all(
                            const TextStyle(fontSize: 17))),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: Row(children: <Widget>[
                    Expanded(
                      child: Container(
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 15.0),
                          child: const Divider(
                            color: Colors.grey,
                            height: 50,
                            thickness: 1,
                          )),
                    ),
                    const Text(
                      "Or sign in with",
                      style: TextStyle(color: Colors.white),
                    ),
                    Expanded(
                      child: Container(
                          margin:
                              const EdgeInsets.only(left: 15.0, right: 10.0),
                          child: const Divider(
                            color: Colors.grey,
                            thickness: 1,
                            height: 50,
                          )),
                    ),
                  ]),
                ),
                Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          child: IconButton(
                            onPressed: () {
                              const snack = SnackBar(
                                content: Text('sign-in with IOS Account'),
                                duration: Duration(seconds: 2),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snack);
                            },
                            icon: const Icon(
                              MdiIcons.apple,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                        ),
                        Container(
                          child: IconButton(
                            onPressed: () {
                              const snack = SnackBar(
                                content: Text('sign-in with Facebook Account'),
                                duration: Duration(seconds: 2),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snack);
                            },
                            icon: const Icon(MdiIcons.facebook,
                                color: Colors.white, size: 50),
                          ),
                        ),
                        Container(
                          child: IconButton(
                            onPressed: () {
                              const snack = SnackBar(
                                content: Text('sign-in with Gmail Account'),
                                duration: Duration(seconds: 2),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snack);
                            },
                            icon: const Icon(MdiIcons.google,
                                color: Colors.white, size: 50),
                          ),
                        ),
                        Container(
                          child: IconButton(
                            onPressed: () {
                              const snack = SnackBar(
                                content: Text('sign-in with Twitter Account'),
                                duration: Duration(seconds: 2),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snack);
                            },
                            icon: const Icon(
                              MdiIcons.twitter,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                        ),
                      ],
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    TextButton(
                        onPressed: () {
                          const snack = SnackBar(
                            content: Text('Successfully Registered'),
                            duration: Duration(seconds: 2),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snack);
                        },
                        child: const Text(
                          "Signup",
                          style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ))
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
