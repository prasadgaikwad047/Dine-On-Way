import 'dart:async';

import 'package:dine_on_way/screens/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LandingPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding:
            const EdgeInsets.only(top: 250, bottom: 100, left: 94, right: 50),
        child: Column(
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                      'assets/app icon.jpg'), // Replace with your image path
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText(
                  'Dine On Way',
                  textStyle: TextStyle(
                      fontSize: 34.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                  speed: Duration(milliseconds: 100),
                ),
              ],
              isRepeatingAnimation: true,
              totalRepeatCount: 1,
              pause: Duration(milliseconds: 300),
            ),
          ],
        ),
      ),
    );
  }
}
