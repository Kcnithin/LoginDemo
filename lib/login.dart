import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'otp.dart';

enum SingingCharacter { keep }

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;
  SingingCharacter? _character = SingingCharacter.keep;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: ListView(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Image.asset(
                "assets/back.png",
                width: 50,
                height: 50,
                color: Colors.white,
              ),
            ),
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
               horizontalTitleGap:-12,
              title: const Text(
                "Keep me signed in",
                style: TextStyle(color: Colors.white),
              ),
              leading: SizedBox(
                child: Image.asset(
                  "assets/circle.png",
                  color: Colors.white,
                ),
              ),
              trailing: const Text(
                "Forgot password?",
                style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, top: 30, right: 20),
              child: ElevatedButton(
                onPressed: () {
                  if (nameController.text == "nithin@gmail.com" &&
                      passwordController.text == "12345") {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Otp()));
                  } else if (nameController.text == "nithin@gmail.com" &&
                      passwordController.text.length < 5) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.red,
                        margin: EdgeInsets.all(10),
                        content: Text(_errorPassword)));
                  } else if (nameController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.red,
                        margin: EdgeInsets.all(10),
                        content: Text(_errorEmail)));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.red,
                        margin: EdgeInsets.all(10),
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
                      margin: const EdgeInsets.only(left: 10.0, right: 15.0),
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
                      margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                      child: const Divider(
                        color: Colors.grey,
                        thickness: 1,
                        height: 50,
                      )),
                ),
              ]),
            ),
            Container(
                margin: const EdgeInsets.only(left: 20,  right: 20),
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child : IconButton(
                        onPressed: () {},
                        icon: Icon(MdiIcons.apple,color: Colors.white,),
                      ),
                    ),
                    Container(
                      child : IconButton(
                        onPressed: () {},
                        icon: Icon(MdiIcons.facebook,color: Colors.white,),
                      ),
                    ),
                    Container(
                      child : IconButton(
                        onPressed: () {},
                        icon: Icon(MdiIcons.google,color: Colors.white,),
                      ),
                    ),
                    Container(
                      child : IconButton(
                        onPressed: () {},
                        icon: Icon(MdiIcons.twitter,color: Colors.white,),
                      ),
                    ),
                  ],
                )),
            Container(
              margin: const EdgeInsets.only(
                  left: 20, top: 40, right: 20, bottom: 10),
              child: const Center(
                child: Text.rich(TextSpan(
                  text: 'Dont have an account?',
                  style: TextStyle(fontSize: 13, color: Colors.white),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Sign up!',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.white)),
                    // can add more TextSpans here...
                  ],
                )),
              ),
            ),
          ],
        ));
  }
}
