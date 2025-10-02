import 'package:flutter/material.dart';

import 'middleman_shared_widgets.dart';

class MiddlemanProcessingPage extends StatelessWidget {
  const MiddlemanProcessingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MiddlemanScreenScaffold(
      title: 'แปรรูปเป็นข้าวโพดเม็ด',
      subtitle: 'ติดตามสถานะการอบแห้ง คัดแยก และแพ็กกิ้งก่อนส่งต่อโรงงาน',
      actionChips: const [
        MiddlemanTag(label: 'อยู่ในไลน์ 4 ล็อต', color: MiddlemanPalette.warning),
        MiddlemanTag(label: 'พร้อมแพ็ก 2 ล็อต', color: MiddlemanPalette.success),
      ],
      children: [
        const MiddlemanSection(
          title: 'ขั้นตอนการแปรรูป',
          icon: Icons.route_outlined,
        ),
        _buildProcessingFlow(),
        const MiddlemanSection(
          title: 'งานที่ต้องติดตาม',
          icon: Icons.assignment_turned_in_outlined,
        ),
        ..._buildTasks(),
        const MiddlemanSection(
          title: 'รายละเอียดล็อตในโรงงาน',
          icon: Icons.inventory_outlined,
        ),
        _buildBatchTable(),
      ],
    );
  }

  Widget _buildProcessingFlow() {
    final steps = [
      _ProcessingStep(
        title: 'อบแห้ง',
        detail: 'ลดความชื้นให้ต่ำกว่า 14%',
        icon: Icons.wb_sunny_outlined,
        color: MiddlemanPalette.warning,
      ),
      _ProcessingStep(
        title: 'คัดแยก/ทำความสะอาด',
        detail: 'แยกสิ่งเจือปนและตรวจสอบคุณภาพ',
        icon: Icons.cleaning_services_outlined,
        color: MiddlemanPalette.info,
      ),
      _ProcessingStep(
        title: 'ชั่งน้ำหนักและบรรจุ',
        detail: 'แพ็กเป็นถุง 30 กก. พร้อมติดป้าย QR',
        icon: Icons.inventory_2_outlined,
        color: MiddlemanPalette.primary,
      ),
      _ProcessingStep(
        title: 'รอจัดส่ง',
        detail: 'จัดเก็บในโกดังที่ควบคุมความชื้น',
        icon: Icons.local_shipping_outlined,
        color: MiddlemanPalette.success,
      ),
    ];

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
        children: [
          for (int i = 0; i < steps.length; i++)
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: steps[i].color.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Icon(steps[i].icon, color: steps[i].color),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            steps[i].title,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            steps[i].detail,
                            style: const TextStyle(
                              fontSize: 12,
                              color: MiddlemanPalette.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (i != steps.length - 1)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        const SizedBox(width: 28),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: const Color(0xFFE0E6EE),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }

  List<Widget> _buildTasks() {
    final tasks = [
      _ProcessingTask(
        title: 'ตรวจสอบเครื่องอบ #2',
        detail: 'แจ้งเตือนอุณหภูมิสูงกว่าปกติ 5°C ต้องรีเซ็ตระบบ',
        status: 'ต้องดำเนินการ',
        statusColor: MiddlemanPalette.warning,
      ),
      _ProcessingTask(
        title: 'คัดแยกสิ่งเจือปน ล็อต RC-2024-071',
        detail: 'ทีมคุณปกรณ์กำลังดำเนินการ คาดเสร็จ 16:30 น.',
        status: 'กำลังดำเนินการ',
        statusColor: MiddlemanPalette.info,
      ),
      _ProcessingTask(
        title: 'เตรียมถุงและสายรัด',
        detail: 'สต็อกเหลือ 120 ถุง ควรเติมเพิ่มก่อนรอบกลางคืน',
        status: 'ควรเตรียมล่วงหน้า',
        statusColor: MiddlemanPalette.primary,
      ),
    ];

    return [
      for (final task in tasks)
        MiddlemanListTile(
          leadingIcon: Icons.task_alt,
          iconColor: task.statusColor,
          title: task.title,
          subtitle: task.detail,
          trailing: MiddlemanTag(label: task.status, color: task.statusColor),
        ),
    ];
  }

  Widget _buildBatchTable() {
    final batches = [
      _ProcessingBatch('RC-2024-068', 'อบแห้ง', '13.4%', 'พร้อมชั่งน้ำหนัก'),
      _ProcessingBatch('RC-2024-069', 'คัดแยก', '14.1%', 'เหลือ 20% ของงาน'),
      _ProcessingBatch('RC-2024-070', 'อบซ้ำ', '15.6%', 'ต้องลดความชื้นเพิ่ม'),
      _ProcessingBatch('RC-2024-071', 'แพ็กกิ้ง', '13.9%', 'คาดเสร็จ 17:00 น.'),
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
        children: [
          Row(
            children: const [
              Expanded(
                flex: 2,
                child: Text(
                  'ล็อต',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(
                child: Text('สถานะ', style: TextStyle(fontWeight: FontWeight.w600)),
              ),
              Expanded(
                child: Text('ความชื้น', style: TextStyle(fontWeight: FontWeight.w600)),
              ),
              Expanded(
                flex: 2,
                child: Text('หมายเหตุ', style: TextStyle(fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const Divider(height: 24),
          for (final batch in batches)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Expanded(flex: 2, child: Text(batch.code)),
                  Expanded(child: Text(batch.status)),
                  Expanded(
                    child: Text(
                      batch.moisture,
                      style: TextStyle(
                        color: double.tryParse(batch.moisture.replaceAll('%', '')) != null &&
                                double.parse(batch.moisture.replaceAll('%', '')) <= 14
                            ? MiddlemanPalette.success
                            : MiddlemanPalette.warning,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(flex: 2, child: Text(batch.note)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _ProcessingStep {
  final String title;
  final String detail;
  final IconData icon;
  final Color color;

  const _ProcessingStep({
    required this.title,
    required this.detail,
    required this.icon,
    required this.color,
  });
}

class _ProcessingTask {
  final String title;
  final String detail;
  final String status;
  final Color statusColor;

  const _ProcessingTask({
    required this.title,
    required this.detail,
    required this.status,
    required this.statusColor,
  });
}

class _ProcessingBatch {
  final String code;
  final String status;
  final String moisture;
  final String note;

  const _ProcessingBatch(this.code, this.status, this.moisture, this.note);
}
