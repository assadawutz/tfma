import 'package:flutter/material.dart';

import 'middleman_alerts_page.dart';
import 'middleman_factory_delivery_page.dart';
import 'middleman_moisture_page.dart';
import 'middleman_processing_page.dart';
import 'middleman_purchase_page.dart';
import 'middleman_shared_widgets.dart';
import 'middleman_trade_list_page.dart';

class MiddlemanDashboardPage extends StatelessWidget {
  const MiddlemanDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MiddlemanScreenScaffold(
      title: 'ศูนย์พ่อค้าคนกลาง',
      subtitle: 'ตรวจสอบสถานะงานรวบรวมข้าวโพดและไปยังขั้นตอนถัดไปได้จากหน้าเดียว',
      actionChips: const [
        MiddlemanTag(label: 'สต็อกพร้อมขาย 180 ตัน', color: MiddlemanPalette.success),
        MiddlemanTag(label: 'ล็อตรอตรวจ 5 รายการ', color: MiddlemanPalette.info),
        MiddlemanTag(label: 'แจ้งเตือน 2 รายการ', color: MiddlemanPalette.warning),
      ],
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final itemWidth = constraints.maxWidth > 600
                ? (constraints.maxWidth - 24) / 2
                : constraints.maxWidth;
            final summaries = [
              const MiddlemanSummaryCard(
                title: 'รับซื้อวันนี้',
                value: '36,500 กก.',
                icon: Icons.shopping_bag_outlined,
                color: MiddlemanPalette.primary,
                caption: 'มาจาก 12 ฟาร์มในระบบ',
              ),
              const MiddlemanSummaryCard(
                title: 'ความชื้นเฉลี่ย',
                value: '13.8 %',
                icon: Icons.water_drop_outlined,
                color: MiddlemanPalette.info,
                caption: 'ต้องต่ำกว่า 14% ก่อนส่งโรงงาน',
              ),
              const MiddlemanSummaryCard(
                title: 'กำลังแปรรูป',
                value: '22 ตัน',
                icon: Icons.factory_outlined,
                color: MiddlemanPalette.warning,
                caption: 'เตรียมพร้อมสำหรับจัดส่งรอบเย็น',
              ),
              const MiddlemanSummaryCard(
                title: 'ส่งมอบสำเร็จ',
                value: '4 เที่ยว',
                icon: Icons.local_shipping_outlined,
                color: MiddlemanPalette.success,
                caption: 'โรงงานชัยภูมิ, ขอนแก่น, ลพบุรี',
              ),
            ];

            return Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                for (final card in summaries)
                  SizedBox(width: itemWidth, child: card),
              ],
            );
          },
        ),
        const MiddlemanSection(
          title: 'ขั้นตอนงานวันนี้',
          icon: Icons.flag_outlined,
        ),
        MiddlemanListTile(
          leadingIcon: Icons.qr_code_scanner,
          iconColor: MiddlemanPalette.primary,
          title: 'รับซื้อจากเกษตรกร',
          subtitle: 'สแกนคิวอาร์โค้ดเพื่อตัดโควต้าและสร้างใบรับซื้อ',
          trailing: TextButton(
            onPressed: () => _open(context, const MiddlemanPurchasePage()),
            child: const Text('เริ่มรับซื้อ'),
          ),
        ),
        MiddlemanListTile(
          leadingIcon: Icons.water_drop,
          iconColor: MiddlemanPalette.info,
          title: 'วัดความชื้น',
          subtitle: 'ตรวจสอบความชื้นแปลงล่าสุดก่อนนำไปแปรรูป',
          trailing: TextButton(
            onPressed: () => _open(context, const MiddlemanMoisturePage()),
            child: const Text('บันทึกค่า'),
          ),
        ),
        MiddlemanListTile(
          leadingIcon: Icons.factory,
          iconColor: MiddlemanPalette.warning,
          title: 'แปรรูปเป็นข้าวโพดเม็ด',
          subtitle: 'ติดตามสถานะอบแห้ง คัดแยก และแพ็กกิ้ง',
          trailing: TextButton(
            onPressed: () => _open(context, const MiddlemanProcessingPage()),
            child: const Text('เปิดดูงาน'),
          ),
        ),
        MiddlemanListTile(
          leadingIcon: Icons.local_shipping,
          iconColor: MiddlemanPalette.success,
          title: 'จัดส่งโรงงาน',
          subtitle: 'ตรวจสอบปลายทางและสแกนคิวอาร์โค้ดของโรงงานปลายทาง',
          trailing: TextButton(
            onPressed: () => _open(context, const MiddlemanFactoryDeliveryPage()),
            child: const Text('วางแผนรอบ'),
          ),
        ),
        const MiddlemanSection(
          title: 'เมนูด่วน',
          icon: Icons.dashboard_customize_outlined,
        ),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            MiddlemanActionButton(
              icon: Icons.qr_code_scanner,
              label: 'สแกนคิวอาร์รับซื้อ',
              onTap: () => _open(context, const MiddlemanPurchasePage()),
            ),
            MiddlemanActionButton(
              icon: Icons.assignment_outlined,
              label: 'บันทึกความชื้น',
              onTap: () => _open(context, const MiddlemanMoisturePage()),
            ),
            MiddlemanActionButton(
              icon: Icons.factory_outlined,
              label: 'ตรวจงานแปรรูป',
              onTap: () => _open(context, const MiddlemanProcessingPage()),
            ),
            MiddlemanActionButton(
              icon: Icons.receipt_long,
              label: 'ประวัติซื้อขาย',
              onTap: () => _open(context, const MiddlemanTradeListPage()),
            ),
            MiddlemanActionButton(
              icon: Icons.notification_important_outlined,
              label: 'แจ้งเตือนการเผา',
              onTap: () => _open(context, const MiddlemanAlertsPage()),
            ),
          ],
        ),
        const MiddlemanSection(
          title: 'ความเคลื่อนไหวล่าสุด',
          icon: Icons.schedule_outlined,
          trailing: Text('อัปเดตอัตโนมัติทุก 10 นาที',
              style: TextStyle(color: MiddlemanPalette.textSecondary, fontSize: 12)),
        ),
        _buildActivityTimeline(),
      ],
    );
  }

  Widget _buildActivityTimeline() {
    final activities = [
      (
        icon: Icons.check_circle,
        color: MiddlemanPalette.success,
        title: 'จัดส่งเที่ยวที่ 4 สำเร็จ',
        detail: 'รถบรรทุกทะเบียน 82-4495 ถึงโรงงานชัยภูมิ เวลา 15:20 น.',
      ),
      (
        icon: Icons.water_drop,
        color: MiddlemanPalette.info,
        title: 'บันทึกความชื้นแปลง 7',
        detail: 'ความชื้น 13.5% โดยเครื่องวัด Silo #2',
      ),
      (
        icon: Icons.fireplace,
        color: MiddlemanPalette.warning,
        title: 'แจ้งเตือนการเผาแปลง',
        detail: 'พบควันในตำบลหนองสองห้อง แจ้งเจ้าหน้าที่ตรวจสอบ',
      ),
    ];

    return Column(
      children: [
        for (final activity in activities)
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: activity.color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Icon(activity.icon, color: activity.color),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activity.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        activity.detail,
                        style: const TextStyle(
                          fontSize: 13,
                          color: MiddlemanPalette.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  static void _open(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => page),
    );
  }
}
