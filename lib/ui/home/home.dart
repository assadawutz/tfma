import 'package:flutter/material.dart';

import '../../component/base_scaffold.dart';
import '../area/area_page.dart';
import '../product/create_product_page.dart';

class HomePage extends StatefulWidget {
  var routeName = 'home';

  // final String filePath;
  HomePage({Key? key, required this.routeName}) : super(key: key);

  // HomePage({super.key, required this.routeName});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Row(
            children: [
              Text(
                'สวัสดี',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(
                    Icons.notifications,
                    color: Colors.white,
                    size: 32,
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      alignment: Alignment.topCenter,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '3',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 4),
          Container(
            decoration: ShapeDecoration(
              color: Color(0xFFFFFFFF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
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
            child: Padding(
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 8,
                left: 10,
                right: 10,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/farmer.png'),
                    radius: 35,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'วันจันทร์ที่ 16 มิถุนายน 2568',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontSize: 12,
                              color: Color.fromRGBO(242, 102, 43, 1),
                              fontWeight: FontWeight.w500),
                        ),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: Colors.black, // สี default
                            ),
                            children: [
                              TextSpan(
                                text: 'นายทองดี ใจดี ',
                                style: TextStyle(
                                  fontFamily: "Kanit",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontFamily: "Kanit",

                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.black87, // สี default
                            ),
                            children: [
                              TextSpan(
                                text: 'ที่อยู่ : ',
                              ),
                              TextSpan(
                                text: 'บ้านหนองบัว, อ.เมือง, จ.นครราชสีมา',
                                style: TextStyle(
                                  fontFamily: "Kanit",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,

                                  color: Colors.black87, // สี default
                                ),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontFamily: "Kanit",

                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.black87, // สี default
                            ),
                            children: [
                              TextSpan(
                                text: 'หมายเลขเกษตรกร : ',
                              ),
                              TextSpan(
                                text: '123456XX',
                                style: TextStyle(
                                  fontFamily: "Kanit",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,

                                  color: Colors.black87, // สี default
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => MyPlotPage()),
                    );
                  },
                  child: Container(
                    height: 84,
                    padding: const EdgeInsets.only(
                      left: 8,
                      top: 8,
                      bottom: 8,
                      right: 0,
                    ),
                    decoration: ShapeDecoration(
                      color: Color(0xFFF0FFEF),
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
                    child: Row(
                      children: [
                        Spacer(),
                        Column(
                          children: [
                            const SizedBox(height: 8),
                            const Text(
                              'ขนาดพื้นที่:',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '80 ไร่',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF4DB749),
                              ),
                            ),
                          ],
                        ),

                        Spacer(),
                        Image.asset(
                          'assets/images/ic_area.png',
                          // width: 64,
                          // height: 64,
                        ),
                        // Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),

              // Spacer(),
              Expanded(
                child: Container(
                  height: 84,
                  padding: const EdgeInsets.all(8),
                  decoration: ShapeDecoration(
                    color: Color(0xFFFFF5DC),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: const [
                      Spacer(),
                      Text(
                        'ไม่มีการเผาไหม้',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      // SizedBox(width: 8),
                      Spacer(),

                      Icon(
                        Icons.local_fire_department,
                        color: Colors.orange,
                        size: 50,
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
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
                      const SizedBox(width: 8),

                      // const Icon(Icons.local_florist, color: Colors.orange),
                      Image.asset(
                        'assets/images/ic_v.png',
                        width: 44,
                        height: 44,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 16),
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
                  SizedBox(height: 6),
                ],
              ),
            ),
          ),
          const SizedBox(height: 0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SellProducePage()),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 48,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 9,
                    ),
                    decoration: ShapeDecoration(
                      color: Color(0xFF4DB749),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 5,
                          offset: Offset(3, 3),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'ขาย',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ประวัติการขาย',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'ดูทั้งหมด',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline, // ✅ เส้นใต้
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(44),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    child: Table(
                      columnWidths: const {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(2),
                        2: FlexColumnWidth(2),
                      },
                      border: TableBorder(
                        horizontalInside: BorderSide(
                          color: Color.fromRGBO(232, 232, 232, 1),
                        ),
                        verticalInside: BorderSide(
                          color: Color.fromRGBO(232, 232, 232, 1),
                        ),
                      ),
                      children: [
                        TableRow(
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(242, 102, 43, 1),
                          ),
                          children: [
                            tableHeaderCell('ผู้รวบรวมผลผลิต'),
                            tableHeaderCell('วันที่ขาย'),
                            tableHeaderCell('จำนวน/ตัน'),
                          ],
                        ),
                        tableRow('สุมณฑ์ธุรกิจการเกษตร', '20/06/2568', '125'),
                        tableRow('ชัชช์ฟาร์มเกรด', '20/06/2568', '78'),
                        tableRow('วีไลผลิตภัณฑ์', '20/06/2568', '58'),
                        tableRow('เชียงรายรวมผลผลิต', '20/06/2568', '305'),
                        tableRow(
                          'เครือข่ายรวมผลผลิตชุมชน',
                          '20/06/2568',
                          '408',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

TableRow tableRow(String a, String b, String c) {
  return TableRow(
    children: [tableCell(a, isBold: true), tableCell(b), tableCell(c)],
  );
}

Widget tableHeaderCell(String text) => Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 15, left: 8, right: 8),
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

Widget tableCell(String text, {bool isBold = false}) => Padding(
      padding: const EdgeInsets.only(left: 16, right: 10, top: 16, bottom: 16),
      child: Container(
        height: 72,
        alignment: Alignment.center,
        child: Text(
          text,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
