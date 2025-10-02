import 'package:flutter/material.dart';

import 'middleman_shared_widgets.dart';

class MiddlemanAlertsPage extends StatelessWidget {
  const MiddlemanAlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MiddlemanScreenScaffold(
      title: 'แจ้งเตือนการเผาแปลง',
      subtitle: 'เฝ้าระวังการเผาและควันในพื้นที่คู่สัญญา พร้อมประสานงานเจ้าหน้าที่',
      actionChips: const [
        MiddlemanTag(label: 'แจ้งเตือนใหม่ 2 รายการ', color: MiddlemanPalette.warning),
        MiddlemanTag(label: 'ส่งต่อแล้ว 1 ราย', color: MiddlemanPalette.success),
      ],
      children: [
        _buildMapHint(),
        const MiddlemanSection(
          title: 'แจ้งเตือนล่าสุด',
          icon: Icons.warning_amber_outlined,
        ),
        ..._buildAlerts(),
        const MiddlemanSection(
          title: 'แนวทางจัดการ',
          icon: Icons.checklist_rtl,
        ),
        _buildGuidelineCard(),
      ],
    );
  }

  Widget _buildMapHint() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Color(0x14000000), blurRadius: 12, offset: Offset(0, 6)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.map_outlined, color: MiddlemanPalette.primary),
              SizedBox(width: 8),
              Text('ตำแหน่งจากดาวเทียมล่าสุด',
                  style: TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 160,
            decoration: BoxDecoration(
              color: const Color(0xFFE2ECF7),
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: AssetImage('assets/images/halfcircle.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.white30, BlendMode.srcOver),
              ),
            ),
            child: const Center(
              child: Text(
                'แผนที่ความร้อนการเผา (ตัวอย่าง)',
                style: TextStyle(color: MiddlemanPalette.textSecondary),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'ระบบจะอัปเดตทุก 30 นาที และแจ้งเตือนผ่าน SMS ให้กับเจ้าหน้าที่ประจำอำเภอ',
            style: TextStyle(fontSize: 12, color: MiddlemanPalette.textSecondary),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildAlerts() {
    final alerts = [
      _BurnAlert(
        title: 'หมู่ 4 ตำบลหนองสองห้อง',
        detail: 'ตรวจพบควันหนาแน่นระดับสีส้ม จุดที่ 2 บริเวณทิศเหนือของแปลงคุณสมศรี',
        time: 'เวลา 14:20 น.',
        status: 'แจ้ง อบต. แล้ว',
        statusColor: MiddlemanPalette.primary,
      ),
      _BurnAlert(
        title: 'หมู่ 1 ตำบลคอนฉิม',
        detail: 'ภาพดาวเทียมล่าสุดพบการเผาวัชพืชในร่องน้ำ ใกล้ลานตากข้าวโพด',
        time: 'เวลา 13:45 น.',
        status: 'รอตรวจสอบภาคสนาม',
        statusColor: MiddlemanPalette.warning,
      ),
      _BurnAlert(
        title: 'ตำบลโนนแดง',
        detail: 'ไม่มีการเผาแต่พบควันจากโรงอบ ควรแจ้งเกษตรกรปรับปล่องระบาย',
        time: 'เวลา 11:05 น.',
        status: 'ให้คำแนะนำแล้ว',
        statusColor: MiddlemanPalette.success,
      ),
    ];

    return [
      for (final alert in alerts)
        MiddlemanListTile(
          leadingIcon: Icons.fireplace_outlined,
          iconColor: alert.statusColor,
          title: alert.title,
          subtitle: '${alert.detail}\n${alert.time}',
          trailing: MiddlemanTag(label: alert.status, color: alert.statusColor),
        ),
    ];
  }

  Widget _buildGuidelineCard() {
    final steps = [
      'ติดต่อเกษตรกรในพื้นที่เพื่อหยุดการเผาและตรวจสอบความปลอดภัย',
      'บันทึกภาพก่อนและหลังดำเนินการลงในระบบ',
      'ประสาน อบต. หรือเจ้าหน้าที่ป่าไม้หากพบการเผาครั้งใหญ่',
      'รายงานผลผ่านหน้าแอปเพื่อแจ้งเตือนให้โรงงานปลายทางรับทราบ',
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Color(0x11000000), blurRadius: 10, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('แนวทางปฏิบัติ', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          for (int i = 0; i < steps.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${i + 1}. ', style: const TextStyle(fontWeight: FontWeight.w600)),
                  Expanded(
                    child: Text(
                      steps[i],
                      style: const TextStyle(fontSize: 13, color: MiddlemanPalette.textSecondary),
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

class _BurnAlert {
  final String title;
  final String detail;
  final String time;
  final String status;
  final Color statusColor;

  const _BurnAlert({
    required this.title,
    required this.detail,
    required this.time,
    required this.status,
    required this.statusColor,
  });
}
