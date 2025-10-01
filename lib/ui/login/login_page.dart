import 'package:flutter/material.dart';

import '../../component/next_button.dart';
import '../../util/color.dart';
import '../register/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _farmerIdController = TextEditingController();
  final _passwordController = TextEditingController();

  final OutlineInputBorder outlineBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: const BorderSide(color: Colors.black12),
  );

  String? _validateFarmerId(String? value) {
    if (value == null || value.isEmpty) {
      return 'กรุณากรอกรหัสทะเบียนเกษตรกร';
    }
    if (value.length != 12) {
      return 'รหัสต้องมี 12 หลัก';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'กรุณากรอกรหัสผ่าน';
    }
    final upperCase = RegExp(r'[A-Z]');
    final lowerCase = RegExp(r'[a-z]');
    final number = RegExp(r'\d');

    if (!upperCase.hasMatch(value)) {
      return 'รหัสผ่านต้องมีตัวอักษรพิมพ์ใหญ่';
    }
    if (!lowerCase.hasMatch(value)) {
      return 'รหัสผ่านต้องมีตัวอักษรพิมพ์เล็ก';
    }
    if (!number.hasMatch(value)) {
      return 'รหัสผ่านต้องมีตัวเลข';
    }
    if (value.length < 8) {
      return 'รหัสผ่านต้องมีอย่างน้อย 8 ตัวอักษร';
    }
    return null;
  }

  Widget onLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RegisterPage()),
      );
    }
    return Container(); // Placeholder to satisfy return type
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NextButton(
        color: AppColors.green,
        // onPressed: onLogin(),
        label: 'เข้าสู่ระบบ',
        nextPage: RegisterPage(),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset(
                'assets/images/banner.png',
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 24),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "เข้าใช้งาน",
                      style: TextStyle(
                        fontFamily: "Kanit",
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff000000),
                        height: 42 / 28,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),

                    // รหัสเกษตรกร
                    const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        "รหัสทะเบียนเกษตรกร",
                        style: TextStyle(
                          fontFamily: "Kanit",
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff111111),
                          height: 20 / 13,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _farmerIdController,
                      keyboardType: TextInputType.number,
                      validator: _validateFarmerId,
                      decoration: InputDecoration(
                        hintText: 'กรอกรหัสเกษตรกร 12 หลัก *',
                        hintStyle: TextStyle(color: AppColors.subtitle),
                        border: outlineBorder,
                        enabledBorder: outlineBorder,
                        focusedBorder: outlineBorder,
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // รหัสผ่าน
                    const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        'รหัสผ่าน',
                        style: TextStyle(
                          fontFamily: "Kanit",
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff111111),
                          height: 20 / 13,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      validator: _validatePassword,
                      onChanged: (a) {},
                      decoration: InputDecoration(
                        hintText: 'กรอกรหัสผ่าน *',
                        hintStyle: TextStyle(color: AppColors.subtitle),
                        border: outlineBorder,
                        enabledBorder: outlineBorder,
                        focusedBorder: outlineBorder,
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    const Text(
                      'ชื่อผู้ใช้งานและรหัสผ่านใช้เลขรหัสทะเบียนเกษตรกรบน\nสมุดทะเบียนเกษตร 12 หลัก (เล่มเขียว)',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),

              // const SizedBox(height: 24),
              //
              // // ปุ่มเข้าสู่ระบบ
              // NextButton(
              //   color: AppColors.green,
              //   // onPressed: onLogin(),
              //   label: 'เข้าสู่ระบบ',
              //   nextPage: RegisterPage(),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
