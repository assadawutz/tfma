import 'package:flutter/material.dart';

import 'middleman_shared_widgets.dart';

class MiddlemanPurchasePage extends StatelessWidget {
  const MiddlemanPurchasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MiddlemanScreenScaffold(
      title: 'รับซื้อจากเกษตรกร',
      subtitle: 'สแกนคิวอาร์โค้ดตัดโควต้า ตรวจสอบปริมาณ และออกเอกสารรับซื้อ',
      actionChips: const [
        MiddlemanTag(label: 'คิวรอ 3 ราย', color: MiddlemanPalette.primary),
        MiddlemanTag(label: 'สต็อกใหม่วันนี้ 12 ตัน', color: MiddlemanPalette.success),
      ],
      children: [
        _buildScannerCard(),
        const MiddlemanSection(
          title: 'คิวเกษตรกรที่รอรับซื้อ',
          icon: Icons.people_alt_outlined,
        ),
        ..._buildFarmerQueue(),
        const MiddlemanSection(
          title: 'ตรวจสอบโควต้าและราคาประจำวัน',
          icon: Icons.receipt_long_outlined,
        ),
        _buildQuotaTable(),
      ],
    );
  }

  Widget _buildScannerCard() {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: MiddlemanPalette.primary.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(12),
                child: const Icon(Icons.qr_code_scanner, color: MiddlemanPalette.primary, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'สแกนคิวอาร์โค้ดเกษตรกร',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'ใช้กล้องเพื่ออ่านคิวอาร์โค้ดจากแอปเกษตรกรแล้วตัดโควต้าอัตโนมัติ หากสแกนไม่ได้สามารถกรอกรหัสได้ที่แบบฟอร์มด้านล่าง',
                      style: TextStyle(fontSize: 13, color: MiddlemanPalette.textSecondary),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F9FC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE0E6EE)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.camera_alt_outlined, color: MiddlemanPalette.primary),
                    SizedBox(width: 8),
                    Text(
                      'แตะเพื่อเริ่มสแกน',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'หลังสแกนระบบจะดึงข้อมูลฟาร์ม น้ำหนักที่เหลือในโควต้า และแนะนำราคารับซื้อให้ทันที',
                  style: TextStyle(fontSize: 13, color: MiddlemanPalette.textSecondary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'กรอกรหัสโควต้าแทนการสแกน',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              hintText: 'ตัวอย่าง: 57-000341-01',
              filled: true,
              fillColor: const Color(0xFFF7F9FC),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFE0E6EE)),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: MiddlemanPalette.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {},
              icon: const Icon(Icons.check_circle_outline),
              label: const Text('ตรวจสอบและสร้างใบรับซื้อ'),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFarmerQueue() {
    final farmers = [
      _FarmerQueue(
        name: 'สหกรณ์บ้านหนองโน',
        quota: 'คงเหลือ 6,500 กก.',
        village: 'หมู่ 8 ตำบลโนนแดง',
        color: MiddlemanPalette.success,
      ),
      _FarmerQueue(
        name: 'คุณสมศรี ทองดี',
        quota: 'คงเหลือ 3,200 กก.',
        village: 'หมู่ 2 ตำบลหนองสองห้อง',
        color: MiddlemanPalette.info,
      ),
      _FarmerQueue(
        name: 'กลุ่มวิสาหกิจบ้านโคก',
        quota: 'คงเหลือ 8,900 กก.',
        village: 'หมู่ 11 ตำบลคอนฉิม',
        color: MiddlemanPalette.warning,
      ),
    ];

    return [
      for (final farmer in farmers)
        MiddlemanListTile(
          leadingIcon: Icons.person_outline,
          iconColor: farmer.color,
          title: farmer.name,
          subtitle: '${farmer.quota}\n${farmer.village}',
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              MiddlemanTag(label: 'รอชั่งน้ำหนัก', color: MiddlemanPalette.primary),
              SizedBox(height: 8),
              Text('คิวถัดไป', style: TextStyle(fontSize: 12, color: MiddlemanPalette.textSecondary)),
            ],
          ),
        ),
    ];
  }

  Widget _buildQuotaTable() {
    final quotas = [
      _QuotaSummary('โควต้าประจำวัน', '60,000 กก.', 'ใช้ไปแล้ว 48,300 กก.'),
      _QuotaSummary('ราคารับซื้อเกรด A', '8.40 บาท/กก.', 'ความชื้นไม่เกิน 14%'),
      _QuotaSummary('ราคารับซื้อเกรด B', '7.10 บาท/กก.', 'ความชื้น 14-17%'),
      _QuotaSummary('กำลังคนประจำด่าน', '5 คน', 'พร้อมให้บริการทุกจุดชั่ง'),
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
          for (final item in quotas)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      item.title,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(
                    item.value,
                    style: const TextStyle(fontWeight: FontWeight.w700, color: MiddlemanPalette.primary),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    item.detail,
                    style: const TextStyle(fontSize: 12, color: MiddlemanPalette.textSecondary),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _FarmerQueue {
  final String name;
  final String quota;
  final String village;
  final Color color;

  const _FarmerQueue({
    required this.name,
    required this.quota,
    required this.village,
    required this.color,
  });
}

class _QuotaSummary {
  final String title;
  final String value;
  final String detail;

  const _QuotaSummary(this.title, this.value, this.detail);
}
