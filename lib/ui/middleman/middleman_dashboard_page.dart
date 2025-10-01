import 'package:flutter/material.dart';

import '../../component/base_scaffold.dart';
import 'middleman_alerts_page.dart';
import 'middleman_factory_delivery_page.dart';
import 'middleman_moisture_page.dart';
import 'middleman_processing_page.dart';
import 'middleman_purchase_page.dart';
import 'middleman_trade_list_page.dart';

class MiddlemanDashboardPage extends StatelessWidget {
  const MiddlemanDashboardPage({super.key});

  static const _sectionTitleStyle = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 16,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF4FA),
      body: BaseScaffold(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 16),
            _buildSummaryRow(),
            const SizedBox(height: 24),
            const Text('งานสำคัญวันนี้', style: _sectionTitleStyle),
            const SizedBox(height: 12),
            _buildTodayStatusCards(),
            const SizedBox(height: 24),
            const Text('เมนูจัดการสำหรับพ่อค้าคนกลาง', style: _sectionTitleStyle),
            const SizedBox(height: 12),
            _buildActionGrid(context),
            const SizedBox(height: 24),
            const Text('กิจกรรมล่าสุด', style: _sectionTitleStyle),
            const SizedBox(height: 12),
            _buildActivityTimeline(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(6),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 18,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'คลังพ่อค้าคนกลาง',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'ดูภาพรวม ปรับแผน และเข้าถึงงานแต่ละขั้นตอน',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSummaryRow() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'สรุปสถานะคลังรับซื้อวันนี้',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildSummaryTile(
                  title: 'รับซื้อสะสมเดือนนี้',
                  value: '420 ตัน',
                  color: const Color(0xFFF2662B),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSummaryTile(
                  title: 'สต็อกพร้อมขาย',
                  value: '180 ตัน',
                  color: const Color(0xFF4DB749),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSummaryTile(
                  title: 'ล็อตรอตรวจความชื้น',
                  value: '12 ล็อต',
                  color: const Color(0xFF3C95B5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
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
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF7FBFF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodayStatusCards() {
    return Row(
      children: [
        Expanded(
          child: _statusCard(
            title: 'คิวรอรับซื้อ',
            value: '18 ราย',
            subtitle: 'พร้อมสแกน QR เพื่อหักโควต้า',
            color: const Color(0xFFFFF4E5),
            icon: Icons.qr_code_scanner,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _statusCard(
            title: 'วัดความชื้น',
            value: '9 ล็อต',
            subtitle: 'กำลังรอการอนุมัติคุณภาพ',
            color: const Color(0xFFE5F5FF),
            icon: Icons.water_drop,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _statusCard(
            title: 'ขนส่งสู่โรงงาน',
            value: '3 เที่ยว',
            subtitle: 'แจ้งเตือนเตรียมเอกสารแหล่งที่มา',
            color: const Color(0xFFE8F8ED),
            icon: Icons.local_shipping,
          ),
        ),
      ],
    );
  }

  Widget _statusCard({
    required String title,
    required String value,
    required String subtitle,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.black54),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildActionGrid(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _actionCard(
          context,
          title: 'รับซื้อจากเกษตรกร',
          subtitle: 'สแกน QR ตัดโควต้าและบันทึกการรับซื้อ',
          icon: Icons.qr_code_2,
          color: const Color(0xFF3C95B5),
          destination: const MiddlemanPurchasePage(),
        ),
        _actionCard(
          context,
          title: 'วัดความชื้น',
          subtitle: 'เก็บผลวัด ตรวจสอบคุณภาพแต่ละล็อต',
          icon: Icons.water_drop,
          color: const Color(0xFF4DB749),
          destination: const MiddlemanMoisturePage(),
        ),
        _actionCard(
          context,
          title: 'แปรรูปเป็นข้าวโพดเม็ด',
          subtitle: 'ติดตามการอบ แยกคุณภาพ และจัดเก็บ',
          icon: Icons.factory,
          color: const Color(0xFFF9A825),
          destination: const MiddlemanProcessingPage(),
        ),
        _actionCard(
          context,
          title: 'ขายต่อโรงงาน',
          subtitle: 'สแกน QR ตรวจสอบย้อนกลับถึงเกษตรกร',
          icon: Icons.assignment_turned_in,
          color: const Color(0xFF6D4C41),
          destination: const MiddlemanFactoryDeliveryPage(),
        ),
        _actionCard(
          context,
          title: 'แจ้งเตือนการเผาแปลง',
          subtitle: 'ติดตามพื้นที่เสี่ยงและติดต่อเกษตรกร',
          icon: Icons.warning_amber_rounded,
          color: const Color(0xFFD84315),
          destination: const MiddlemanAlertsPage(),
        ),
        _actionCard(
          context,
          title: 'รายการซื้อขายข้าวโพด',
          subtitle: 'ดูรายการรับซื้อ-ขายส่งย้อนหลัง',
          icon: Icons.receipt_long,
          color: const Color(0xFF283593),
          destination: const MiddlemanTradeListPage(),
        ),
      ],
    );
  }

  Widget _actionCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Widget destination,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => destination),
        );
      },
      child: Container(
        width: 164,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.25), width: 1.5),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityTimeline() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          _activityTile(
            time: '09:45',
            title: 'สแกนรับซื้อจากวิไลการเกษตร',
            description: 'ลดโควต้า 30 ตัน - ล็อต #MM240620A',
            color: const Color(0xFF3C95B5),
          ),
          const Divider(height: 24),
          _activityTile(
            time: '08:20',
            title: 'ผลความชื้นล็อต #QC1245',
            description: 'ค่าเฉลี่ย 12.5% ผ่านเกณฑ์ พร้อมเข้าสู่การอบ',
            color: const Color(0xFF4DB749),
          ),
          const Divider(height: 24),
          _activityTile(
            time: '07:30',
            title: 'แจ้งเตือนเผาแปลงจากหมู่ 7',
            description: 'ประสาน อบต. และเจ้าหน้าที่สิ่งแวดล้อมแล้ว',
            color: const Color(0xFFD84315),
          ),
        ],
      ),
    );
  }

  Widget _activityTile({
    required String time,
    required String title,
    required String description,
    required Color color,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 54,
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Text(
            time,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          width: 6,
          height: 6,
          margin: const EdgeInsets.only(top: 6),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
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
                description,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
