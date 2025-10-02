import 'package:flutter/material.dart';
import 'package:tfma/ui/home/home.dart';

import '../../component/next_button.dart';
import '../../util/color.dart';
import '../../util/user_role.dart';
import '../middleman/middleman_dashboard_page.dart';

class RegisterPage extends StatelessWidget {
  final UserRole role;

  const RegisterPage({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    final outlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(color: Colors.black12),
    );

    final bool isFarmer = role == UserRole.farmer;

    final Widget destinationPage = isFarmer
        ? HomePage(routeName: '')
        : const MiddlemanDashboardPage();

    return Scaffold(
      bottomNavigationBar: NextButton(
        color: AppColors.green,
        nextPage: destinationPage,
        // ✅ ใส่ Widget ปลายทางที่ต้องการ push
        label: 'ถัดไป',
      ),
      body: Column(
        children: [
          Image.asset(
            'assets/images/banner.png',
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 24),

          Container(
            margin: EdgeInsets.only(left: 16, right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isFarmer ? "เริ่มสมัครใช้งาน" : 'สมัครใช้งานพ่อค้าคนกลาง',
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
                Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Text(
                    isFarmer ? "เลขบัตรประชาชน" : 'เลขประจำตัวผู้เสียภาษี',
                    style: const TextStyle(
                      fontFamily: "Kanit",
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff111111),
                      height: 20 / 13,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    hintText: isFarmer
                        ? 'เลขบัตรประชาชน 13 หลัก'
                        : 'เลขประจำตัวผู้เสียภาษี 13 หลัก',
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
                Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Text(
                    isFarmer ? 'เบอร์มือถือ' : 'เลขที่ใบอนุญาตรับซื้อ',
                    style: const TextStyle(
                      fontFamily: "Kanit",
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff111111),
                      height: 20 / 13,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    hintText: isFarmer
                        ? 'เบอร์มือถือที่ใช้บนอุปกรณ์นี้'
                        : 'ระบุเลขที่ใบอนุญาตที่ออกโดยจังหวัด',
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
                if (!isFarmer)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 16),
                        child: const Text(
                          'ช่องทางติดต่อหลัก',
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
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'อีเมลหรือเบอร์ผู้ประสานงานหลัก',
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
                    ],
                  ),
                Text(
                  isFarmer
                      ? 'ชื่อผู้ใช้งานและรหัสผ่านใช้เลขรหัสทะเบียนเกษตรกรบน\nสมุดทะเบียนเกษตร 12 หลัก (เล่มเขียว)'
                      : 'โปรดเตรียมข้อมูลเอกสารการรับซื้อและข้อมูลการติดต่อผู้รวบรวม\nเพื่อความถูกต้องก่อนเริ่มใช้งานระบบ',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          // Spacer(),
          // Container(
          //   width: 328,
          //   height: 48,
          //   padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 9),
          //   decoration: ShapeDecoration(
          //     color: Color(0xFF4DB749),
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //     shadows: [
          //       BoxShadow(
          //         color: Color(0x3F000000),
          //         blurRadius: 5,
          //         offset: Offset(3, 3),
          //         spreadRadius: 0,
          //       ),
          //     ],
          //   ),
          //   child: Row(
          //     mainAxisSize: MainAxisSize.min,
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       Text(
          //         'ถัดไป',
          //         textAlign: TextAlign.center,
          //         style: TextStyle(
          //           color: Colors.white,
          //           fontSize: 20,
          //           fontFamily: 'Kanit',
          //           height: 0.07,
          //         ),
          //       ),
          //     ],
          //   ),
          // ), // Container(
          //   width: 328,
          //   height: 48,
          //   padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 9),
          //   decoration: ShapeDecoration(
          //     color: Color(0xFF4DB749),
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //     shadows: [
          //       BoxShadow(
          //         color: Color(0x3F000000),
          //         blurRadius: 5,
          //         offset: Offset(3, 3),
          //         spreadRadius: 0,
          //       ),
          //     ],
          //   ),
          //   child: Row(
          //     mainAxisSize: MainAxisSize.min,
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       Text(
          //         'ถัดไป',
          //         textAlign: TextAlign.center,
          //         style: TextStyle(
          //           color: Colors.white,
          //           fontSize: 20,
          //           fontFamily: 'Kanit',
          //           height: 0.07,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Spacer(),

          // SizedBox(
          //   width: double.infinity,
          //   height: 48,
          //   child: GestureDetector(
          //     onTap: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (_) => RegisterPage()),
          //       );
          //     },
          //     child: Container(
          //       alignment: Alignment.bottomCenter,
          //       margin: EdgeInsets.only(left: 24, right: 24),
          //       decoration: BoxDecoration(
          //         color: const Color(0xFF4CAF50),
          //         borderRadius: BorderRadius.circular(10),
          //
          //         boxShadow: const [
          //           BoxShadow(
          //             color: Color.fromRGBO(194, 253, 192, 1),
          //             offset: Offset(-2, -2),
          //             blurRadius: 5,
          //           ),
          //           BoxShadow(
          //             color: Color.fromRGBO(56, 150, 53, 1),
          //             offset: Offset(2, 2),
          //             blurRadius: 5,
          //           ),
          //         ],
          //       ),
          //       child: Center(
          //         child: Text(
          //           'ถัดไป',
          //           style: TextStyle(
          //             fontSize: 18,
          //             fontWeight: FontWeight.w700,
          //             color: Colors.white,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // Spacer(),
        ],
      ),
    );
  }
}
