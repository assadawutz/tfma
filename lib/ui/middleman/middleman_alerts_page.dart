import 'package:flutter/material.dart';

import 'middleman_shared_widgets.dart';

class MiddlemanAlertsPage extends StatelessWidget {
  const MiddlemanAlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MiddlemanPageScaffold(
      title: 'แจ้งเตือนการเผาและสิ่งแวดล้อม',
      subtitle: 'เฝ้าระวังพื้นที่เสี่ยง แจ้งเตือนเกษตรกร และประสานหน่วยงานในพื้นที่',
      badges: const [
        MiddlemanPill(
          icon: Icons.warning_amber_rounded,
          label: 'แจ้งเตือนใหม่ 2 รายการ',
          color: MiddlemanColors.orange,
        ),
        MiddlemanPill(
          icon: Icons.sensors,
          label: 'ครอบคลุมรัศมี 5 กม.',
          color: MiddlemanColors.blue,
        ),
      ],
      children: const [
        _AlertSummaryCard(),
        MiddlemanSectionHeader(
          'แจ้งเตือนปัจจุบัน',
          icon: Icons.local_fire_department,
          color: MiddlemanColors.orange,
        ),
        _ActiveAlertsList(),
        MiddlemanSectionHeader(
          'ประวัติการตอบสนอง',
          icon: Icons.history,
          color: MiddlemanColors.blue,
        ),
        _ResponseHistoryCard(),
        MiddlemanSectionHeader(
          'แนวทางการสื่อสารกับเกษตรกร',
          icon: Icons.chat_bubble_outline,
          color: MiddlemanColors.green,
        ),
        _CommunicationToolkitCard(),
      ],
    );
  }
}

class _AlertSummaryCard extends StatelessWidget {
  const _AlertSummaryCard();

  @override
  Widget build(BuildContext context) {
    return MiddlemanCard(
      gradient: const LinearGradient(
        colors: [Color(0xFFFFEFE3), Color(0xFFFFE0CC)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.shield_moon_outlined, color: MiddlemanColors.orange),
              SizedBox(width: 8),
              Text(
                'ระบบเตือนภัยคุณภาพอากาศ',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'มีค่าฝุ่น PM2.5 สูงกว่าค่ามาตรฐาน 1 พื้นที่ และแจ้งเตือนการเผาใกล้แปลงข้าวโพด 1 พื้นที่',
            style: TextStyle(fontSize: 12, color: Colors.black87),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: const [
              _AlertStat(icon: Icons.air, color: MiddlemanColors.purple, label: 'ค่า PM2.5', value: '58 µg/m³'),
              _AlertStat(icon: Icons.thermostat, color: MiddlemanColors.blue, label: 'อุณหภูมิ', value: '35°C'),
              _AlertStat(icon: Icons.waves, color: MiddlemanColors.green, label: 'ความชื้น', value: '42%'),
            ],
          ),
        ],
      ),
    );
  }
}

class _AlertStat extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String value;

  const _AlertStat({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: MiddlemanColors.elevatedShadow,
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(12),
            child: Icon(icon, color: color),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

class _ActiveAlertsList extends StatelessWidget {
  const _ActiveAlertsList();

  @override
  Widget build(BuildContext context) {
    final alerts = [
      const _AlertItem(
        title: 'ตรวจพบควันเผาในรัศมี 2.3 กม.',
        location: 'หมู่ 3 บ้านหนองบัว',
        level: 'ระดับสูง',
        description: 'ดาวเทียม GISTDA แจ้งเตือน 09:20 น. ตรวจพบควันหนาแน่น',
        recommendations: [
          'โทรแจ้งผู้ใหญ่บ้านและเกษตรกรในพื้นที่',
          'บันทึกภาพถ่ายและพิกัดลงระบบ',
        ],
        color: MiddlemanColors.orange,
      ),
      const _AlertItem(
        title: 'ค่า PM2.5 เกินมาตรฐาน 1 จุด',
        location: 'ชุมชนโนนสูงรวมใจ',
        level: 'ระดับปานกลาง',
        description: 'สถานีตรวจวัดเคลื่อนที่แจ้งค่า 58 µg/m³ ต่อเนื่อง 2 ชั่วโมง',
        recommendations: [
          'แจ้งเตือนหลีกเลี่ยงกิจกรรมกลางแจ้ง',
          'ส่งข้อมูลให้สำนักงานเกษตรอำเภอ',
        ],
        color: MiddlemanColors.purple,
      ),
    ];

    return Column(
      children: alerts
          .map(
            (alert) => MiddlemanCard(child: alert),
          )
          .toList(),
    );
  }
}

class _AlertItem extends StatelessWidget {
  final String title;
  final String location;
  final String level;
  final String description;
  final List<String> recommendations;
  final Color color;

  const _AlertItem({
    required this.title,
    required this.location,
    required this.level,
    required this.description,
    required this.recommendations,
    required this.color,
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
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.all(12),
              child: Icon(Icons.local_fire_department, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    location,
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: color.withOpacity(0.18),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Text(
                level,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: color.darken(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          description,
          style: const TextStyle(fontSize: 12, color: Colors.black87),
        ),
        const SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: recommendations
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.check_circle, size: 16, color: color),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          item,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.phone_outlined),
              label: const Text('ติดต่อหน่วยงาน'),
            ),
            const SizedBox(width: 8),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.location_pin),
              label: const Text('เปิดแผนที่'),
            ),
          ],
        ),
      ],
    );
  }
}

