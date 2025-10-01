import 'package:flutter/material.dart';

import 'middleman_shared_widgets.dart';

class MiddlemanPurchasePage extends StatelessWidget {
  const MiddlemanPurchasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MiddlemanPageScaffold(
      title: 'รับซื้อจากเกษตรกร',
      subtitle: 'สแกน QR ตัดโควต้า ตรวจสอบคุณภาพ และบันทึกข้อมูล',
      badges: const [
        MiddlemanPill(
          icon: Icons.qr_code_scanner,
          label: 'พร้อมสแกน',
          color: MiddlemanColors.blue,
        ),
        MiddlemanPill(
          icon: Icons.scale,
          label: 'เครื่องชั่งออนไลน์',
          color: MiddlemanColors.green,
        ),
      ],
      children: const [
        _ScanQuotaCard(),
        MiddlemanSectionHeader(
          'คิวเกษตรกรที่รอรับซื้อ',
          icon: Icons.groups,
          color: MiddlemanColors.blue,
        ),
        _FarmerQueueList(),
        MiddlemanSectionHeader(
          'บันทึกน้ำหนักและคุณภาพ',
          icon: Icons.receipt_long,
          color: MiddlemanColors.orange,
        ),
        _ManualFormCard(),
        MiddlemanSectionHeader(
          'ประวัติรับซื้อวันนี้',
          icon: Icons.history,
          color: MiddlemanColors.purple,
        ),
        _DailyPurchaseSummary(),
      ],
    );
  }
}

class _ScanQuotaCard extends StatelessWidget {
  const _ScanQuotaCard();

  @override
  Widget build(BuildContext context) {
    return MiddlemanCard(
      gradient: const LinearGradient(
        colors: [Color(0xFFE5F5FF), Color(0xFFD5EEFF)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.qr_code_scanner, color: MiddlemanColors.blue),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'สแกน QR จากสมุดเกษตรกรเพื่อลดโควต้า',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5F5FF),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(18),
                  child: const Icon(Icons.photo_camera_outlined,
                      color: MiddlemanColors.blue, size: 28),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'แตะเพื่อเริ่มสแกน',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'ระบบจะหักโควต้าและแสดงข้อมูลเกษตรกรทันที',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                FilledButton.icon(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: MiddlemanColors.blue,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  ),
                  icon: const Icon(Icons.play_arrow_rounded),
                  label: const Text('เริ่มสแกน'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              MiddlemanPill(
                icon: Icons.assignment_turned_in_outlined,
                label: 'ตรวจบัตรเกษตรกรแล้ว',
                color: MiddlemanColors.orange,
              ),
              MiddlemanPill(
                icon: Icons.security,
                label: 'เข้ารหัสข้อมูลอัตโนมัติ',
                color: MiddlemanColors.purple,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FarmerQueueList extends StatelessWidget {
  const _FarmerQueueList();

  @override
  Widget build(BuildContext context) {
    final queue = [
      const _FarmerQueueItem(
        farmerName: 'วิไลการเกษตร',
        quota: 45,
        used: 15,
        location: 'หมู่ 3 บ้านหนองบัว',
        ticket: '#A1025',
        crops: ['ข้าวโพดหวาน', 'โครงการปลอดเผา'],
      ),
      const _FarmerQueueItem(
        farmerName: 'สมหมายไร่ข้าวโพด',
        quota: 60,
        used: 28,
        location: 'หมู่ 4 บ้านใหม่สว่าง',
        ticket: '#A1026',
        crops: ['ข้าวโพดเลี้ยงสัตว์', 'GAP 2024'],
      ),
      const _FarmerQueueItem(
        farmerName: 'ชุมชนโนนสูงรวมใจ',
        quota: 80,
        used: 52,
        location: 'หมู่ 7 บ้านโนนสูง',
        ticket: '#A1027',
        crops: ['สมาชิกสหกรณ์', 'คิวขนส่ง 16:00 น.'],
      ),
    ];

    return Column(
      children: queue
          .map(
            (item) => MiddlemanCard(
              child: item,
            ),
          )
          .toList(),
    );
  }
}

class _FarmerQueueItem extends StatelessWidget {
  final String farmerName;
  final int quota;
  final int used;
  final String location;
  final String ticket;
  final List<String> crops;

  const _FarmerQueueItem({
    required this.farmerName,
    required this.quota,
    required this.used,
    required this.location,
    required this.ticket,
    required this.crops,
  });

  @override
  Widget build(BuildContext context) {
    final quotaValue = used / quota;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    farmerName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.room, size: 14, color: Colors.black45),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          location,
                          style: const TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFE5F5FF),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Text(
                'คิว $ticket',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: MiddlemanColors.blue,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ใช้โควต้าแล้ว',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: LinearProgressIndicator(
                      value: quotaValue,
                      minHeight: 10,
                      backgroundColor: const Color(0xFFE5E5E5),
                      valueColor: const AlwaysStoppedAnimation(MiddlemanColors.blue),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$used / $quota ตัน',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'อัปเดตล่าสุด 10 นาที',
                  style: TextStyle(fontSize: 11, color: Colors.black.withOpacity(0.55)),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: crops
              .map(
                (chip) => Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F9F5),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Text(
                    chip,
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
              icon: const Icon(Icons.note_add_outlined),
              label: const Text('บันทึกน้ำหนัก'),
            ),
            const SizedBox(width: 8),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.chat_outlined),
              label: const Text('พูดคุยกับเกษตรกร'),
            ),
          ],
        ),
      ],
    );
  }
}

