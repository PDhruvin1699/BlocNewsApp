import 'dart:async';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/views/signup.dart';

import 'home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2), () {
// navigate to home screen
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => SignUpScreen()));
    });
  }

  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Container(
            width: width * 0.6,
            height: width * 0.6,
            child: Image.asset(
              "images/21601.png",
              fit: BoxFit.contain,
            )),
      ),
    );
  }
}
