import 'package:flutter/material.dart';

import '../../component/base_scaffold.dart';

class MiddlemanProcessingPage extends StatelessWidget {
  const MiddlemanProcessingPage({super.key});

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
            _ProcessingOverview(),
            SizedBox(height: 24),
            _SectionTitle('แผนการแปรรูปวันนี้'),
            SizedBox(height: 12),
            _ProcessingPlanList(),
            SizedBox(height: 24),
            _SectionTitle('ผลผลิตที่พร้อมจัดเก็บ'),
            SizedBox(height: 12),
            _ReadyToStoreGrid(),
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
                'แปรรูปเป็นข้าวโพดเม็ด',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'ติดตามขั้นตอนอบแห้ง แยกคุณภาพ และจัดเก็บคลังสินค้า',
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

class _ProcessingOverview extends StatelessWidget {
  const _ProcessingOverview();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ขั้นตอนการแปรรูป',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Expanded(
                child: _ProcessStep(
                  title: 'อบแห้ง',
                  description: 'ตู้ 1, 2 ทำงานอยู่ อุณหภูมิ 120°C',
                  icon: Icons.local_fire_department,
                  color: Color(0xFFF57C00),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _ProcessStep(
                  title: 'คัดแยก',
                  description: 'เครื่องคัดพร้อมใช้ ตรวจสอบตะแกรงทุก 2 ชม.',
                  icon: Icons.precision_manufacturing,
                  color: Color(0xFF3C95B5),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _ProcessStep(
                  title: 'จัดเก็บ',
                  description: 'ไซโล B คงเหลือ 40% สำหรับล็อตที่ผ่าน',
                  icon: Icons.warehouse,
                  color: Color(0xFF4DB749),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProcessStep extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const _ProcessStep({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProcessingPlanList extends StatelessWidget {
  final List<Map<String, String>> plans = const [
    {
      'time': '09:30 น.',
      'batch': '#MM240620A',
      'input': '30,000 กก.',
      'output': 'ข้าวโพดเม็ด 24,500 กก.',
      'status': 'กำลังอบแห้ง',
    },
    {
      'time': '11:00 น.',
      'batch': '#MM240620B',
      'input': '25,000 กก.',
      'output': 'กำหนดเริ่มอบ 11:30 น.',
      'status': 'เตรียมเข้าเตา',
    },
    {
      'time': '13:00 น.',
      'batch': '#MM240620C',
      'input': '20,000 กก.',
      'output': 'รอผลความชื้นจาก QC',
      'status': 'รอตรวจสอบ',
    },
  ];

  const _ProcessingPlanList();

  Color _statusColor(String status) {
    switch (status) {
      case 'กำลังอบแห้ง':
        return const Color(0xFFF57C00);
      case 'เตรียมเข้าเตา':
        return const Color(0xFF3C95B5);
      case 'รอตรวจสอบ':
        return const Color(0xFF6D4C41);
      default:
        return Colors.black54;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: plans
          .map(
            (plan) => Container(
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
                              plan['batch']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'เวลาเริ่ม ${plan['time']}',
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
                          color: _statusColor(plan['status']!).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          plan['status']!,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _statusColor(plan['status']!),
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
                              'วัตถุดิบเข้ากระบวนการ',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(plan['input']!),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'ผลผลิตคาดการณ์/ได้จริง',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(plan['output']!),
                          ],
                        ),
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

class _ReadyToStoreGrid extends StatelessWidget {
  final List<Map<String, String>> stock = const [
    {
      'grade': 'A',
      'weight': '95,000 กก.',
      'silo': 'ไซโล B',
      'eta': 'พร้อมส่ง',
    },
    {
      'grade': 'B',
      'weight': '42,000 กก.',
      'silo': 'โกดัง 2',
      'eta': 'พร้อมภายใน 6 ชม.',
    },
    {
      'grade': 'C',
      'weight': '18,500 กก.',
      'silo': 'โกดัง 1',
      'eta': 'ตรวจสอบคุณภาพซ้ำ',
    },
  ];

  const _ReadyToStoreGrid();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: stock
          .map(
            (item) => Container(
              width: 164,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE0E0E0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F4F4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'เกรด ${item['grade']}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    item['weight']!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item['silo']!,
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item['eta']!,
                    style: const TextStyle(fontSize: 12, color: Colors.black45),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
