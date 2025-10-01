import 'package:flutter/material.dart';

import 'middleman_shared_widgets.dart';

class MiddlemanFactoryDeliveryPage extends StatelessWidget {
  const MiddlemanFactoryDeliveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MiddlemanScreenScaffold(
      title: 'จัดส่งต่อโรงงาน',
      subtitle: 'เตรียมเอกสาร ใบส่งมอบ และติดตามรถขนส่งจนถึงโรงงานปลายทาง',
      actionChips: const [
        MiddlemanTag(label: 'รอบจัดส่งวันนี้ 3 เที่ยว', color: MiddlemanPalette.primary),
        MiddlemanTag(label: 'พร้อมออกเดินทาง 1 เที่ยว', color: MiddlemanPalette.success),
      ],
      children: [
        const MiddlemanSection(
          title: 'ภาพรวมการจัดส่ง',
          icon: Icons.local_shipping_outlined,
        ),
        _buildDeliveryOverview(),
        const MiddlemanSection(
          title: 'เที่ยวรถวันนี้',
          icon: Icons.calendar_today_outlined,
        ),
        ..._buildTrips(),
        const MiddlemanSection(
          title: 'เอกสารและใบส่งมอบ',
          icon: Icons.assignment_outlined,
        ),
        _buildDocumentChecklist(),
      ],
    );
  }

  Widget _buildDeliveryOverview() {
    final stats = [
      _DeliveryStat('ปลายทาง 3 โรงงาน', Icons.factory_outlined, MiddlemanPalette.primary,
          'ชัยภูมิ, ขอนแก่น, ลพบุรี'),
      _DeliveryStat('ปริมาณพร้อมส่ง 42 ตัน', Icons.inventory_2_outlined, MiddlemanPalette.info,
          'แบ่งเป็น 1,400 กระสอบ'),
      _DeliveryStat('ต้องตรวจสอบเอกสาร 2 รายการ', Icons.receipt_long_outlined,
          MiddlemanPalette.warning, 'ใบอนุญาตขนย้าย และใบชั่งน้ำหนัก'),
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
          for (final stat in stats)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: stat.color.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Icon(stat.icon, color: stat.color),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          stat.title,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          stat.detail,
                          style: const TextStyle(fontSize: 12, color: MiddlemanPalette.textSecondary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  List<Widget> _buildTrips() {
    final trips = [
      _DeliveryTrip(
        name: 'เที่ยวที่ 1',
        factory: 'โรงงานชัยภูมิ',
        qrInfo: 'QR โรงงาน: CP-CHAI-001',
        departure: 'ออกเดินทาง 08:30 น.',
        status: 'ถึงปลายทางแล้ว 12:05 น.',
        statusColor: MiddlemanPalette.success,
      ),
      _DeliveryTrip(
        name: 'เที่ยวที่ 2',
        factory: 'โรงงานขอนแก่น',
        qrInfo: 'QR โรงงาน: CP-KKN-004',
        departure: 'กำลังโหลดสินค้า (พร้อม 70%)',
        status: 'ออกเดินทาง 15:30 น.',
        statusColor: MiddlemanPalette.primary,
      ),
      _DeliveryTrip(
        name: 'เที่ยวที่ 3',
        factory: 'โรงงานลพบุรี',
        qrInfo: 'QR โรงงาน: CP-LRI-009',
        departure: 'เตรียมสินค้ารออบแห้งเสร็จ',
        status: 'ต้องวางแผนคนขับสำรอง',
        statusColor: MiddlemanPalette.warning,
      ),
    ];

    return [
      for (final trip in trips)
        MiddlemanListTile(
          leadingIcon: Icons.directions_car_filled,
          iconColor: trip.statusColor,
          title: '${trip.name} • ${trip.factory}',
          subtitle: '${trip.qrInfo}\n${trip.departure}',
          trailing: MiddlemanTag(label: trip.status, color: trip.statusColor),
        ),
    ];
  }

  Widget _buildDocumentChecklist() {
    final documents = [
      _DeliveryDocument('ใบส่งมอบสินค้า', true, 'สแกนและบันทึกเรียบร้อย'),
      _DeliveryDocument('ใบรับรองผลการวัดความชื้น', true, 'แนบสำหรับเที่ยว 1 และ 2'),
      _DeliveryDocument('ใบอนุญาตเคลื่อนย้ายผลผลิต', false, 'รอการอนุมัติจากกรมการค้าภายใน'),
      _DeliveryDocument('ภาพถ่ายก่อนออกเดินทาง', false, 'ต้องถ่ายอัปโหลดก่อน 17:00 น.'),
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
          for (final doc in documents)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Icon(
                    doc.completed ? Icons.check_circle : Icons.radio_button_unchecked,
                    color: doc.completed ? MiddlemanPalette.success : MiddlemanPalette.warning,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doc.title,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          doc.note,
                          style: const TextStyle(fontSize: 12, color: MiddlemanPalette.textSecondary),
                        ),
                      ],
                    ),
                  ),
                  if (!doc.completed)
                    TextButton(
                      onPressed: () {},
                      child: const Text('อัปโหลด'),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _DeliveryStat {
  final String title;
  final IconData icon;
  final Color color;
  final String detail;

  const _DeliveryStat(this.title, this.icon, this.color, this.detail);
}

class _DeliveryTrip {
  final String name;
  final String factory;
  final String qrInfo;
  final String departure;
  final String status;
  final Color statusColor;

  const _DeliveryTrip({
    required this.name,
    required this.factory,
    required this.qrInfo,
    required this.departure,
    required this.status,
    required this.statusColor,
  });
}

class _DeliveryDocument {
  final String title;
  final bool completed;
  final String note;

  const _DeliveryDocument(this.title, this.completed, this.note);
}
