import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tfma/ui/splash/splashcreen_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      splitScreenMode: false,
      child: MaterialApp(
        // navigatorKey: NavigationService.navigatorKey,
        title: "",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Kanit',
          primaryColor: Color(0xff3C95B5),
          splashColor: Color(0xff9FDFF8),
          // buttonColor: Color(0xffc00028),
        ),
        home: SplashcreenPage(),
      ),
    );
  }
}
