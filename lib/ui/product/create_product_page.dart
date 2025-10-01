import 'package:flutter/material.dart';
import 'package:tfma/ui/qrcode/qrcode_page.dart';

import '../../component/base_scaffold.dart';
import '../../component/next_button.dart';
import '../../util/color.dart';

class SellProducePage extends StatelessWidget {
  const SellProducePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      bottomNavigationBar: NextButton(
        color: AppColors.green,
        nextPage: QrPage(), // ✅ ใส่ Widget ปลายทางที่ต้องการ push
        label: 'สร้าง QR Code เพิ่มขาย',
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
                'ขายผลผลิต',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),

          // 🔷 Card quota
          Card(
            child: Container(
              padding: EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 8),
              decoration: ShapeDecoration(
                color: Color(0xFFEBFDFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                shadows: [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(height: 8),

                  Row(
                    children: [
                      // const Icon(Icons.local_florist, color: Colors.orange),
                      Image.asset(
                        'assets/images/ic_v.png',
                        width: 44,
                        height: 44,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'โควต้าผลผลิต : ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                TextSpan(
                                  text: 'ข้าวโพด',
                                  style: TextStyle(
                                    color: Color.fromRGBO(242, 102, 43, 1),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'วันที่เก็บเกี่ยว 20/06/2568',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '120/',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: '200 ตัน',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ),
          const SizedBox(height: 0),
          //
          // // 🔳 Form Inputs
          InputLabel('น้ำหนัก'),
          RoundedInputField(hint: '00'),

          InputLabel('ความชื้นกลาง'),
          MoistureBar(label: '79%'),
          //
          InputLabel('ความชื้นที่รับซื้อ'),
          RoundedInputField(hint: '0%'),
          //
          InputLabel('รายละเอียดเพิ่มเติม'),
          RoundedInputField(hint: 'กรอกรายละเอียดเพิ่มเติม', maxLines: 1),

          //
          // const Spacer(),
        ],
      ),
    );
  }
}

class InputLabel extends StatelessWidget {
  final String text;

  const InputLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 16, bottom: 4),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }
}

class RoundedInputField extends StatelessWidget {
  final String hint;
  final int maxLines;

  const RoundedInputField({super.key, required this.hint, this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.green),
        ),
      ),
    );
  }
}

class MoistureBar extends StatelessWidget {
  final String label;

  const MoistureBar({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.black54, fontSize: 16),
      ),
    );
  }
}
