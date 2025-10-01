import 'package:flutter/material.dart';

import 'middleman_shared_widgets.dart';

class MiddlemanProcessingPage extends StatelessWidget {
  const MiddlemanProcessingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MiddlemanPageScaffold(
      title: 'ควบคุมการแปรรูป',
      subtitle: 'ติดตามการอบ การคัดแยก และการแพ็กเมล็ดข้าวโพดให้พร้อมขาย',
      badges: const [
        MiddlemanPill(
          icon: Icons.factory_outlined,
          label: 'สายการผลิตทำงาน 3/4',
          color: MiddlemanColors.orange,
        ),
        MiddlemanPill(
          icon: Icons.inventory,
          label: 'พร้อมแพ็ก 18 ตัน',
          color: MiddlemanColors.green,
        ),
      ],
      children: const [
        _ProcessingOverviewCard(),
        MiddlemanSectionHeader(
          'งานในสายการผลิต',
          icon: Icons.precision_manufacturing,
          color: MiddlemanColors.orange,
        ),
        _ProductionStepList(),
        MiddlemanSectionHeader(
          'ตรวจสอบคุณภาพ',
          icon: Icons.verified_outlined,
          color: MiddlemanColors.blue,
        ),
        _QualityChecklist(),
        MiddlemanSectionHeader(
          'บันทึกผลผลิตที่พร้อมจำหน่าย',
          icon: Icons.inventory_2_outlined,
          color: MiddlemanColors.green,
        ),
        _PackagingFormCard(),
      ],
    );
  }
}

class _ProcessingOverviewCard extends StatelessWidget {
  const _ProcessingOverviewCard();

