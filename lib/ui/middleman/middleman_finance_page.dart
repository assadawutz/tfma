import 'package:flutter/material.dart';

import 'middleman_shared_widgets.dart';

class MiddlemanFinancePage extends StatelessWidget {
  const MiddlemanFinancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MiddlemanScreenScaffold(
      title: 'การเงินและการชำระเงิน',
      subtitle: 'สรุปยอดรับจ่าย กำหนดการโอน และเอกสารอ้างอิงให้ตรวจสอบได้ทันที',
      actionChips: const [
        MiddlemanTag(label: 'จ่ายแล้วเดือนนี้ 4.2 ลบ.', color: MiddlemanPalette.success),
        MiddlemanTag(label: 'รออนุมัติ 3 รายการ', color: MiddlemanPalette.warning),
        MiddlemanTag(label: 'ใบแจ้งหนี้โรงงาน 2 ใบ', color: MiddlemanPalette.info),
      ],
      children: [
        _buildFinancialHighlights(),
        const MiddlemanSection(
          title: 'กำหนดการจ่ายเงินให้เกษตรกร',
          icon: Icons.groups_outlined,
        ),
        _buildFarmerPayments(),
        const MiddlemanSection(
          title: 'การรับชำระจากโรงงาน',
          icon: Icons.domain_outlined,
        ),
        _buildFactoryReceivables(),
        const MiddlemanSection(
          title: 'จัดการเอกสารการเงิน',
          icon: Icons.folder_copy_outlined,
        ),
        _buildFinanceForm(),
      ],
    );
  }

  Widget _buildFinancialHighlights() {
    final metrics = [
      (
        title: 'ยอดคงเหลือสุทธิ',
        value: '฿ 1,280,000',
        caption: 'หลังหักค่าใช้จ่ายดำเนินงานล่าสุด',
        icon: Icons.account_balance_wallet_outlined,
        color: MiddlemanPalette.primary,
      ),
      (
        title: 'ยอดค้างจ่ายเกษตรกร',
        value: '฿ 320,000',
        caption: 'ครบกำหนดภายใน 3 วันทำการ',
        icon: Icons.price_check_outlined,
        color: MiddlemanPalette.warning,
      ),
      (
        title: 'ยอดค้างรับจากโรงงาน',
        value: '฿ 980,000',
        caption: 'อยู่ระหว่างรอการโอนจาก 2 โรงงาน',
        icon: Icons.receipt_long,
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

  Widget _buildFarmerPayments() {
    final payments = [
      (
        farmer: 'สหกรณ์บ้านหนองโน',
        amount: '฿ 185,000',
        due: 'ครบกำหนด 12 พ.ค.',
        status: 'รออนุมัติ',
        color: MiddlemanPalette.warning,
      ),
      (
        farmer: 'คุณสมศรี ทองดี',
        amount: '฿ 72,500',
        due: 'โอนสำเร็จ 9 พ.ค.',
        status: 'จ่ายแล้ว',
        color: MiddlemanPalette.success,
      ),
      (
        farmer: 'กลุ่มวิสาหกิจบ้านโคก',
        amount: '฿ 62,000',
        due: 'รอโอน 10 พ.ค.',
        status: 'กำลังโอน',
        color: MiddlemanPalette.info,
      ),
    ];

    return Column(
      children: [
        for (final payment in payments)
          MiddlemanListTile(
            leadingIcon: Icons.account_circle_outlined,
            iconColor: payment.color,
            title: payment.farmer,
            subtitle: '${payment.amount}\n${payment.due}',
            trailing: MiddlemanTag(label: payment.status, color: payment.color),
          ),
      ],
    );
  }

  Widget _buildFactoryReceivables() {
    final receivables = [
      (
        factory: 'โรงงานชัยภูมิ',
        amount: '฿ 420,000',
        detail: 'ใบแจ้งหนี้ INV-CHP-1105 ครบกำหนด 14 พ.ค.',
        progress: 0.6,
        color: MiddlemanPalette.info,
      ),
      (
        factory: 'โรงงานขอนแก่น',
        amount: '฿ 320,000',
        detail: 'รอการตรวจรับคุณภาพล็อต 230509-B',
        progress: 0.35,
        color: MiddlemanPalette.warning,
      ),
    ];

    return Column(
      children: [
        for (final receivable in receivables)
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
                    Container(
                      decoration: BoxDecoration(
                        color: receivable.color.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Icon(Icons.apartment_outlined, color: receivable.color),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            receivable.factory,
                            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            receivable.detail,
                            style: const TextStyle(
                              color: MiddlemanPalette.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      receivable.amount,
                      style: TextStyle(
                        color: receivable.color,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    value: receivable.progress,
                    color: receivable.color,
                    backgroundColor: receivable.color.withOpacity(0.12),
                    minHeight: 8,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'รอเอกสารรับโอน',
                      style: TextStyle(
                        color: MiddlemanPalette.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'สถานะ ${(receivable.progress * 100).round()}%',
                      style: const TextStyle(
                        color: MiddlemanPalette.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildFinanceForm() {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'สร้างบันทึกการเงิน',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 640;
              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  SizedBox(
                    width: isWide ? (constraints.maxWidth - 12) / 2 : constraints.maxWidth,
                    child: _buildTextField('ประเภท', 'โอนเงินเกษตรกร / รับเงินโรงงาน'),
                  ),
                  SizedBox(
                    width: isWide ? (constraints.maxWidth - 12) / 2 : constraints.maxWidth,
                    child: _buildTextField('วันที่ทำรายการ', 'เลือกวันที่'),
                  ),
                  SizedBox(
                    width: isWide ? (constraints.maxWidth - 12) / 2 : constraints.maxWidth,
                    child: _buildTextField('จำนวนเงิน', 'ระบุจำนวนเป็นบาท'),
                  ),
                  SizedBox(
                    width: isWide ? (constraints.maxWidth - 12) / 2 : constraints.maxWidth,
                    child: _buildTextField('ผูกกับล็อต/ใบแจ้งหนี้', 'ตัวอย่าง: LOT-230511-A'),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 12),
          _buildTextField('หมายเหตุเพิ่มเติม', 'ระบุเลขที่สัญญา/เงื่อนไขการจ่าย'),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MiddlemanPalette.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.save_outlined),
                  label: const Text('บันทึกการทำรายการ'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: MiddlemanPalette.info,
                    side: const BorderSide(color: MiddlemanPalette.info),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.picture_as_pdf_outlined),
                  label: const Text('แนบเอกสารอ้างอิง'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        ),
        const SizedBox(height: 6),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: const Color(0xFFF7F9FC),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E6EE)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: MiddlemanPalette.primary),
            ),
          ),
        ),
      ],
    );
  }
}
