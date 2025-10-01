import 'package:flutter/material.dart';

import '../../component/base_scaffold.dart';

class MiddlemanAlertsPage extends StatelessWidget {
  const MiddlemanAlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF4FA),
      body: BaseScaffold(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _PageHeader(),
            SizedBox(height: 20),
            _InstructionCard(),
            SizedBox(height: 24),
            _SectionTitle('แจ้งเตือนล่าสุด'),
            SizedBox(height: 12),
            _AlertList(),
            SizedBox(height: 24),
            _SectionTitle('ประสานงานที่ดำเนินการแล้ว'),
            SizedBox(height: 12),
            _FollowUpList(),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _PageHeader extends StatelessWidget {
  const _PageHeader();

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
            children: const [
              Text(
                'แจ้งเตือนการเผาแปลง',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'จับตาพื้นที่เสี่ยงและแจ้งเตือนเกษตรกรอย่างทันท่วงที',
                style: TextStyle(color: Colors.white70, fontSize: 12),
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

class _InstructionCard extends StatelessWidget {
  const _InstructionCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFE9E6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.warning_amber_rounded, color: Color(0xFFD84315)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'แนวทางรับมือการเผาแปลง',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '• โทรแจ้งเกษตรกรเจ้าของแปลงทันทีเมื่อได้รับแจ้งเตือน\n• ประสาน อบต. และหน่วยดับเพลิงในพื้นที่\n• บันทึกเหตุการณ์พร้อมรูปภาพและค่าควัน',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
                SizedBox(height: 12),
                Text(
                  'หากพบการเผาซ้ำ ให้บันทึกในรายการติดตามเพื่อเตือนก่อนฤดูกาลถัดไป',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFD84315),
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

class _AlertList extends StatelessWidget {
  final List<Map<String, String>> alerts = const [
    {
      'time': '09:10 น.',
      'village': 'หมู่ 7 บ้านโนนสูง',
      'farmer': 'วิสาหกิจชุมชนโนนสูง',
      'status': 'กำลังตรวจสอบ',
    },
    {
      'time': '08:20 น.',
      'village': 'หมู่ 5 บ้านหนองคู',
      'farmer': 'นายสมศักดิ์ ใจดี',
      'status': 'ประสานหน่วยงานแล้ว',
    },
    {
      'time': '07:45 น.',
      'village': 'หมู่ 2 บ้านหนองบัว',
      'farmer': 'กลุ่มเกษตรกรบ้านหนองบัว',
      'status': 'รับทราบ - รอการยืนยัน',
    },
  ];

  const _AlertList();

  Color _statusColor(String status) {
    switch (status) {
      case 'กำลังตรวจสอบ':
        return const Color(0xFFF9A825);
      case 'ประสานหน่วยงานแล้ว':
        return const Color(0xFF4DB749);
      case 'รับทราบ - รอการยืนยัน':
        return const Color(0xFF3C95B5);
      default:
        return Colors.black54;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: alerts
          .map(
            (alert) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE0E0E0)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE9E6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.local_fire_department, color: Color(0xFFD84315)),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${alert['village']} • ${alert['time']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'เจ้าของแปลง: ${alert['farmer']}',
                          style: const TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _statusColor(alert['status']!).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      alert['status']!,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _statusColor(alert['status']!),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class _FollowUpList extends StatelessWidget {
  final List<Map<String, String>> followUps = const [
    {
      'date': '19 มิ.ย. 2568',
      'farmer': 'นายอดิศักดิ์ อดุลย์',
      'action': 'ส่งจดหมายเตือนและอบรมการจัดการซัง',
    },
    {
      'date': '18 มิ.ย. 2568',
      'farmer': 'กลุ่มเกษตรกรบ้านใหม่',
      'action': 'จัดทำแปลงสาธิตการไถกลบให้เข้าร่วม',
    },
    {
      'date': '17 มิ.ย. 2568',
      'farmer': 'นางสมใจ ใส่ใจ',
      'action': 'ติดตามซ้ำหลังการแจ้งเตือนรอบสอง',
    },
  ];

  const _FollowUpList();

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
                  'วันที่',
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
                flex: 4,
                child: Text(
                  'การติดตาม',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...followUps.map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(item['date']!),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      item['farmer']!,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(item['action']!),
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
