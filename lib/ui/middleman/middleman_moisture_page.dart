import 'package:flutter/material.dart';

import 'middleman_shared_widgets.dart';

class MiddlemanMoisturePage extends StatelessWidget {
  const MiddlemanMoisturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MiddlemanScreenScaffold(
      title: 'วัดความชื้นข้าวโพด',
      subtitle: 'บันทึกผลการวัดและดูสถานะล็อตที่ต้องลดความชื้นก่อนส่งต่อ',
      actionChips: const [
        MiddlemanTag(label: 'ต้องวัดวันนี้ 7 ล็อต', color: MiddlemanPalette.warning),
        MiddlemanTag(label: 'ค่าเฉลี่ยล่าสุด 13.8%', color: MiddlemanPalette.info),
      ],
      children: [
        _buildMeasurementForm(),
        const MiddlemanSection(
          title: 'สถานะล็อตที่รอวัด',
          icon: Icons.timelapse_outlined,
        ),
        ..._buildPendingBatches(),
        const MiddlemanSection(
          title: 'ประวัติการวัดล่าสุด',
          icon: Icons.history,
        ),
        _buildRecentHistory(),
      ],
    );
  }

  Widget _buildMeasurementForm() {
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
              Icon(Icons.science_outlined, color: MiddlemanPalette.info),
              SizedBox(width: 8),
              Text('บันทึกค่าความชื้น', style: TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'เลือกล็อตจากการรับซื้อหรือสแกนเลขใบรับซื้อเพื่อตรวจวัดความชื้น ทุกล็อตต้องต่ำกว่า 14% ก่อนส่งให้โรงงาน',
            style: TextStyle(fontSize: 13, color: MiddlemanPalette.textSecondary),
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: 'เลขที่ใบรับซื้อ',
              hintText: 'เช่น RC-2024-073',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
              fillColor: const Color(0xFFF7F9FC),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'ค่าความชื้น (%)',
              hintText: 'เช่น 13.5',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
              fillColor: const Color(0xFFF7F9FC),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            maxLines: 2,
            decoration: InputDecoration(
              labelText: 'หมายเหตุเพิ่มเติม',
              hintText: 'ระบุเครื่องมือที่ใช้หรือการแก้ไขที่ต้องทำ',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
              fillColor: const Color(0xFFF7F9FC),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: MiddlemanPalette.primary,
                    side: const BorderSide(color: MiddlemanPalette.primary),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('สแกนใบรับซื้อ'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MiddlemanPalette.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('บันทึกค่าความชื้น'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPendingBatches() {
    final batches = [
      _MoistureBatch(
        name: 'ล็อต RC-2024-070',
        moisture: 'รอตรวจ',
        weight: 'น้ำหนัก 8,200 กก.',
        note: 'รับมาจากคุณจันทนา เมื่อ 09:10 น.',
      ),
      _MoistureBatch(
        name: 'ล็อต RC-2024-071',
        moisture: '15.6%',
        weight: 'น้ำหนัก 5,900 กก.',
        note: 'ต้องอบเพิ่ม 1 ชั่วโมง',
      ),
      _MoistureBatch(
        name: 'ล็อต RC-2024-072',
        moisture: '14.8%',
        weight: 'น้ำหนัก 6,100 กก.',
        note: 'อยู่ในกระบวนการอบแห้ง',
      ),
    ];

    return [
      for (final batch in batches)
        MiddlemanListTile(
          leadingIcon: Icons.inventory_2_outlined,
          iconColor: MiddlemanPalette.warning,
          title: batch.name,
          subtitle: '${batch.weight}\n${batch.note}',
          trailing: MiddlemanTag(
            label: batch.moisture,
            color: batch.moisture == 'รอตรวจ'
                ? MiddlemanPalette.primary
                : MiddlemanPalette.warning,
          ),
        ),
    ];
  }

  Widget _buildRecentHistory() {
    final histories = [
      _MoistureHistory('RC-2024-068', '13.4%', 'อบแห้งสำเร็จ เตรียมส่งโรงงานชัยภูมิ'),
      _MoistureHistory('RC-2024-067', '12.9%', 'คัดเกรด A พร้อมจัดส่งรอบเย็น'),
      _MoistureHistory('RC-2024-066', '15.1%', 'รออบซ้ำ 30 นาทีเพื่อลดค่าความชื้น'),
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
          for (final history in histories)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          history.batch,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          history.note,
                          style: const TextStyle(fontSize: 12, color: MiddlemanPalette.textSecondary),
                        ),
                      ],
                    ),
                  ),
                  MiddlemanTag(
                    label: history.moisture,
                    color: double.tryParse(history.moisture.replaceAll('%', '')) != null &&
                            double.parse(history.moisture.replaceAll('%', '')) <= 14
                        ? MiddlemanPalette.success
                        : MiddlemanPalette.warning,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _MoistureBatch {
  final String name;
  final String moisture;
  final String weight;
  final String note;

  const _MoistureBatch({
    required this.name,
    required this.moisture,
    required this.weight,
    required this.note,
  });
}

class _MoistureHistory {
  final String batch;
  final String moisture;
  final String note;

  const _MoistureHistory(this.batch, this.moisture, this.note);
}
