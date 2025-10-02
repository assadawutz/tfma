import 'package:flutter/material.dart';

import 'middleman_shared_widgets.dart';

class MiddlemanInventoryPage extends StatelessWidget {
  const MiddlemanInventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MiddlemanScreenScaffold(
      title: 'จัดการคลังสินค้า',
      subtitle: 'วางแผนการหมุนเวียนสต็อก ดูสภาพแวดล้อม และแจ้งเตือนล็อตที่ต้องดูแล',
      actionChips: const [
        MiddlemanTag(label: 'พื้นที่ว่าง 45%', color: MiddlemanPalette.info),
        MiddlemanTag(label: 'ล็อตใกล้ครบกำหนด 3 รายการ', color: MiddlemanPalette.warning),
        MiddlemanTag(label: 'อุณหภูมิเฉลี่ย 25.6°C', color: MiddlemanPalette.success),
      ],
      children: [
        _buildStorageSummary(),
        const MiddlemanSection(
          title: 'พื้นที่จัดเก็บ',
          icon: Icons.store_mall_directory_outlined,
          trailing: MiddlemanTag(label: 'สแกนล่าสุด 5 นาที', color: MiddlemanPalette.info),
        ),
        _buildStorageGrid(),
        const MiddlemanSection(
          title: 'ล็อตที่ต้องติดตาม',
          icon: Icons.assignment_turned_in_outlined,
        ),
        _buildLotStatus(),
        const MiddlemanSection(
          title: 'รายการเช็กความปลอดภัย',
          icon: Icons.health_and_safety_outlined,
        ),
        _buildChecklist(),
      ],
    );
  }

  Widget _buildStorageSummary() {
    final metrics = [
      (
        title: 'สต็อกพร้อมขาย',
        value: '180 ตัน',
        caption: 'ผ่านการอบแห้งและตรวจคุณภาพครบ',
        icon: Icons.inventory_2_outlined,
        color: MiddlemanPalette.success,
      ),
      (
        title: 'ระหว่างอบแห้ง',
        value: '28 ตัน',
        caption: 'คาดว่าจะเสร็จภายใน 12 ชั่วโมง',
        icon: Icons.waves,
        color: MiddlemanPalette.warning,
      ),
      (
        title: 'ล็อตรอตรวจ',
        value: '5 รายการ',
        caption: 'ต้องตรวจซ้ำความชื้นก่อนโอนเข้าคลัง',
        icon: Icons.fact_check_outlined,
        color: MiddlemanPalette.info,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 900
            ? 3
            : constraints.maxWidth >= 600
                ? 2
                : 1;
        final spacing = 12.0;
        final width = (constraints.maxWidth - spacing * (columns - 1)) / columns;
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final metric in metrics)
              SizedBox(
                width: width,
                child: MiddlemanSummaryCard(
                  title: metric.title,
                  value: metric.value,
                  caption: metric.caption,
                  icon: metric.icon,
                  color: metric.color,
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildStorageGrid() {
    final rooms = [
      (
        name: 'Silo #1',
        fill: 0.82,
        condition: 'ความชื้นเฉลี่ย 13.2% | อุณหภูมิ 25°C',
        color: MiddlemanPalette.primary,
      ),
      (
        name: 'Silo #2',
        fill: 0.68,
        condition: 'ปล่อยอากาศอัตโนมัติทุก 30 นาที',
        color: MiddlemanPalette.info,
      ),
      (
        name: 'โกดังอบแห้ง',
        fill: 0.54,
        condition: 'มีล็อตต้องพลิกกลับ 2 รายการ',
        color: MiddlemanPalette.warning,
      ),
      (
        name: 'โกดังแพ็กกิ้ง',
        fill: 0.37,
        condition: 'พร้อมจัดส่ง 48 ตัน',
        color: MiddlemanPalette.success,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 900
            ? 2
            : constraints.maxWidth >= 560
                ? 2
                : 1;
        final spacing = 12.0;
        final width = (constraints.maxWidth - spacing * (columns - 1)) / columns;
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final room in rooms)
              SizedBox(
                width: width,
                child: Container(
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
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: room.color.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Icon(Icons.storage_rounded, color: room.color),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              room.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          MiddlemanTag(
                            label: '${(room.fill * 100).round()}% เต็ม',
                            color: room.color,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: LinearProgressIndicator(
                          value: room.fill,
                          color: room.color,
                          backgroundColor: room.color.withOpacity(0.12),
                          minHeight: 8,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        room.condition,
                        style: const TextStyle(
                          color: MiddlemanPalette.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildLotStatus() {
    final lots = [
      (
        code: 'LOT-230511-A',
        detail: 'รับซื้อจากกลุ่มบ้านหนองโน 12.5 ตัน',
        status: 'รอตรวจความชื้นซ้ำ',
        color: MiddlemanPalette.warning,
      ),
      (
        code: 'LOT-230510-C',
        detail: 'ผ่านการอบแห้งพร้อมจัดเก็บ 9.3 ตัน',
        status: 'พร้อมย้ายเข้า Silo #2',
        color: MiddlemanPalette.success,
      ),
      (
        code: 'LOT-230509-B',
        detail: 'ระบบเตือนการหมักร้อน อุณหภูมิ 32°C',
        status: 'ต้องพลิกกลับกอง',
        color: MiddlemanPalette.primary,
      ),
    ];

    return Column(
      children: [
        for (final lot in lots)
          MiddlemanListTile(
            leadingIcon: Icons.qr_code_2,
            iconColor: lot.color,
            title: lot.code,
            subtitle: '${lot.detail}\n${lot.status}',
            trailing: MiddlemanTag(label: lot.status, color: lot.color),
          ),
      ],
    );
  }

  Widget _buildChecklist() {
    final items = [
      (
        title: 'ระบบระบายอากาศทำงานปกติ',
        description: 'ตรวจสอบใบพัดและฝุ่นสะสมทุก 4 ชั่วโมง',
      ),
      (
        title: 'ตรวจสารพิษอะฟลาท็อกซิน',
        description: 'ล็อตใหม่ 3 รายการต้องส่งตัวอย่างภายในวันนี้',
      ),
      (
        title: 'ทำความสะอาดพื้นที่โหลดสินค้า',
        description: 'จัดเก็บพาเลทและฉีดพ่นฆ่าเชื้อทุกสิ้นวัน',
      ),
    ];

    return Column(
      children: [
        for (final item in items)
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(color: Color(0x11000000), blurRadius: 10, offset: Offset(0, 4)),
              ],
            ),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: MiddlemanPalette.primary.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: const Icon(Icons.task_alt, color: MiddlemanPalette.primary),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.description,
                        style: const TextStyle(
                          color: MiddlemanPalette.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit_note_outlined, color: MiddlemanPalette.info),
                  tooltip: 'แก้ไขรายการ',
                ),
              ],
            ),
          ),
      ],
    );
  }
}
