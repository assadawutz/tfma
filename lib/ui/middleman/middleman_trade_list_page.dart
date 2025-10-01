import 'package:flutter/material.dart';

import 'middleman_shared_widgets.dart';

class MiddlemanTradeListPage extends StatelessWidget {
  const MiddlemanTradeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MiddlemanPageScaffold(
      title: 'รายการซื้อขายข้าวโพด',
      subtitle: 'ติดตามต้นทุน รับรู้รายได้ และตรวจสอบประวัติการซื้อขายแบบละเอียด',
      badges: const [
        MiddlemanPill(
          icon: Icons.bar_chart,
          label: 'ยอดรับซื้อเดือนนี้ 420 ตัน',
          color: MiddlemanColors.blue,
        ),
        MiddlemanPill(
          icon: Icons.payments_outlined,
          label: 'กำไรขั้นต้น 18%',
          color: MiddlemanColors.green,
        ),
      ],
      children: const [
        _TradeSummaryCard(),
        MiddlemanSectionHeader(
          'ตัวกรองข้อมูล',
          icon: Icons.filter_list,
          color: MiddlemanColors.orange,
        ),
        _FilterFormCard(),
        MiddlemanSectionHeader(
          'ประวัติการซื้อขาย',
          icon: Icons.receipt_long,
          color: MiddlemanColors.blue,
        ),
        _TradeHistoryTable(),
      ],
    );
  }
}

class _TradeSummaryCard extends StatelessWidget {
  const _TradeSummaryCard();

  @override
  Widget build(BuildContext context) {
    return MiddlemanCard(
      gradient: const LinearGradient(
        colors: [Color(0xFFF4F9F5), Color(0xFFE5F6E6)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ภาพรวมผลการซื้อขาย',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: const [
              _TradeStat(
                icon: Icons.shopping_cart_outlined,
                color: MiddlemanColors.blue,
                label: 'ยอดรับซื้อวันนี้',
                value: '72,500 กก.',
              ),
              _TradeStat(
                icon: Icons.attach_money,
                color: MiddlemanColors.green,
                label: 'ยอดขายโรงงาน',
                value: '1.85 ลบ.',
              ),
              _TradeStat(
                icon: Icons.trending_up,
                color: MiddlemanColors.orange,
                label: 'อัตรากำไรเฉลี่ย',
                value: '18%',
              ),
              _TradeStat(
                icon: Icons.receipt_long,
                color: MiddlemanColors.purple,
                label: 'จำนวนรายการ',
                value: '28 รายการ',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TradeStat extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String value;

  const _TradeStat({
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

class _FilterFormCard extends StatelessWidget {
  const _FilterFormCard();

  @override
  Widget build(BuildContext context) {
    return MiddlemanCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.search, color: MiddlemanColors.orange),
              SizedBox(width: 8),
              Text(
                'ปรับช่วงเวลาหรือประเภทธุรกรรม',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ค้นหาเกษตรกร/โรงงาน',
                    prefixIcon: Icon(Icons.manage_search),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'ประเภท',
                    prefixIcon: Icon(Icons.category_outlined),
                  ),
                  value: 'รับซื้อ',
                  onChanged: (_) {},
                  items: const [
                    DropdownMenuItem(value: 'รับซื้อ', child: Text('รับซื้อจากเกษตรกร')),
                    DropdownMenuItem(value: 'ขาย', child: Text('ขายให้โรงงาน')),
                  ],
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
                    labelText: 'วันที่เริ่มต้น',
                    prefixIcon: Icon(Icons.calendar_today_outlined),
                  ),
                  initialValue: '10 มิ.ย. 2568',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'วันที่สิ้นสุด',
                    prefixIcon: Icon(Icons.calendar_today_outlined),
                  ),
                  initialValue: '16 มิ.ย. 2568',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.refresh),
                label: const Text('ใช้ตัวกรอง'),
              ),
              const SizedBox(width: 12),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.download_outlined),
                label: const Text('ส่งออกเป็น Excel'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TradeHistoryTable extends StatelessWidget {
  const _TradeHistoryTable();

  @override
  Widget build(BuildContext context) {
    final records = const [
      _TradeRecord(
        date: '16 มิ.ย. 2568',
        type: 'ขายให้โรงงาน',
        partner: 'ไทยฟีด - ขอนแก่น',
        lot: 'A1025',
        weight: '30,000 กก.',
        price: '1,200,000 บ.',
        margin: '+12.4%',
      ),
      _TradeRecord(
        date: '16 มิ.ย. 2568',
        type: 'รับซื้อ',
        partner: 'วิไลการเกษตร',
        lot: 'A1025',
        weight: '30,000 กก.',
        price: '252,000 บ.',
        margin: '-',
      ),
      _TradeRecord(
        date: '15 มิ.ย. 2568',
        type: 'ขายให้โรงงาน',
        partner: 'ไทยฟีด - ชัยภูมิ',
        lot: 'A1024',
        weight: '22,000 กก.',
        price: '860,000 บ.',
        margin: '+10.8%',
      ),
      _TradeRecord(
        date: '15 มิ.ย. 2568',
        type: 'รับซื้อ',
        partner: 'สมหมายไร่ข้าวโพด',
        lot: 'A1024',
        weight: '22,000 กก.',
        price: '184,800 บ.',
        margin: '-',
      ),
    ];

    return MiddlemanCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('วันที่')),
                DataColumn(label: Text('ประเภท')),
                DataColumn(label: Text('คู่ค้า/เกษตรกร')),
                DataColumn(label: Text('ล็อต')),
                DataColumn(label: Text('น้ำหนัก')),
                DataColumn(label: Text('มูลค่า')),
                DataColumn(label: Text('กำไร/ส่วนต่าง')),
              ],
              rows: records
                  .map(
                    (record) => DataRow(
                      cells: [
                        DataCell(Text(record.date)),
                        DataCell(_TradeTypeChip(type: record.type)),
                        DataCell(Text(record.partner)),
                        DataCell(Text(record.lot)),
                        DataCell(Text(record.weight)),
                        DataCell(Text(record.price)),
                        DataCell(Text(
                          record.margin,
                          style: TextStyle(
                            color: record.margin.startsWith('+')
                                ? MiddlemanColors.green
                                : Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.history),
                label: const Text('ดูย้อนหลัง 30 วัน'),
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.summarize_outlined),
                label: const Text('สร้างรายงานสรุป'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TradeRecord {
  final String date;
  final String type;
  final String partner;
  final String lot;
  final String weight;
  final String price;
  final String margin;

  const _TradeRecord({
    required this.date,
    required this.type,
    required this.partner,
    required this.lot,
    required this.weight,
    required this.price,
    required this.margin,
  });
}

class _TradeTypeChip extends StatelessWidget {
  final String type;

  const _TradeTypeChip({required this.type});

  @override
  Widget build(BuildContext context) {
    final isSell = type.contains('ขาย');
    final color = isSell ? MiddlemanColors.green : MiddlemanColors.blue;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        type,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}
