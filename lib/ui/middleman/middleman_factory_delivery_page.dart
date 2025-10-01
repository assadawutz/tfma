import 'package:flutter/material.dart';

import 'middleman_shared_widgets.dart';

class MiddlemanFactoryDeliveryPage extends StatelessWidget {
  const MiddlemanFactoryDeliveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MiddlemanPageScaffold(
      title: 'ส่งต่อโรงงาน',
      subtitle: 'จัดคิวรถบรรทุก สแกนย้อนกลับถึงเกษตรกร และสร้างเอกสารส่งมอบ',
      badges: const [
        MiddlemanPill(
          icon: Icons.local_shipping_outlined,
          label: 'เที่ยวส่งวันนี้ 3 รอบ',
          color: MiddlemanColors.green,
        ),
        MiddlemanPill(
          icon: Icons.qr_code,
          label: 'ต้องสแกนย้อนกลับทุกเที่ยว',
          color: MiddlemanColors.blue,
        ),
      ],
      children: const [
        _DeliveryOverviewCard(),
        MiddlemanSectionHeader(
          'การจัดโหลดและเอกสาร',
          icon: Icons.assignment_outlined,
          color: MiddlemanColors.blue,
        ),
        _LoadingPlanList(),
        MiddlemanSectionHeader(
          'ติดตามการขนส่ง',
          icon: Icons.alt_route,
          color: MiddlemanColors.green,
        ),
        _TransportTrackingCard(),
        MiddlemanSectionHeader(
          'สร้างเอกสารส่งโรงงาน',
          icon: Icons.picture_as_pdf,
          color: MiddlemanColors.orange,
        ),
        _DeliveryFormCard(),
      ],
    );
  }
}

class _DeliveryOverviewCard extends StatelessWidget {
  const _DeliveryOverviewCard();

  @override
  Widget build(BuildContext context) {
    return MiddlemanCard(
      gradient: const LinearGradient(
        colors: [Color(0xFFE9F7FF), Color(0xFFD8EEFF)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ภาพรวมการส่งมอบวันนี้',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
          const SizedBox(height: 12),
          const Text(
            'โรงงานปลายทาง: ไทยฟีด จ.ขอนแก่น · ไทยฟีด จ.ชัยภูมิ · โรงงานอาหารสัตว์สหกรณ์ยโสธร',
            style: TextStyle(fontSize: 12, color: Colors.black87),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: const [
              _DeliveryStatTile(
                icon: Icons.inventory,
                color: MiddlemanColors.orange,
                label: 'น้ำหนักรวม',
                value: '82 ตัน',
              ),
              _DeliveryStatTile(
                icon: Icons.timer,
                color: MiddlemanColors.blue,
                label: 'เวลาขนส่งเฉลี่ย',
                value: '2 ชม. 15 นาที',
              ),
              _DeliveryStatTile(
                icon: Icons.verified_outlined,
                color: MiddlemanColors.green,
                label: 'ผ่านตรวจคุณภาพ',
                value: 'ทุกเที่ยว',
              ),
              _DeliveryStatTile(
                icon: Icons.warning_amber_rounded,
                color: MiddlemanColors.purple,
                label: 'รายการต้องจับตา',
                value: '1 แจ้งเตือน',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DeliveryStatTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String value;

  const _DeliveryStatTile({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
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
            padding: const EdgeInsets.all(10),
            child: Icon(icon, color: color),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingPlanList extends StatelessWidget {
  const _LoadingPlanList();

  @override
  Widget build(BuildContext context) {
    final plans = [
      const _LoadingPlanItem(
        truck: 'ทะเบียน 82-4586 ขอนแก่น',
        driver: 'คุณสมชาติ',
        destination: 'ไทยฟีด จ.ขอนแก่น',
        lots: ['A1025', 'A1023'],
        departureTime: 'รอบ 1 เวลา 10:30 น.',
      ),
      const _LoadingPlanItem(
        truck: 'ทะเบียน 88-5120 ชัยภูมิ',
        driver: 'คุณนภัส',
        destination: 'ไทยฟีด จ.ชัยภูมิ',
        lots: ['A1026'],
        departureTime: 'รอบ 2 เวลา 14:00 น.',
      ),
      const _LoadingPlanItem(
        truck: 'ทะเบียน 76-2810 ยโสธร',
        driver: 'คุณมานพ',
        destination: 'โรงงานอาหารสัตว์สหกรณ์',
        lots: ['A1024'],
        departureTime: 'รอบ 3 เวลา 17:30 น.',
      ),
    ];

    return Column(
      children: plans
          .map(
            (plan) => MiddlemanCard(child: plan),
          )
          .toList(),
    );
  }
}

class _LoadingPlanItem extends StatelessWidget {
  final String truck;
  final String driver;
  final String destination;
  final List<String> lots;
  final String departureTime;

  const _LoadingPlanItem({
    required this.truck,
    required this.driver,
    required this.destination,
    required this.lots,
    required this.departureTime,
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
                color: MiddlemanColors.green.withOpacity(0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.all(12),
              child: const Icon(Icons.local_shipping, color: MiddlemanColors.green),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    truck,
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$destination • $departureTime',
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(Icons.person, size: 16, color: Colors.black45),
            const SizedBox(width: 4),
            Text('คนขับ: $driver', style: const TextStyle(fontSize: 12)),
            const SizedBox(width: 16),
            const Icon(Icons.verified_user, size: 16, color: Colors.black45),
            const SizedBox(width: 4),
            const Text('ต้องสแกน QR เมื่อถึงโรงงาน', style: TextStyle(fontSize: 12)),
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: lots
              .map(
                (lot) => Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F9F5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Text(
                    'ล็อต $lot',
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.qr_code_scanner),
              label: const Text('สแกนย้อนกลับ'),
            ),
            const SizedBox(width: 8),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.map_outlined),
              label: const Text('ดูแผนที่'),
            ),
          ],
        ),
      ],
    );
  }
}

class _TransportTrackingCard extends StatelessWidget {
  const _TransportTrackingCard();

  @override
  Widget build(BuildContext context) {
    return MiddlemanCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'สถานะการขนส่ง',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          ),
          const SizedBox(height: 12),
          ...const [
            _TransportStatus(
              route: 'เที่ยว 1 - ไทยฟีด ขอนแก่น',
              status: 'กำลังเดินทาง (35 กม.)',
              time: 'ออกเดินทาง 10:35 น.',
              color: MiddlemanColors.green,
            ),
            _TransportStatus(
              route: 'เที่ยว 2 - ไทยฟีด ชัยภูมิ',
              status: 'กำลังโหลดสินค้า',
              time: 'เตรียมออกเดินทาง 14:00 น.',
              color: MiddlemanColors.orange,
            ),
            _TransportStatus(
              route: 'เที่ยว 3 - โรงงานสหกรณ์',
              status: 'รออนุมัติเอกสาร',
              time: 'กำหนดออก 17:30 น.',
              color: MiddlemanColors.blue,
            ),
          ],
        ],
      ),
    );
  }
}

class _TransportStatus extends StatelessWidget {
  final String route;
  final String status;
  final String time;
  final Color color;

  const _TransportStatus({
    required this.route,
    required this.status,
    required this.time,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  route,
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  status,
                  style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz),
          ),
        ],
      ),
    );
  }
}

