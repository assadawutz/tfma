import 'package:flutter/material.dart';
import 'package:tfma/component/base_scaffold.dart';

import '../../component/switcher.dart';

class MyPlotPage extends StatefulWidget {
  const MyPlotPage({super.key});

  @override
  State<MyPlotPage> createState() => _MyPlotPageState();
}

class _MyPlotPageState extends State<MyPlotPage> {
  bool isPlantSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF4FA),
      body: BaseScaffold(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(width: 12),
                const Text(
                  'แปลงของฉัน',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.only(left: 16),
              decoration: ShapeDecoration(
                color: const Color(0xFFF0FFEF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'ขนาดพื้นที่:',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontFamily: 'Kanit',
                        ),
                      ),
                      Text(
                        '80 ไร่',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF4DB749),
                          height: 1.3,
                        ),
                      ),
                      Text(
                        'ข้าวโพด/อ้อย/ยางพารา',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Image.asset(
                    'assets/images/ic_area.png',
                    fit: BoxFit.cover,
                    width: 100,
                  ),
                ],
              ),
            ),

            // ✅ Toggle Switcher
            const SizedBox(height: 16),
            ToggleSwitcher(
              onToggle: (value) {
                setState(() {
                  isPlantSelected = value;
                });
              },
            ),
            const SizedBox(height: 16),

            // 🧾 หัวข้อ
            const Text(
              'ผลผลิตทั้งหมด',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 8),

            // 📋 ตารางข้อมูล
            if (isPlantSelected) buildPlantTable() else buildFireTable(),
          ],
        ),
      ),
    );
  }

  // ตารางการเพาะปลูก
  Widget buildPlantTable() {
    return buildTable([
      tableRow('ข้าวโพด', '20/06/2568', '30'),
      tableRow('อ้อย', '20/06/2568', '20'),
      tableRow('ยางพารา', '20/06/2568', '30'),
    ]);
  }

  // ตารางการเผา
  Widget buildFireTable() {
    return buildTable([
      tableRow('เศษฟางข้าวโพด', '15/06/2568', '10'),
      tableRow('ใบอ้อย', '10/06/2568', '8'),
    ]);
  }

  Widget buildTable(List<TableRow> rows) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(246, 246, 246, 1),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
        child: isPlantSelected == true
            ? Table(
                columnWidths: {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(1.5),
                },
                border: TableBorder(
                  horizontalInside: const BorderSide(
                    color: Color.fromRGBO(232, 232, 232, 1),
                  ),
                  verticalInside: const BorderSide(
                    color: Color.fromRGBO(232, 232, 232, 1),
                  ),
                ),
                children: [
                  // Header
                  isPlantSelected
                      ? TableRow(
                          decoration: const BoxDecoration(
                            color: Color(0xFFE25E30),
                          ),
                          children: [
                            tableHeaderCell('ผลผลิต'),
                            tableHeaderCell('วันที่ที่ขาย'),
                            tableHeaderCell('จำนวน/ไร่'),
                          ],
                        )
                      : TableRow(
                          decoration: const BoxDecoration(
                            color: Color(0xFFE25E30),
                          ),
                          children: [
                            tableHeaderCell('วันที่ที่ขาย'),
                            tableHeaderCell('จำนวน/ไร่'),
                          ],
                        ),
                  ...rows,
                ],
              )
            : Table(
                columnWidths: {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(1.5),
                },
                border: TableBorder(
                  horizontalInside: const BorderSide(
                    color: Color.fromRGBO(232, 232, 232, 1),
                  ),
                  verticalInside: const BorderSide(
                    color: Color.fromRGBO(232, 232, 232, 1),
                  ),
                ),
                children: [
                  // Header
                  isPlantSelected
                      ? TableRow(
                          decoration: const BoxDecoration(
                            color: Color(0xFFE25E30),
                          ),
                          children: [
                            tableHeaderCell('ผลผลิต'),
                            tableHeaderCell('วันที่ที่ขาย'),
                            tableHeaderCell('จำนวน/ไร่'),
                          ],
                        )
                      : TableRow(
                          decoration: const BoxDecoration(
                            color: Color(0xFFE25E30),
                          ),
                          children: [
                            tableHeaderCell('วันที่ที่ขาย'),
                            tableHeaderCell('จำนวน/ไร่'),
                          ],
                        ),
                  ...rows,
                ],
              ),
      ),
    );
  }

  TableRow tableRow(String a, String b, String c) {
    if (isPlantSelected) {
      return TableRow(
        children: [tableCell(a, isBold: true), tableCell(b), tableCell(c)],
      );
    } else {
      return TableRow(
        children: [
          tableCell(b),
          tableCell(c, textColor: Colors.red), // ✅ คอลัมน์สุดท้ายสีแดง
        ],
      );
    }
  }

  Widget tableHeaderCell(String text) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
    child: Container(
      height: 30,
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 13,
          height: 0.12,
        ),
      ),
    ),
  );

  Widget tableCell(String text, {bool isBold = false, Color? textColor}) =>
      Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 10,
          top: 16,
          bottom: 16,
        ),
        child: Container(
          height: 72,
          alignment: Alignment.center,
          child: Text(
            text,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
              color: textColor ?? Colors.black, // 👈 ใช้สีถ้ามี ไม่งั้นเป็นดำ
            ),
          ),
        ),
      );
}
