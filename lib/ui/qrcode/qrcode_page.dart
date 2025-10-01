import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tfma/ui/home/home.dart';

import '../../component/base_scaffold.dart';
import '../../component/next_button.dart';
import '../../util/color.dart';

void main() {
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: QrPage()));
}

class QrPage extends StatelessWidget {
  const QrPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      bottomNavigationBar: NextButton(
        color: AppColors.orange,
        nextPage: SellSuccessPage(), // ✅ ใส่ Widget ปลายทางที่ต้องการ push
        label: 'ยืนยัน',
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(height: 8),
          Row(
            children: [
              GestureDetector(
                child: Icon(Icons.arrow_back_ios_new, color: Colors.white),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(width: 12),
              Text(
                'QR CODE',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),

          // 🧾 Card Content
          Container(
            margin: const EdgeInsets.only(left: 8, right: 8, bottom: 24),
            padding: const EdgeInsets.only(
              top: 16,
              left: 16,
              right: 16,
              bottom: 24,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'วันจันทร์ที่ 16 มิถุนายน 2568',
                  style: TextStyle(fontSize: 13),
                ),
                // const SizedBox(height: 4),
                const Text(
                  'แปลง นาย มภัทร',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                // const SizedBox(height: 4),
                const Text(
                  'อำเภอ: เมืองเชียงราย  จังหวัด: เชียงราย',
                  style: TextStyle(fontSize: 13),
                ),
                const SizedBox(height: 8),
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'เลขทะเบียนเกษตรกร : ',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      TextSpan(
                        text: 'XXXXXX-XXXXXX-9123',
                        style: TextStyle(
                          color: AppColors.orange,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),
                const Divider(),

                const SizedBox(height: 16),
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'โควต้าผลผลิต : ',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      TextSpan(
                        text: 'ข้าวโพด',
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const Text('วันที่เก็บเกี่ยว 20/06/2568'),

                const SizedBox(height: 8),
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'น้ำหนัก : ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: '40 ตัน',
                        style: TextStyle(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 4),
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'ความชื้นที่รับซื้อ : ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: '75%',
                        style: TextStyle(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // ✅ QR Code
                Center(
                  child: QrImageView(
                    data: 'https://example.com/buy?id=123',
                    size: 220,
                    backgroundColor: Colors.white,
                  ),
                ),

                const SizedBox(height: 8),
                const Center(
                  child: Text(
                    'QR Code ให้ผู้ซื้อสแกนเพื่อรับซื้อผลผลิต',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SellSuccessPage extends StatelessWidget {
  const SellSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF4FA),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) => HomePage(
                            routeName: '',
                          )),
                );
              },
              child: Container(
                alignment: Alignment.topRight,
                margin: EdgeInsets.only(top: 44, right: 44),
                child: Icon(Icons.close_rounded, size: 40),
              ),
            ),
            // Spacer(),
            Container(
              margin: EdgeInsets.only(top: 54, right: 0),
              alignment: Alignment.center,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Container(
                margin: EdgeInsets.only(top: 0, right: 0),
                alignment: Alignment.center,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: const Color(0xFF4DB749),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(Icons.check, size: 64, color: Colors.white),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'ขายสำเร็จแล้ว',
              style: TextStyle(
                fontSize: 24,
                color: Color(0xFF4DB749),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'ขอบคุณ! คุณขายผลผลิตล็อตนี้สำเร็จแล้ว\nข้อมูลจะถูกบันทึกในประวัติการขาย',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
