import 'package:flutter/material.dart';

import 'middleman_shared_widgets.dart';

class MiddlemanMoisturePage extends StatelessWidget {
  const MiddlemanMoisturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MiddlemanPageScaffold(
      title: 'วัดความชื้น',
      subtitle: 'ควบคุมคุณภาพข้าวโพดให้ตรงตามเกณฑ์ก่อนเข้าเครื่องแปรรูป',
      badges: const [
        MiddlemanPill(
          icon: Icons.device_thermostat,
          label: 'เครื่องวัดพร้อมใช้งาน',
          color: MiddlemanColors.blue,
        ),
        MiddlemanPill(
          icon: Icons.timer_outlined,
          label: 'ต้องวัดภายใน 4 ชั่วโมง',
          color: MiddlemanColors.orange,
        ),
      ],
      children: const [
        _MoistureLabStatusCard(),
        MiddlemanSectionHeader(
          'ล็อตที่รอวัดความชื้น',
          icon: Icons.hourglass_bottom,
          color: MiddlemanColors.blue,
        ),
        _PendingLotList(),
        MiddlemanSectionHeader(
          'บันทึกผลการวัด',
          icon: Icons.fact_check_outlined,
          color: MiddlemanColors.orange,
        ),
        _MoistureFormCard(),
        MiddlemanSectionHeader(
          'สถิติวันนี้',
          icon: Icons.query_stats,
          color: MiddlemanColors.purple,
        ),
        _DailyMoistureStats(),
      ],
    );
  }
}

class _MoistureLabStatusCard extends StatelessWidget {
  const _MoistureLabStatusCard();

