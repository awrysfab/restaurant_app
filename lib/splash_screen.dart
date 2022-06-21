import 'dart:async';
import 'package:flutter/material.dart';
import 'package:news_app/main.dart';

class Splash extends StatefulWidget {
  static const routeName = '/';
  @override
  _SplashState createState() => _SplashState();
}
class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3),
            () => Navigator.pushNamed(context, RestaurantsListPage.routeName)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              const Text("Findresto",
                style: const TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),)
            ],
          )
        ]
    );
  }
}