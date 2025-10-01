import 'package:flutter/material.dart';

import '../../component/base_scaffold.dart';

class MiddlemanFactoryDeliveryPage extends StatelessWidget {
  const MiddlemanFactoryDeliveryPage({super.key});

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
            _TraceabilityCard(),
            SizedBox(height: 24),
            _SectionTitle('เที่ยวขนส่งวันนี้'),
            SizedBox(height: 12),
            _DeliveryTripList(),
            SizedBox(height: 24),
            _SectionTitle('รายการสแกนเข้าโรงงานล่าสุด'),
            SizedBox(height: 12),
            _ScanHistoryTable(),
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
                'ขายต่อโรงงาน',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'สแกน QR ตรวจสอบย้อนกลับถึงเกษตรกรและเอกสารประกอบ',
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

class _TraceabilityCard extends StatelessWidget {
  const _TraceabilityCard();

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
              Icon(Icons.qr_code_2, color: Color(0xFF6D4C41)),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'ตรวจสอบย้อนกลับก่อนส่งมอบ',
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
              color: const Color(0xFFF7EDE5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: const Icon(Icons.local_shipping, color: Color(0xFF6D4C41)),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'ยานพาหนะทะเบียน 2กข-4586',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'เตรียมสแกน QR จากล็อตสินค้าและระบุรายชื่อเกษตรกรต้นทาง',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF6D4C41),
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
            'แนบเอกสาร: ใบรับซื้อจากเกษตรกร, ใบชั่งน้ำหนัก, ใบตรวจคุณภาพจาก QC',
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

class _DeliveryTripList extends StatelessWidget {
  final List<Map<String, String>> trips = const [
    {
      'trip': 'เที่ยวที่ 1',
      'factory': 'โรงงาน ABC Agro',
      'departure': 'ออกเวลา 09:00 น.',
      'status': 'รอโหลด',
    },
    {
      'trip': 'เที่ยวที่ 2',
      'factory': 'โรงงาน ThaiFeed',
      'departure': 'ออกเวลา 13:00 น.',
      'status': 'กำลังเตรียมเอกสาร',
    },
    {
      'trip': 'เที่ยวที่ 3',
      'factory': 'โรงงาน CPF Korat',
      'departure': 'รอคอนเฟิร์มเวลา',
      'status': 'รอการยืนยัน',
    },
  ];

  const _DeliveryTripList();

  Color _statusColor(String status) {
    switch (status) {
      case 'รอโหลด':
        return const Color(0xFF3C95B5);
      case 'กำลังเตรียมเอกสาร':
        return const Color(0xFFF9A825);
      case 'รอการยืนยัน':
        return const Color(0xFFD84315);
      default:
        return Colors.black54;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: trips
          .map(
            (trip) => Container(
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
                    child: const Icon(Icons.local_shipping, color: Color(0xFF3C95B5)),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${trip['trip']} • ${trip['factory']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          trip['departure']!,
                          style: const TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _statusColor(trip['status']!).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      trip['status']!,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _statusColor(trip['status']!),
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

class _ScanHistoryTable extends StatelessWidget {
  final List<Map<String, String>> records = const [
    {
      'time': '09:20 น.',
      'batch': '#MM240620A',
      'origin': 'วิไลการเกษตร',
      'weight': '24,500 กก.',
    },
    {
      'time': '08:40 น.',
      'batch': '#MM240619C',
      'origin': 'สมหมายไร่ข้าวโพด',
      'weight': '20,000 กก.',
    },
    {
      'time': '08:10 น.',
      'batch': '#MM240619B',
      'origin': 'ชุมชนโนนสูงรวมใจ',
      'weight': '18,000 กก.',
    },
  ];

  const _ScanHistoryTable();

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
                  'ล็อตสินค้า',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'เกษตรกรต้นทาง',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'น้ำหนัก',
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
                      record['batch']!,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(record['origin']!),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      record['weight']!,
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
