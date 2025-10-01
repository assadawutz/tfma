import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../select_type/select_type_page.dart';

class SplashcreenPage extends StatefulWidget {
  const SplashcreenPage({super.key});

  @override
  State<SplashcreenPage> createState() => _SplashcreenPageState();
}

class _SplashcreenPageState extends State<SplashcreenPage> {
  late Timer timer;

  @override
  void initState() {
    super.initState();

    timer = Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (_) => SelectTypePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0),
        child: Image.asset(
          'assets/images/bg_splash.png',
          fit: BoxFit.contain, // หรือ BoxFit.fill ถ้าอยากยืด
        ),
      ),
    );
  }
}