class _ResponseHistoryCard extends StatelessWidget {
  const _ResponseHistoryCard();

  @override
  Widget build(BuildContext context) {
    return MiddlemanCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'บันทึกการตอบสนองล่าสุด',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          ),
          const SizedBox(height: 12),
          ...const [
            _ResponseHistoryItem(
              time: '14 มิ.ย. 2568 · 15:40 น.',
              detail: 'ประสาน อบต. บ้านหนองบัว ตรวจสอบพื้นที่เผา และให้คำแนะนำไม่เผาต่อ',
              color: MiddlemanColors.orange,
            ),
            _ResponseHistoryItem(
              time: '13 มิ.ย. 2568 · 17:20 น.',
              detail: 'แจ้งเตือนเกษตรกรผ่านไลน์กลุ่มเรื่องคุณภาพอากาศ และแนะนำการใช้น้ำสปริงเกอร์ลดฝุ่น',
              color: MiddlemanColors.blue,
            ),
            _ResponseHistoryItem(
              time: '12 มิ.ย. 2568 · 09:10 น.',
              detail: 'บันทึกภาพและพิกัดส่งให้สำนักงานเกษตรอำเภอเพื่อดำเนินการต่อ',
              color: MiddlemanColors.green,
            ),
          ],
        ],
      ),
    );
  }
}

class _ResponseHistoryItem extends StatelessWidget {
  final String time;
  final String detail;
  final Color color;

  const _ResponseHistoryItem({
    required this.time,
    required this.detail,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 6),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
                const SizedBox(height: 4),
                Text(
                  detail,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CommunicationToolkitCard extends StatelessWidget {
  const _CommunicationToolkitCard();

  @override
  Widget build(BuildContext context) {
    return MiddlemanCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'เครื่องมือสื่อสารและให้คำแนะนำ',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: const [
              _ToolkitButton(
                icon: Icons.campaign_outlined,
                label: 'ประกาศเสียงตามสาย',
                color: MiddlemanColors.orange,
              ),
              _ToolkitButton(
                icon: Icons.message_outlined,
                label: 'ส่งข้อความไลน์กลุ่ม',
                color: MiddlemanColors.blue,
              ),
              _ToolkitButton(
                icon: Icons.insert_drive_file_outlined,
                label: 'ดาวน์โหลดคู่มือเกษตรกร',
                color: MiddlemanColors.green,
              ),
              _ToolkitButton(
                icon: Icons.camera_alt_outlined,
                label: 'บันทึกภาพหน้างาน',
                color: MiddlemanColors.purple,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ToolkitButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _ToolkitButton({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: OutlinedButton.icon(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          foregroundColor: color,
          side: BorderSide(color: color.withOpacity(0.4)),
        ),
        icon: Icon(icon, color: color),
        label: Text(label, style: TextStyle(color: color)),
      ),
    );
  }
}

extension MiddlemanColorUtils on Color {
  Color darken([double amount = 0.1]) {
    final hsl = HSLColor.fromColor(this);
    final lightness = (hsl.lightness - amount).clamp(0.0, 1.0);
    return hsl.withLightness(lightness).toColor();
  }
}
