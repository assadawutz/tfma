import 'package:flutter/material.dart';

import 'middleman_shared_widgets.dart';

class MiddlemanTradeListPage extends StatelessWidget {
  const MiddlemanTradeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MiddlemanScreenScaffold(
      title: 'รายการซื้อขายข้าวโพด',
      subtitle: 'ตรวจสอบประวัติรับซื้อและส่งมอบ พร้อมเชื่อมโยงถึงเกษตรกรต้นทาง',
      actionChips: const [
        MiddlemanTag(label: 'เดือนนี้ 42 รายการ', color: MiddlemanPalette.primary),
        MiddlemanTag(label: 'ยอดรวม 3.6 ล้านบาท', color: MiddlemanPalette.success),
      ],
      children: [
        const MiddlemanSection(
          title: 'ฟิลเตอร์ค้นหา',
          icon: Icons.filter_alt_outlined,
        ),
        _buildFilterBar(),
        const MiddlemanSection(
          title: 'รายการล่าสุด',
          icon: Icons.list_alt_outlined,
        ),
        ..._buildTradeCards(),
        const MiddlemanSection(
          title: 'สรุปตามโรงงานปลายทาง',
          icon: Icons.factory_outlined,
        ),
        _buildFactorySummary(),
      ],
    );
  }

  Widget _buildFilterBar() {
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
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: const [
              _FilterChip(label: 'ทั้งหมด'),
              _FilterChip(label: 'รอชำระเงิน'),
              _FilterChip(label: 'ชำระแล้ว'),
              _FilterChip(label: 'ส่งต่อโรงงาน'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'ค้นหาด้วยชื่อเกษตรกร',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: const Color(0xFFF7F9FC),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'ค้นหาด้วยโรงงานปลายทาง',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: const Color(0xFFF7F9FC),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTradeCards() {
    final trades = [
      _TradeRecord(
        ticket: 'RC-2024-068',
        farmer: 'คุณสมศรี ทองดี',
        area: 'หมู่ 2 ตำบลหนองสองห้อง',
        weight: '8,200 กก.',
        price: '69,720 บาท',
        factory: 'โรงงานชัยภูมิ',
        status: 'ส่งต่อโรงงาน',
        statusColor: MiddlemanPalette.success,
      ),
      _TradeRecord(
        ticket: 'RC-2024-069',
        farmer: 'สหกรณ์บ้านหนองโน',
        area: 'หมู่ 8 ตำบลโนนแดง',
        weight: '7,500 กก.',
        price: '63,000 บาท',
        factory: 'โรงงานขอนแก่น',
        status: 'รอรถขนส่ง',
        statusColor: MiddlemanPalette.primary,
      ),
      _TradeRecord(
        ticket: 'RC-2024-070',
        farmer: 'กลุ่มวิสาหกิจบ้านโคก',
        area: 'หมู่ 11 ตำบลคอนฉิม',
        weight: '9,100 กก.',
        price: '76,260 บาท',
        factory: 'โรงงานลพบุรี',
        status: 'รอชำระเงิน',
        statusColor: MiddlemanPalette.warning,
      ),
    ];

    return [
      for (final trade in trades)
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      trade.ticket,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                  ),
                  MiddlemanTag(label: trade.status, color: trade.statusColor),
                ],
              ),
              const SizedBox(height: 8),
              Text('เกษตรกร: ${trade.farmer}'),
              Text('พื้นที่: ${trade.area}'),
              Text('น้ำหนัก: ${trade.weight} • มูลค่า: ${trade.price}'),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.factory_outlined, size: 18, color: MiddlemanPalette.primary),
                  const SizedBox(width: 6),
                  Text(trade.factory, style: const TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
            ],
          ),
        ),
    ];
  }

  Widget _buildFactorySummary() {
    final summaries = [
      _FactorySummary('โรงงานชัยภูมิ', '12 เที่ยว', 'รวม 102 ตัน'),
      _FactorySummary('โรงงานขอนแก่น', '9 เที่ยว', 'รวม 84 ตัน'),
      _FactorySummary('โรงงานลพบุรี', '7 เที่ยว', 'รวม 64 ตัน'),
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
          for (final summary in summaries)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      summary.factory,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(summary.trips),
                  const SizedBox(width: 12),
                  Text(
                    summary.volume,
                    style: const TextStyle(fontWeight: FontWeight.w600, color: MiddlemanPalette.primary),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;

  const _FilterChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F9FC),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFE0E6EE)),
      ),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
    );
  }
}

class _TradeRecord {
  final String ticket;
  final String farmer;
  final String area;
  final String weight;
  final String price;
  final String factory;
  final String status;
  final Color statusColor;

  const _TradeRecord({
    required this.ticket,
    required this.farmer,
    required this.area,
    required this.weight,
    required this.price,
    required this.factory,
    required this.status,
    required this.statusColor,
  });
}

class _FactorySummary {
  final String factory;
  final String trips;
  final String volume;

  const _FactorySummary(this.factory, this.trips, this.volume);
}
