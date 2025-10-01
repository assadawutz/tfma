import 'package:flutter/material.dart';

import '../../component/base_scaffold.dart';

class MiddlemanMoisturePage extends StatelessWidget {
  const MiddlemanMoisturePage({super.key});

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
            _GuidelineCard(),
            SizedBox(height: 24),
            _SectionTitle('ล็อตที่รอตรวจวัด'),
            SizedBox(height: 12),
            _WaitingBatchList(),
            SizedBox(height: 24),
            _SectionTitle('ผลการวัดล่าสุด'),
            SizedBox(height: 12),
            _MeasurementResultTable(),
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
                'วัดความชื้นผลผลิต',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'ติดตามการตรวจวัดและจัดลำดับล็อตที่ต้องดำเนินการ',
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

class _GuidelineCard extends StatelessWidget {
  const _GuidelineCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x15000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFE8F8ED),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(12),
            child: const Icon(Icons.water_drop, color: Color(0xFF4DB749)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'แนวทางการวัดความชื้น',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '1. นำตัวอย่าง 1 กิโลกรัมจากแต่ละกระสอบ \n2. อบแห้งที่ 130°C เป็นเวลา 30 นาที \n3. ปล่อยให้เย็นก่อนวัดด้วยเครื่องวัดความชื้น',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
                SizedBox(height: 12),
                Text(
                  'เกณฑ์ผ่านมาตรฐาน ≤ 14% หากสูงกว่านี้ต้องเข้าสู่กระบวนการอบแห้งก่อน',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4DB749),
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

class _WaitingBatchList extends StatelessWidget {
  final List<Map<String, String>> waitingBatches = const [
    {
      'batch': '#QC1248',
      'weight': '18,000 กก.',
      'farmer': 'วิไลการเกษตร',
      'priority': 'ด่วน',
    },
    {
      'batch': '#QC1249',
      'weight': '25,000 กก.',
      'farmer': 'ชุมชนโนนสูงรวมใจ',
      'priority': 'ปกติ',
    },
    {
      'batch': '#QC1250',
      'weight': '12,000 กก.',
      'farmer': 'กลุ่มเกษตรกรบ้านใหม่',
      'priority': 'ปกติ',
    },
  ];

  const _WaitingBatchList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: waitingBatches
          .map(
            (batch) => Container(
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
                      color: const Color(0xFFE5F5FF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.schedule, color: Color(0xFF3C95B5)),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          batch['batch']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'เกษตรกร: ${batch['farmer']} • น้ำหนัก ${batch['weight']}',
                          style: const TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: batch['priority'] == 'ด่วน'
                          ? const Color(0xFFFFEBEE)
                          : const Color(0xFFE8F8ED),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      batch['priority']!,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: batch['priority'] == 'ด่วน'
                            ? const Color(0xFFD84315)
                            : const Color(0xFF4DB749),
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

class _MeasurementResultTable extends StatelessWidget {
  final List<Map<String, String>> results = const [
    {
      'time': '09:30 น.',
      'batch': '#QC1245',
      'average': '12.5%',
      'status': 'ผ่านเกณฑ์',
    },
    {
      'time': '08:45 น.',
      'batch': '#QC1246',
      'average': '14.8%',
      'status': 'ต้องอบเพิ่ม',
    },
    {
      'time': '08:10 น.',
      'batch': '#QC1247',
      'average': '13.2%',
      'status': 'ผ่านเกณฑ์',
    },
  ];

  const _MeasurementResultTable();

  Color _statusColor(String status) {
    switch (status) {
      case 'ผ่านเกณฑ์':
        return const Color(0xFF4DB749);
      case 'ต้องอบเพิ่ม':
        return const Color(0xFFF57C00);
      default:
        return Colors.black54;
    }
  }

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
                  'ล็อต',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'ค่าเฉลี่ยความชื้น',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'สถานะ',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...results.map(
            (result) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(result['time']!),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      result['batch']!,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(result['average']!),
                  ),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _statusColor(result['status']!).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          result['status']!,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _statusColor(result['status']!),
                          ),
                        ),
                      ),
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