  @override
  Widget build(BuildContext context) {
    return MiddlemanCard(
      gradient: const LinearGradient(
        colors: [Color(0xFFE8F5E9), Color(0xFFD7F2DD)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(18),
            child: const Icon(Icons.science, color: MiddlemanColors.green, size: 28),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'สถานะห้องปฏิบัติการ',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                ),
                SizedBox(height: 6),
                Text(
                  'เครื่องวัดผ่านการคาลิเบรตเมื่อ 07:30 น. พร้อมใช้งานต่อเนื่องอีก 8 ชั่วโมง',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
                SizedBox(height: 12),
                Text(
                  'อุณหภูมิห้อง 25°C · ความชื้นสัมพัทธ์ 52% · พนักงานปฏิบัติการ 2 คน',
                  style: TextStyle(fontSize: 12, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PendingLotList extends StatelessWidget {
  const _PendingLotList();

  @override
  Widget build(BuildContext context) {
    final lots = [
      const _PendingLotItem(
        lotCode: 'A1025',
        farmer: 'วิไลการเกษตร',
        weight: '30,000 กก.',
        queueTime: 'ถึงคลัง 08:30 น.',
        priority: 'ควรวัดก่อน 10:30 น.',
      ),
      const _PendingLotItem(
        lotCode: 'A1026',
        farmer: 'สมหมายไร่ข้าวโพด',
        weight: '22,000 กก.',
        queueTime: 'ถึงคลัง 09:10 น.',
        priority: 'ควรวัดก่อน 11:10 น.',
      ),
      const _PendingLotItem(
        lotCode: 'A1027',
        farmer: 'ชุมชนโนนสูงรวมใจ',
        weight: '18,500 กก.',
        queueTime: 'ถึงคลัง 09:45 น.',
        priority: 'ควรวัดก่อน 11:45 น.',
      ),
    ];

    return Column(
      children: lots
          .map(
            (lot) => MiddlemanCard(
              child: lot,
            ),
          )
          .toList(),
    );
  }
}

class _PendingLotItem extends StatelessWidget {
  final String lotCode;
  final String farmer;
  final String weight;
  final String queueTime;
  final String priority;

  const _PendingLotItem({
    required this.lotCode,
    required this.farmer,
    required this.weight,
    required this.queueTime,
    required this.priority,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: MiddlemanColors.blue.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                'ล็อต $lotCode',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: MiddlemanColors.blue,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                farmer,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.scale, size: 14, color: Colors.black45),
            const SizedBox(width: 4),
            Text(weight, style: const TextStyle(fontSize: 12, color: Colors.black54)),
            const SizedBox(width: 16),
            const Icon(Icons.schedule, size: 14, color: Colors.black45),
            const SizedBox(width: 4),
            Text(queueTime, style: const TextStyle(fontSize: 12, color: Colors.black54)),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: MiddlemanColors.orange.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              const Icon(Icons.warning_amber_rounded,
                  color: MiddlemanColors.orange, size: 16),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  priority,
                  style: const TextStyle(fontSize: 12, color: MiddlemanColors.orange),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('เริ่มวัด'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MoistureFormCard extends StatelessWidget {
  const _MoistureFormCard();

  @override
  Widget build(BuildContext context) {
    return MiddlemanCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.edit_note, color: MiddlemanColors.orange),
              SizedBox(width: 8),
              Text(
                'ฟอร์มบันทึกผล',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
              ),
            ],
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'เลือกล็อตที่ต้องการบันทึก',
              prefixIcon: Icon(Icons.inventory_2_outlined),
            ),
            items: const [
              DropdownMenuItem(value: 'A1025', child: Text('ล็อต A1025 - วิไลการเกษตร')),
              DropdownMenuItem(value: 'A1026', child: Text('ล็อต A1026 - สมหมายไร่ข้าวโพด')),
              DropdownMenuItem(value: 'A1027', child: Text('ล็อต A1027 - ชุมชนโนนสูงรวมใจ')),
            ],
            onChanged: (_) {},
            value: 'A1025',
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ค่าความชื้นเฉลี่ย (%)',
                    prefixIcon: Icon(Icons.opacity),
                  ),
                  keyboardType: TextInputType.number,
                  initialValue: '12.5',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'อุณหภูมิเครื่องอบ (°C)',
                    prefixIcon: Icon(Icons.thermostat_outlined),
                  ),
                  keyboardType: TextInputType.number,
                  initialValue: '55',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'ผู้ตรวจสอบ',
              prefixIcon: Icon(Icons.person_outline),
            ),
            initialValue: 'นางสาวศศิธร',
          ),
          const SizedBox(height: 12),
          TextFormField(
            minLines: 2,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'หมายเหตุ',
              hintText: 'ระบุจุดที่ต้องอบซ้ำหรือสภาพของเมล็ด',
              prefixIcon: Icon(Icons.notes_outlined),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.save),
                label: const Text('บันทึกผล'),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.picture_as_pdf_outlined),
                label: const Text('ส่งรายงาน'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DailyMoistureStats extends StatelessWidget {
  const _DailyMoistureStats();

  @override
  Widget build(BuildContext context) {
    return MiddlemanCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ผลการวัด 6 ชั่วโมงล่าสุด',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          ),
          const SizedBox(height: 12),
          ...const [
            _MoistureStatistic(
              time: '09:50 น.',
              lotCode: 'A1025',
              value: 12.5,
              status: 'ผ่านเกณฑ์',
              color: MiddlemanColors.green,
            ),
            _MoistureStatistic(
              time: '08:40 น.',
              lotCode: 'A1024',
              value: 14.2,
              status: 'ต้องอบเพิ่ม',
              color: MiddlemanColors.orange,
            ),
            _MoistureStatistic(
              time: '07:30 น.',
              lotCode: 'A1023',
              value: 11.8,
              status: 'พร้อมแปรรูป',
              color: MiddlemanColors.purple,
            ),
          ],
        ],
      ),
    );
  }
}

class _MoistureStatistic extends StatelessWidget {
  final String time;
  final String lotCode;
  final double value;
  final String status;
  final Color color;

  const _MoistureStatistic({
    required this.time,
    required this.lotCode,
    required this.value,
    required this.status,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(
                '${value.toStringAsFixed(1)}%',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: color,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ล็อต $lotCode',
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  status,
                  style: TextStyle(fontSize: 12, color: color),
                ),
                const SizedBox(height: 6),
                LinearProgressIndicator(
                  value: value / 20,
                  minHeight: 6,
                  backgroundColor: const Color(0xFFE5E5E5),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            time,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