class _DeliveryFormCard extends StatelessWidget {
  const _DeliveryFormCard();

  @override
  Widget build(BuildContext context) {
    return MiddlemanCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'รายละเอียดใบส่งสินค้า',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          ),
          const SizedBox(height: 12),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'หมายเลขใบส่งสินค้า',
              prefixIcon: Icon(Icons.confirmation_number_outlined),
            ),
            initialValue: 'DLV-240615-01',
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'เลือกโรงงานปลายทาง',
                    prefixIcon: Icon(Icons.apartment),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'ขอนแก่น', child: Text('ไทยฟีด - ขอนแก่น')),
                    DropdownMenuItem(value: 'ชัยภูมิ', child: Text('ไทยฟีด - ชัยภูมิ')),
                    DropdownMenuItem(value: 'ยโสธร', child: Text('โรงงานอาหารสัตว์สหกรณ์ - ยโสธร')),
                  ],
                  onChanged: (_) {},
                  value: 'ขอนแก่น',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'น้ำหนักรวม (ตัน)',
                    prefixIcon: Icon(Icons.scale_outlined),
                  ),
                  keyboardType: TextInputType.number,
                  initialValue: '28',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'คนขับรถ / เบอร์ติดต่อ',
              prefixIcon: Icon(Icons.person_outline),
            ),
            initialValue: 'คุณสมชาติ - 089-xxx-xxxx',
          ),
          const SizedBox(height: 12),
          TextFormField(
            minLines: 2,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'หมายเหตุ',
              hintText: 'ระบุเอกสารประกอบ เช่น ใบอนุญาตขนย้าย หรือเงื่อนไขพิเศษ',
              prefixIcon: Icon(Icons.notes_outlined),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.save_outlined),
                label: const Text('บันทึกและพิมพ์'),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.share),
                label: const Text('แชร์ให้โรงงาน'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
