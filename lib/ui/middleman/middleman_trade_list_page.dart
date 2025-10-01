import 'package:flutter/material.dart';

import '../../component/base_scaffold.dart';

class MiddlemanTradeListPage extends StatelessWidget {
  const MiddlemanTradeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF4FA),
      body: BaseScaffold(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _PageHeader(),
            SizedBox(height: 20),
            _FilterSummaryCard(),
            SizedBox(height: 24),
            _SectionTitle('สรุปรายการรับซื้อ'),
            SizedBox(height: 12),
            _PurchaseTable(),
            SizedBox(height: 24),
            _SectionTitle('สรุปรายการขายออก'),
            SizedBox(height: 12),
            _SaleTable(),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _PageHeader extends StatelessWidget {
  const _PageHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 18,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'รายการซื้อขายข้าวโพด',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'สรุปการรับซื้อจากเกษตรกรและการขายต่อโรงงานย้อนหลัง',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;

  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16,
      ),
    );
  }
}

class _FilterSummaryCard extends StatelessWidget {
  const _FilterSummaryCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFE5F5FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.filter_list, color: Color(0xFF283593)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'สรุปช่วงเวลา 1-30 มิ.ย. 2568',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'รับซื้อ 48 รายการ รวม 612,000 กก. • ขายออก 22 รายการ รวม 588,000 กก.',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF283593),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Text(
              'ปรับช่วงเวลา',
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

class _PurchaseTable extends StatelessWidget {
  final List<Map<String, String>> purchases = const [
    {
      'date': '20 มิ.ย. 2568',
      'farmer': 'วิไลการเกษตร',
      'weight': '30,000 กก.',
      'price': '6.80 บาท/กก.',
      'status': 'ส่งต่อ QC',
    },
    {
      'date': '19 มิ.ย. 2568',
      'farmer': 'สมหมายไร่ข้าวโพด',
      'weight': '22,000 กก.',
      'price': '6.75 บาท/กก.',
      'status': 'รอแปรรูป',
    },
    {
      'date': '19 มิ.ย. 2568',
      'farmer': 'ชุมชนโนนสูงรวมใจ',
      'weight': '18,500 กก.',
      'price': '6.60 บาท/กก.',
      'status': 'พร้อมขาย',
    },
  ];

  const _PurchaseTable();

  Color _statusColor(String status) {
    switch (status) {
      case 'ส่งต่อ QC':
        return const Color(0xFF3C95B5);
      case 'รอแปรรูป':
        return const Color(0xFFF9A825);
      case 'พร้อมขาย':
        return const Color(0xFF4DB749);
      default:
        return Colors.black54;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: const [
              Expanded(
                flex: 2,
                child: Text(
                  'วันที่',
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
                  'ราคา',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'สถานะ',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...purchases.map(
            (purchase) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(purchase['date']!),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      purchase['farmer']!,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(purchase['weight']!),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(purchase['price']!),
                  ),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color:
                              _statusColor(purchase['status']!).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          purchase['status']!,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _statusColor(purchase['status']!),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SaleTable extends StatelessWidget {
  final List<Map<String, String>> sales = const [
    {
      'date': '20 มิ.ย. 2568',
      'factory': 'โรงงาน ABC Agro',
      'weight': '24,500 กก.',
      'price': '8.10 บาท/กก.',
      'batch': '#MM240620A',
    },
    {
      'date': '19 มิ.ย. 2568',
      'factory': 'โรงงาน ThaiFeed',
      'weight': '20,000 กก.',
      'price': '8.05 บาท/กก.',
      'batch': '#MM240619C',
    },
    {
      'date': '18 มิ.ย. 2568',
      'factory': 'โรงงาน CPF Korat',
      'weight': '18,000 กก.',
      'price': '8.00 บาท/กก.',
      'batch': '#MM240619B',
    },
  ];

  const _SaleTable();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: const [
              Expanded(
                flex: 2,
                child: Text(
                  'วันที่',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'โรงงาน',
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
                  'ราคา',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'ล็อตสินค้า',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...sales.map(
            (sale) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(sale['date']!),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      sale['factory']!,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(sale['weight']!),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(sale['price']!),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      sale['batch']!,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