  @override
  Widget build(BuildContext context) {
    return MiddlemanCard(
      gradient: const LinearGradient(
        colors: [Color(0xFFFFF1E6), Color(0xFFFFE0CC)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'สถานะโรงงานย่อย',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final width = (constraints.maxWidth - 24) / 2;
              final tiles = const [
                _ProcessingStatTile(
                  title: 'เตาอบทำงาน',
                  value: '2 เครื่อง',
                  caption: 'ใช้พลังงาน 78%',
                  icon: Icons.fireplace,
                  color: MiddlemanColors.orange,
                ),
                _ProcessingStatTile(
                  title: 'เครื่องคัดขนาด',
                  value: '92% สำเร็จ',
                  caption: 'เครื่องที่ 3 ต้องตรวจสอบ',
                  icon: Icons.sort,
                  color: MiddlemanColors.blue,
                ),
                _ProcessingStatTile(
                  title: 'สายการแพ็ก',
                  value: '18 ตัน',
                  caption: 'เหลืออีก 6 ตันในคิว',
                  icon: Icons.inventory,
                  color: MiddlemanColors.green,
                ),
                _ProcessingStatTile(
                  title: 'คุณภาพความชื้นเฉลี่ย',
                  value: '12.8%',
                  caption: 'อยู่ในเกณฑ์มาตรฐาน',
                  icon: Icons.water_drop,
                  color: MiddlemanColors.purple,
                ),
              ];

              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: tiles
                    .map(
                      (tile) => SizedBox(width: width, child: tile),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ProcessingStatTile extends StatelessWidget {
  final String title;
  final String value;
  final String caption;
  final IconData icon;
  final Color color;

  const _ProcessingStatTile({
    required this.title,
    required this.value,
    required this.caption,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: MiddlemanColors.elevatedShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(12),
            child: Icon(icon, color: color),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 22,
              color: color,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            caption,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

class _ProductionStepList extends StatelessWidget {
  const _ProductionStepList();

  @override
  Widget build(BuildContext context) {
    final steps = [
      const _ProductionStep(
        title: '1. รับข้าวโพดเข้าคลัง',
        detail: 'ยืนยันล็อต A1025, A1026 และเคลื่อนย้ายเข้าสายการอบ',
        color: MiddlemanColors.blue,
        icon: Icons.inventory_2,
        progress: 1,
        actionLabel: 'ดูประวัติรับซื้อ',
      ),
      const _ProductionStep(
        title: '2. อบลดความชื้น',
        detail: 'เตาอบหมายเลข 2 กำลังทำงาน สามารถรับเพิ่มได้อีก 8 ตัน',
        color: MiddlemanColors.orange,
        icon: Icons.local_fire_department,
        progress: 0.7,
        actionLabel: 'ปรับเวลาอบ',
      ),
      const _ProductionStep(
        title: '3. คัดแยกและคัดขนาด',
        detail: 'เครื่องคัดหมายเลข 3 แจ้งเตือน ต้องทำความสะอาดตะแกรง',
        color: MiddlemanColors.purple,
        icon: Icons.settings_suggest,
        progress: 0.5,
        actionLabel: 'แจ้งซ่อมบำรุง',
      ),
      const _ProductionStep(
        title: '4. บรรจุและติดฉลาก',
        detail: 'กำลังบรรจุ 10 ตัน จัดส่งโรงงานขอนแก่นในรอบ 16:30 น.',
        color: MiddlemanColors.green,
        icon: Icons.assignment_turned_in,
        progress: 0.6,
        actionLabel: 'ตรวจสอบใบสั่งงาน',
      ),
    ];

    return Column(
      children: steps
          .map(
            (step) => MiddlemanCard(
              child: step,
            ),
          )
          .toList(),
    );
  }
}

class _ProductionStep extends StatelessWidget {
  final String title;
  final String detail;
  final Color color;
  final IconData icon;
  final double progress;
  final String actionLabel;

  const _ProductionStep({
    required this.title,
    required this.detail,
    required this.color,
    required this.icon,
    required this.progress,
    required this.actionLabel,
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
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(14),
              child: Icon(icon, color: color),
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
                    detail,
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        LinearProgressIndicator(
          value: progress,
          minHeight: 8,
          backgroundColor: const Color(0xFFE5E5E5),
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: Text(actionLabel),
          ),
        ),
      ],
    );
  }
}

class _QualityChecklist extends StatelessWidget {
  const _QualityChecklist();

  @override
  Widget build(BuildContext context) {
    final checkpoints = const [
      _QualityCheckpoint(
        title: 'ความชื้นเมล็ด',
        status: '12.8% (ผ่าน)',
        color: MiddlemanColors.green,
        icon: Icons.water_drop,
        description: 'ค่ามาตรฐาน 11-14% ตามข้อกำหนดโรงงาน',
      ),
      _QualityCheckpoint(
        title: 'ขนาดและความสะอาด',
        status: 'ผ่านเกณฑ์ 96%',
        color: MiddlemanColors.blue,
        icon: Icons.checklist_rtl,
        description: 'เมล็ดสมบูรณ์ ตรวจไม่พบสิ่งปนเปื้อน',
      ),
      _QualityCheckpoint(
        title: 'สารพิษตกค้าง',
        status: 'รอผล Lab ภายนอก',
        color: MiddlemanColors.orange,
        icon: Icons.biotech_outlined,
        description: 'ส่งตัวอย่างไปยังห้อง Lab ของอำเภอ (ผลภายใน 24 ชม.)',
      ),
    ];

    return Column(
      children: checkpoints
          .map(
            (checkpoint) => MiddlemanCard(
              child: checkpoint,
            ),
          )
          .toList(),
    );
  }
}

class _QualityCheckpoint extends StatelessWidget {
  final String title;
  final String status;
  final Color color;
  final IconData icon;
  final String description;

  const _QualityCheckpoint({
    required this.title,
    required this.status,
    required this.color,
    required this.icon,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(14),
          child: Icon(icon, color: color),
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
                status,
                style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              Text(
                description,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PackagingFormCard extends StatelessWidget {
  const _PackagingFormCard();

  @override
  Widget build(BuildContext context) {
    return MiddlemanCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'อัปเดตผลผลิตที่พร้อมจำหน่าย',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'เลือกล็อต',
                    prefixIcon: Icon(Icons.inventory_2_outlined),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'A1025', child: Text('ล็อต A1025')), 
                    DropdownMenuItem(value: 'A1026', child: Text('ล็อต A1026')), 
                    DropdownMenuItem(value: 'A1024', child: Text('ล็อต A1024')), 
                  ],
                  onChanged: (_) {},
                  value: 'A1025',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'น้ำหนักพร้อมขาย (ตัน)',
                    prefixIcon: Icon(Icons.scale_outlined),
                  ),
                  initialValue: '18',
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ประเภทบรรจุภัณฑ์',
                    prefixIcon: Icon(Icons.inventory_sharp),
                  ),
                  initialValue: 'กระสอบ 50 กก.',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'จำนวนกระสอบ',
                    prefixIcon: Icon(Icons.numbers),
                  ),
                  initialValue: '360',
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextFormField(
            minLines: 2,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'หมายเหตุ',
              hintText: 'ระบุความพร้อมเครื่องจักร แผนส่งต่อ หรือปัญหาที่พบ',
              prefixIcon: Icon(Icons.notes),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.save_outlined),
                label: const Text('บันทึกผลผลิต'),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.share_outlined),
                label: const Text('แชร์ให้ทีมขาย'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
