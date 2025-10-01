import 'package:flutter/material.dart';

import '../../component/base_scaffold.dart';

class MiddlemanPurchasePage extends StatelessWidget {
  const MiddlemanPurchasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF4FA),
      body: BaseScaffold(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _PageHeader(
              title: 'รับซื้อจากเกษตรกร',
              subtitle: 'สแกน QR ตัดโควต้า ตรวจสอบคุณภาพ และบันทึกข้อมูล',
            ),
            const SizedBox(height: 16),
            _ScanQuotaCard(),
            const SizedBox(height: 24),
            const _SectionTitle('คิวเกษตรกรที่รอรับซื้อ'),
            const SizedBox(height: 12),
            _FarmerQueueList(),
            const SizedBox(height: 24),
            const _SectionTitle('ประวัติรับซื้อวันนี้'),
            const SizedBox(height: 12),
            _DailyPurchaseSummary(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _PageHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const _PageHeader({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 18,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;

  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16,
      ),
    );
  }
}

class _ScanQuotaCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x16000000),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.qr_code_scanner, color: Color(0xFF3C95B5)),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'สแกน QR จากสมุดเกษตรกรเพื่อลดโควต้า',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFE5F5FF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(14),
                  child: const Icon(
                    Icons.photo_camera_outlined,
                    color: Color(0xFF3C95B5),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'แตะเพื่อเริ่มสแกน',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'ระบบจะหักโควต้าและแสดงข้อมูลเกษตรกรทันที',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF3C95B5),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: const Text(
                    'เริ่มสแกน',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'ข้อแนะนำ: ตรวจสอบบัตรประชาชนและสมุดทะเบียนก่อนสแกนทุกครั้ง',
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

class _FarmerQueueList extends StatelessWidget {
  final List<Map<String, dynamic>> queue = const [
    {
      'name': 'วิไลการเกษตร',
      'quota': 45,
      'used': 15,
      'location': 'หมู่ 3 บ้านหนองบัว',
      'ticket': '#A1025',
    },
    {
      'name': 'สมหมายไร่ข้าวโพด',
      'quota': 60,
      'used': 28,
      'location': 'หมู่ 4 บ้านใหม่สว่าง',
      'ticket': '#A1026',
    },
    {
      'name': 'ชุมชนโนนสูงรวมใจ',
      'quota': 80,
      'used': 52,
      'location': 'หมู่ 7 บ้านโนนสูง',
      'ticket': '#A1027',
    },
  ];

  const _FarmerQueueList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: queue
          .map(
            (farmer) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE0E0E0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              farmer['name'] as String,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              farmer['location'] as String,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE5F5FF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'คิว ${farmer['ticket']}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF3C95B5),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'ปริมาณคงเหลือในโควต้า',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 6),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: LinearProgressIndicator(
                                value: (farmer['used'] as int) /
                                    (farmer['quota'] as int),
                                minHeight: 8,
                                backgroundColor: const Color(0xFFE0E0E0),
                                valueColor: const AlwaysStoppedAnimation(
                                  Color(0xFF3C95B5),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${farmer['used']} / ${farmer['quota']} ตัน',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'อัปเดต 10 นาทีที่แล้ว',
                            style:
                                TextStyle(fontSize: 11, color: Colors.black54),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4F9F5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'ต้องการวัดความชื้นหลังรับซื้อ',
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ),
                      const Spacer(),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.note_add_outlined),
                        label: const Text('บันทึกน้ำหนัก'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class _DailyPurchaseSummary extends StatelessWidget {
  final List<Map<String, String>> records = const [
    {
      'time': '09:45 น.',
      'farmer': 'วิไลการเกษตร',
      'weight': '30,000 กก.',
      'moisture': '12.5%',
    },
    {
      'time': '08:30 น.',
      'farmer': 'สมหมายไร่ข้าวโพด',
      'weight': '22,000 กก.',
      'moisture': '13.1%',
    },
    {
      'time': '07:40 น.',
      'farmer': 'ชุมชนโนนสูงรวมใจ',
      'weight': '18,500 กก.',
      'moisture': '15.0%',
    },
  ];

  const _DailyPurchaseSummary();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: const [
              Expanded(
                flex: 2,
                child: Text(
                  'เวลา',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'เกษตรกร',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'น้ำหนักรับซื้อ',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'ความชื้น',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...records.map(
            (record) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(record['time']!),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      record['farmer']!,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(record['weight']!),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      record['moisture']!,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
