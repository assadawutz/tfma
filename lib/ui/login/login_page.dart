import 'package:flutter/material.dart';

import '../../component/next_button.dart';
import '../../util/color.dart';
import '../../util/user_role.dart';
import '../register/register_page.dart';

class LoginPage extends StatefulWidget {
  final UserRole role;

  const LoginPage({super.key, required this.role});

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

  bool get _isFarmer => widget.role == UserRole.farmer;

  String get _identifierLabel =>
      _isFarmer ? 'รหัสทะเบียนเกษตรกร' : 'รหัสผู้รวบรวม';

  String get _identifierHint => _isFarmer
      ? 'กรอกรหัสเกษตรกร 12 หลัก *'
      : 'กรอกรหัสผู้รวบรวมอย่างน้อย 8 หลัก *';

  String get _subtitleText => _isFarmer
      ? 'ชื่อผู้ใช้งานและรหัสผ่านใช้เลขรหัสทะเบียนเกษตรกรบน\nสมุดทะเบียนเกษตร 12 หลัก (เล่มเขียว)'
      : 'ชื่อผู้ใช้งานและรหัสผ่านใช้รหัสผู้รวบรวมที่ได้รับจากกรมการค้าภายใน\nหรือตามใบอนุญาตรับซื้อผลผลิต';

  String get _pageTitle =>
      _isFarmer ? 'เข้าใช้งาน' : 'เข้าสู่ระบบพ่อค้าคนกลาง';

  String? _validateIdentifier(String? value) {
    if (value == null || value.isEmpty) {
      return _isFarmer
          ? 'กรุณากรอกรหัสทะเบียนเกษตรกร'
          : 'กรุณากรอกรหัสผู้รวบรวม';
    }
    if (_isFarmer) {
      if (value.length != 12) {
        return 'รหัสต้องมี 12 หลัก';
      }
    } else {
      if (value.length < 8) {
        return 'รหัสผู้รวบรวมต้องมีอย่างน้อย 8 หลัก';
      }
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
        MaterialPageRoute(
          builder: (context) => RegisterPage(role: widget.role),
        ),
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
        nextPage: RegisterPage(role: widget.role),
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
                    Text(
                      _pageTitle,
                      style: const TextStyle(
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
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        _identifierLabel,
                        style: const TextStyle(
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
                      validator: _validateIdentifier,
                      decoration: InputDecoration(
                        hintText: _identifierHint,
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

                    Text(
                      _subtitleText,
                      style: const TextStyle(
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
