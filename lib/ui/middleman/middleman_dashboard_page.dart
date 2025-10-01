import 'package:flutter/material.dart';

import '../../component/base_scaffold.dart';

class MiddlemanDashboardPage extends StatefulWidget {
  const MiddlemanDashboardPage({super.key});

  @override
  State<MiddlemanDashboardPage> createState() => _MiddlemanDashboardPageState();
}

class _MiddlemanDashboardPageState extends State<MiddlemanDashboardPage> {
  bool showPurchases = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF4FA),
      body: BaseScaffold(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'คลังพ่อค้าคนกลาง',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildSummaryCard(),
            const SizedBox(height: 16),
            _buildQuickStats(),
            const SizedBox(height: 16),
            _buildQuickActions(),
            const SizedBox(height: 20),
            _buildToggle(),
            const SizedBox(height: 16),
            Text(
              showPurchases ? 'คำสั่งรับซื้อวันนี้' : 'การขนส่งออกจากคลัง',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const SizedBox(height: 8),
            showPurchases ? _buildPurchaseTable() : _buildLogisticsTable(),
            const SizedBox(height: 20),
            _buildAlertSection(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF4E5),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'สถานะคลังรับซื้อ',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildSummaryTile(
                  title: 'ปริมาณรับซื้อทั้งหมด',
                  value: '420 ตัน',
                  valueColor: const Color(0xFFF2662B),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSummaryTile(
                  title: 'คงเหลือในคลัง',
                  value: '180 ตัน',
                  valueColor: const Color(0xFF4DB749),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: const [
              Icon(Icons.room, size: 16, color: Color(0xFFF2662B)),
              SizedBox(width: 6),
              Expanded(
                child: Text(
                  'ศูนย์รวบรวมผลผลิตบ้านหนองบัว, อ.เมือง, จ.นครราชสีมา',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryTile({
    required String title,
    required String value,
    required Color valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: Icons.payments_outlined,
            backgroundColor: const Color(0xFFEAF7FF),
            title: 'รอจ่ายเงิน',
            value: '3 รายการ',
            subtitle: 'รวม 56 ตัน',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            icon: Icons.local_shipping_outlined,
            backgroundColor: const Color(0xFFFFEFEF),
            title: 'ขนส่งวันนี้',
            value: '2 เที่ยว',
            subtitle: 'เริ่ม 14:30 น.',
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required Color backgroundColor,
    required String title,
    required String value,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFFF2662B)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF3C95B5),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: _buildActionButton(
            icon: Icons.assignment_add,
            label: 'สร้างคำสั่งซื้อใหม่',
            description: 'บันทึกรายการรับซื้อจากเกษตรกร',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildActionButton(
            icon: Icons.route,
            label: 'จัดการเส้นทางขนส่ง',
            description: 'อัปเดตเส้นทางรถและคนขับ',
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF2662B).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFFF2662B)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggle() {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            alignment:
                showPurchases ? Alignment.centerLeft : Alignment.centerRight,
            child: FractionallySizedBox(
              widthFactor: 0.5,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF3C95B5),
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() => showPurchases = true);
                  },
                  child: Center(
                    child: Text(
                      'รายการรับซื้อ',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: showPurchases
                            ? Colors.white
                            : Colors.grey.shade600,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() => showPurchases = false);
                  },
                  child: Center(
                    child: Text(
                      'การจัดส่ง',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: !showPurchases
                            ? Colors.white
                            : Colors.grey.shade600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPurchaseTable() {
    final rows = <TableRow>[
      _buildPurchaseRow('สมชาย ฟาร์มรุ่งเรือง', '20/06/2568', '45',
          status: 'รอจ่ายเงิน', statusColor: const Color(0xFFF8A300)),
      _buildPurchaseRow('วิไลการเกษตร', '20/06/2568', '30',
          status: 'ชำระแล้ว', statusColor: const Color(0xFF4DB749)),
      _buildPurchaseRow('ชุมชนรวมใจ', '19/06/2568', '52',
          status: 'กำลังตรวจสอบ', statusColor: const Color(0xFF3C95B5)),
      _buildPurchaseRow('เกษตรกรเหนือคำ', '19/06/2568', '28',
          status: 'รอนัดส่ง', statusColor: const Color(0xFFEF5350)),
    ];

    return _buildTable(
      headers: const ['ผู้ส่งมอบ', 'วันที่รับซื้อ', 'ปริมาณ (ตัน)', 'สถานะ'],
      columnWidths: const {
        0: FlexColumnWidth(2.5),
        1: FlexColumnWidth(1.6),
        2: FlexColumnWidth(1.4),
        3: FlexColumnWidth(1.8),
      },
      rows: rows,
    );
  }

  TableRow _buildPurchaseRow(
    String farmer,
    String date,
    String volume, {
    required String status,
    required Color statusColor,
  }) {
    return TableRow(
      children: [
        _tableCell(farmer, isBold: true, alignment: Alignment.centerLeft),
        _tableCell(date, alignment: Alignment.center),
        _tableCell('$volume', alignment: Alignment.center),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Align(
            alignment: Alignment.center,
            child: _statusBadge(status, statusColor),
          ),
        ),
      ],
    );
  }

  Widget _statusBadge(String status, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildLogisticsTable() {
    final rows = <TableRow>[
      _buildLogisticsRow(
        truckId: '83-5246 นม',
        route: 'คลังหนองบัว ➝ โรงงานแปรรูปนครราชสีมา',
        status: 'ออกเดินทางแล้ว',
        statusColor: const Color(0xFF4DB749),
        schedule: '09:30 น.',
      ),
      _buildLogisticsRow(
        truckId: '70-1128 นค',
        route: 'คลังหนองบัว ➝ โรงอบข้าวโพดชัยภูมิ',
        status: 'กำลังบรรทุก',
        statusColor: const Color(0xFFF8A300),
        schedule: '14:30 น.',
      ),
      _buildLogisticsRow(
        truckId: '81-8891 นม',
        route: 'คลังหนองบัว ➝ ผู้ค้ากรุงเทพ',
        status: 'รอยืนยันคนขับ',
        statusColor: const Color(0xFFEF5350),
        schedule: 'รอยืนยัน',
      ),
    ];

    return _buildTable(
      headers: const ['ทะเบียนรถ', 'เส้นทาง', 'สถานะ', 'รอบเวลา'],
      columnWidths: const {
        0: FlexColumnWidth(1.3),
        1: FlexColumnWidth(2.5),
        2: FlexColumnWidth(1.6),
        3: FlexColumnWidth(1.2),
      },
      rows: rows,
    );
  }

  TableRow _buildLogisticsRow({
    required String truckId,
    required String route,
    required String status,
    required Color statusColor,
    required String schedule,
  }) {
    return TableRow(
      children: [
        _tableCell(truckId, isBold: true, alignment: Alignment.center),
        _tableCell(route, alignment: Alignment.centerLeft),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Align(
            alignment: Alignment.center,
            child: _statusBadge(status, statusColor),
          ),
        ),
        _tableCell(schedule, alignment: Alignment.center),
      ],
    );
  }

  Widget _buildTable({
    required List<String> headers,
    required Map<int, TableColumnWidth> columnWidths,
    required List<TableRow> rows,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
        child: Table(
          columnWidths: columnWidths,
          border: TableBorder(
            horizontalInside:
                const BorderSide(color: Color.fromRGBO(232, 232, 232, 1)),
            verticalInside:
                const BorderSide(color: Color.fromRGBO(232, 232, 232, 1)),
          ),
          children: [
            TableRow(
              decoration: const BoxDecoration(
                color: Color(0xFF3C95B5),
              ),
              children: [
                for (final header in headers) _tableHeaderCell(header),
              ],
            ),
            ...rows,
          ],
        ),
      ),
    );
  }

  Widget _tableHeaderCell(String text) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
        child: Container(
          height: 30,
          alignment: Alignment.center,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
      );

  Widget _tableCell(
    String text, {
    bool isBold = false,
    Alignment alignment = Alignment.centerLeft,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Align(
          alignment: alignment,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      );

  Widget _buildAlertSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'การแจ้งเตือนเร่งด่วน',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        const SizedBox(height: 12),
        _alertTile(
          title: 'ตรวจสอบคุณภาพข้าวโพดล็อตที่ 420 ภายใน 17:00 น.',
          icon: Icons.warning_amber_rounded,
          backgroundColor: const Color(0xFFFFF3E0),
          iconColor: const Color(0xFFF57C00),
        ),
        const SizedBox(height: 8),
        _alertTile(
          title: 'คนขับรถทะเบียน 81-8891 ยังไม่ยืนยันเส้นทาง',
          icon: Icons.directions_bus_filled_outlined,
          backgroundColor: const Color(0xFFE3F2FD),
          iconColor: const Color(0xFF1976D2),
        ),
      ],
    );
  }

  Widget _alertTile({
    required String title,
    required IconData icon,
    required Color backgroundColor,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