class _ManualFormCard extends StatelessWidget {
  const _ManualFormCard();

  @override
  Widget build(BuildContext context) {
    return MiddlemanCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'กรอกข้อมูลการรับซื้อ',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'รหัสเกษตรกรหรือคิว',
              hintText: 'เช่น #A1025 หรือหมายเลขสมาชิก',
              prefixIcon: Icon(Icons.badge_outlined),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'น้ำหนัก (กก.)',
                    prefixIcon: Icon(Icons.scale_outlined),
                  ),
                  keyboardType: TextInputType.number,
                  initialValue: '30000',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DropdownButtonFormField<String>(
                  items: const [
                    DropdownMenuItem(value: 'ความชื้น 12%', child: Text('ความชื้น 12%')),
                    DropdownMenuItem(value: 'ความชื้น 14%', child: Text('ความชื้น 14%')),
                    DropdownMenuItem(value: 'ต้องอบเพิ่ม', child: Text('ต้องอบเพิ่ม')),
                  ],
                  decoration: const InputDecoration(
                    labelText: 'สถานะความชื้น',
                    prefixIcon: Icon(Icons.water_drop),
                  ),
                  onChanged: (_) {},
                  value: 'ความชื้น 12%',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextFormField(
            minLines: 2,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'หมายเหตุเพิ่มเติม',
              hintText: 'บันทึกคุณภาพ สี หรือคำแนะนำจากเกษตรกร',
              prefixIcon: Icon(Icons.notes_outlined),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.save_outlined),
                label: const Text('บันทึกการรับซื้อ'),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.print_outlined),
                label: const Text('พิมพ์ใบชั่ง'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DailyPurchaseSummary extends StatelessWidget {
  const _DailyPurchaseSummary();

  @override
  Widget build(BuildContext context) {
    final records = [
      const _PurchaseRecord(
        time: '09:45 น.',
        farmer: 'วิไลการเกษตร',
        weight: '30,000 กก.',
        moisture: '12.5%',
        price: '8.40 บ./กก.',
      ),
      const _PurchaseRecord(
        time: '08:30 น.',
        farmer: 'สมหมายไร่ข้าวโพด',
        weight: '22,000 กก.',
        moisture: '13.1%',
        price: '8.10 บ./กก.',
      ),
      const _PurchaseRecord(
        time: '07:40 น.',
        farmer: 'ชุมชนโนนสูงรวมใจ',
        weight: '18,500 กก.',
        moisture: '15.0%',
        price: '7.85 บ./กก.',
      ),
    ];

    return MiddlemanCard(
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
                  'เกษตรกร',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'น้ำหนัก',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'ความชื้น',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                ),
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'ราคารับซื้อ',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...records.map((record) => record).toList(),
        ],
      ),
    );
  }
}

class _PurchaseRecord extends StatelessWidget {
  final String time;
  final String farmer;
  final String weight;
  final String moisture;
  final String price;

  const _PurchaseRecord({
    required this.time,
    required this.farmer,
    required this.weight,
    required this.moisture,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(time)),
          Expanded(
            flex: 3,
            child: Text(
              farmer,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(flex: 2, child: Text(weight)),
          Expanded(flex: 2, child: Text(moisture)),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(price),
            ),
          ),
        ],
      ),
    );
  }
}
