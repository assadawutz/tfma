import 'dart:io' show Platform;

import 'package:flutter/material.dart';

import '../../component/sizeConfig.dart';
import '../login/login_page.dart';
import '../../util/user_role.dart';

class SelectTypePage extends StatefulWidget {
  SelectTypePage({
    Key? key,
  }) : super(key: key);

  @override
  _SelectTypePageState createState() => _SelectTypePageState();
}

class _SelectTypePageState extends State<SelectTypePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/banner.png',
              // width: SizeConfig.getWidth(MediaQuery.of(context).size.width),
              height: 400,
              fit: BoxFit.cover,
            ),
            Container(
              margin: EdgeInsets.only(
                top: Platform.isMacOS
                    ? SizeConfig.getHeight(80)
                    : SizeConfig.getHeight(24),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Spacer(),
                  Spacer(),

                  // Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginPage(
                            role: UserRole.farmer,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.account_circle,
                          color: Colors.grey,
                          size: SizeConfig.getWidth(80),
                        ),
                        SizedBox(
                          height: SizeConfig.getWidth(16),
                        ),
                        Text(
                          'เกษตรกร',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                            fontSize: SizeConfig.getFontSize(16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(width: SizeConfig.getWidth(8)),
                  Spacer(),
                  // Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginPage(
                            role: UserRole.middleman,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.account_circle,
                          color: Colors.grey,
                          size: SizeConfig.getWidth(80),
                        ),
                        SizedBox(height: SizeConfig.getHeight(16)),
                        Text(
                          'พ่อค้าคนกลาง',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                            fontSize: SizeConfig.getFontSize(16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  // Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
