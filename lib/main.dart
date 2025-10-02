import 'package:flutter/material.dart';
import 'package:tfma/ui/middleman/middleman_dashboard_page.dart';
import 'package:tfma/ui/select_type/select_type_page.dart';
import 'package:tfma/ui/splash/splashcreen_page.dart';

void main() {
  runApp(MiddlemanDashboardPage());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // navigatorKey: NavigationService.navigatorKey,
      title: "",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Kanit',
        primaryColor: Color(0xff3C95B5),
        splashColor: Color(0xff9FDFF8),
        // buttonColor: Color(0xffc00028),
      ),
      home: SelectTypePage(),
    );
  }
}
