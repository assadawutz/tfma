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
    return MiddlemanPageScaffold(
      title: 'คลังพ่อค้าคนกลาง',
      subtitle: 'ดูสถานะงาน ควบคุมคุณภาพ และส่งต่อโรงงานแบบครบวงจร',
      badges: const [
        MiddlemanPill(
          icon: Icons.inventory_2_rounded,
          label: 'สต็อกพร้อมขาย 180 ตัน',
          color: MiddlemanColors.green,
        ),
        MiddlemanPill(
          icon: Icons.qr_code_scanner,
          label: 'คิวรอสแกน 3 ราย',
          color: MiddlemanColors.blue,
        ),
        MiddlemanPill(
          icon: Icons.warning_amber_rounded,
          label: 'แจ้งเตือน 2 รายการ',
          color: MiddlemanColors.purple,
        ),
      ],
      trailing: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            children: const [
              Icon(Icons.cloud_sync_outlined, size: 16, color: Colors.white),
              SizedBox(width: 6),
              Text(
                'ซิงก์ล่าสุด 5 นาที',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
      children: [
        MiddlemanCard(
          gradient: const LinearGradient(
            colors: [Color(0xFFFEE6DA), Color(0xFFFBD3BC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          child: const _SummaryHighlights(),
        ),
        const MiddlemanSectionHeader(
          'งานสำคัญวันนี้',
          icon: Icons.event_available,
          color: MiddlemanColors.blue,
        ),
        const _TodayTaskList(),
        MiddlemanSectionHeader(
          'เมนูจัดการสำหรับพ่อค้าคนกลาง',
          icon: Icons.dashboard_customize,
          trailing: TextButton(
            onPressed: () {},
            child: const Text('จัดเรียง'),
          ),
        ),
        const _ActionGrid(),
        MiddlemanSectionHeader(
          'กิจกรรมล่าสุด',
          icon: Icons.timeline,
          color: MiddlemanColors.purple,
          trailing: TextButton(
            onPressed: () {},
            child: const Text('ดูทั้งหมด'),
          ),
        ),
        MiddlemanCard(
          child: const _ActivityTimeline(),
        ),
      ],
    );
  }
}

class _SummaryHighlights extends StatelessWidget {
  const _SummaryHighlights();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ภาพรวมสต็อกและการเคลื่อนไหว',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final tileWidth = (constraints.maxWidth - 24) / 2;
            final tiles = const [
              _SummaryTile(
                title: 'รับซื้อสะสมเดือนนี้',
                value: '420 ตัน',
                icon: Icons.shopping_bag,
                color: MiddlemanColors.orange,
                caption: 'เพิ่มขึ้น 12% จากเดือนก่อน',
              ),
              _SummaryTile(
                title: 'ล็อตรอตรวจความชื้น',
                value: '12 ล็อต',
                icon: Icons.science_outlined,
                color: MiddlemanColors.blue,
                caption: 'ต้องวัดภายใน 6 ชั่วโมง',
              ),
              _SummaryTile(
                title: 'กำลังแปรรูป',
                value: '36 ตัน',
                icon: Icons.factory_outlined,
                color: MiddlemanColors.purple,
                caption: 'พร้อมแพ็กภายในวันนี้',
              ),
              _SummaryTile(
                title: 'รอส่งโรงงาน',
                value: '3 เที่ยว',
                icon: Icons.local_shipping_outlined,
                color: MiddlemanColors.green,
                caption: 'โรงงานปลายทาง: ขอนแก่น, ชัยภูมิ',
              ),
            ];

            return Wrap(
              spacing: 12,
              runSpacing: 12,
              children: tiles
                  .map((tile) => SizedBox(width: tileWidth, child: tile))
                  .toList(),
            );
          },
        ),
        const SizedBox(height: 16),
        const MiddlemanDividerLabel('ข้อมูลสต็อก'),
        const SizedBox(height: 12),
        Row(
          children: const [
            Icon(Icons.room, size: 18, color: MiddlemanColors.orange),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'ศูนย์รวบรวมผลผลิตบ้านหนองบัว อ.เมือง จ.นครราชสีมา',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SummaryTile extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String caption;

  const _SummaryTile({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.caption,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 22,
              color: color,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            caption,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

class _TodayTaskList extends StatelessWidget {
  const _TodayTaskList();

  @override
  Widget build(BuildContext context) {
    final tasks = [
      _TaskModel(
        title: 'ตรวจสอบโควต้าและสแกนคิวเกษตรกร',
        time: '08:30 - 09:30 น.',
        description: 'เกษตรกร 3 รายรอการรับซื้อ ตรวจสอบเอกสารและลดโควต้า',
        icon: Icons.qr_code_2_outlined,
        color: MiddlemanColors.blue,
        navigate: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const MiddlemanPurchasePage()),
        ),
      ),
      _TaskModel(
        title: 'วัดความชื้นล็อตที่เพิ่งรับมา',
        time: '10:00 - 11:00 น.',
        description: 'ล็อต A1025, A1026 ต้องวัดและบันทึกค่าความชื้น',
        icon: Icons.water_drop_outlined,
        color: MiddlemanColors.purple,
        navigate: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const MiddlemanMoisturePage()),
        ),
      ),
      _TaskModel(
        title: 'ควบคุมการแปรรูปและแพ็กกิ้ง',
        time: '13:00 - 15:00 น.',
        description: 'ตรวจเช็กเครื่องอบ ขนาดเมล็ด และการบรรจุ',
        icon: Icons.factory,
        color: MiddlemanColors.orange,
        navigate: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const MiddlemanProcessingPage()),
        ),
      ),
      _TaskModel(
        title: 'เตรียมส่งมอบให้โรงงานปลายทาง',
        time: '16:30 น.',
        description: 'ยืนยันคิวขนส่งและสแกนย้อนกลับถึงเกษตรกร',
        icon: Icons.local_shipping,
        color: MiddlemanColors.green,
        navigate: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const MiddlemanFactoryDeliveryPage()),
        ),
      ),
    ];

    return Column(
      children: tasks
          .map(
            (task) => GestureDetector(
              onTap: task.navigate,
              child: MiddlemanCard(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: task.color.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.all(14),
                      child: Icon(task.icon, color: task.color),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            task.description,
                            style: const TextStyle(fontSize: 12, color: Colors.black54),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.schedule, size: 14, color: task.color),
                              const SizedBox(width: 4),
                              Text(
                                task.time,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                'แตะเพื่อดูรายละเอียด',
                                style: TextStyle(fontSize: 12, color: task.color),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _TaskModel {
  final String title;
  final String time;
  final String description;
  final IconData icon;
  final Color color;
  final VoidCallback navigate;

  _TaskModel({
    required this.title,
    required this.time,
    required this.description,
    required this.icon,
    required this.color,
    required this.navigate,
  });
}

class _ActionGrid extends StatelessWidget {
  const _ActionGrid();

  @override
  Widget build(BuildContext context) {
    final actions = [
      _ActionModel(
        title: 'รับซื้อผลผลิต',
        subtitle: 'สแกน QR และบันทึกการชั่ง',
        icon: Icons.qr_code_scanner,
        color: MiddlemanColors.blue,
        navigate: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const MiddlemanPurchasePage()),
        ),
      ),
      _ActionModel(
        title: 'วัดความชื้น',
        subtitle: 'บันทึกผลและเกณฑ์มาตรฐาน',
        icon: Icons.water_drop,
        color: MiddlemanColors.purple,
        navigate: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const MiddlemanMoisturePage()),
        ),
      ),
      _ActionModel(
        title: 'ควบคุมการแปรรูป',
        subtitle: 'ติดตามสถานะเครื่องจักร',
        icon: Icons.precision_manufacturing,
        color: MiddlemanColors.orange,
        navigate: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const MiddlemanProcessingPage()),
        ),
      ),
      _ActionModel(
        title: 'ส่งต่อโรงงาน',
        subtitle: 'สร้างใบส่งสินค้าและติดตามขนส่ง',
        icon: Icons.local_shipping_outlined,
        color: MiddlemanColors.green,
        navigate: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const MiddlemanFactoryDeliveryPage()),
        ),
      ),
      _ActionModel(
        title: 'แจ้งเตือนการเผา',
        subtitle: 'ดูการแจ้งเตือนและให้คำแนะนำ',
        icon: Icons.emergency_outlined,
        color: MiddlemanColors.purple,
        navigate: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const MiddlemanAlertsPage()),
        ),
      ),
      _ActionModel(
        title: 'ประวัติซื้อขาย',
        subtitle: 'สรุปต้นทุนและรายได้รายวัน',
        icon: Icons.receipt_long,
        color: MiddlemanColors.blue,
        navigate: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const MiddlemanTradeListPage()),
        ),
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = (constraints.maxWidth - 24) / 2;
        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: actions
              .map(
                (action) => SizedBox(
                  width: width,
                  child: GestureDetector(
                    onTap: action.navigate,
                    child: MiddlemanCard(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: action.color.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            padding: const EdgeInsets.all(14),
                            child: Icon(action.icon, color: action.color),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            action.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            action.subtitle,
                            style: const TextStyle(fontSize: 12, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _ActionModel {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback navigate;

  _ActionModel({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.navigate,
  });
}

class _ActivityTimeline extends StatelessWidget {
  const _ActivityTimeline();

  @override
  Widget build(BuildContext context) {
    final activities = [
      _ActivityModel(
        time: '09:45 น.',
        title: 'รับซื้อจาก วิไลการเกษตร',
        detail: 'สแกน QR #A1025 และบันทึกน้ำหนัก 30,000 กก.',
        color: MiddlemanColors.blue,
      ),
      _ActivityModel(
        time: '08:30 น.',
        title: 'วัดความชื้นล็อต A1024',
        detail: 'ค่าความชื้นเฉลี่ย 12.5% ผ่านเกณฑ์',
        color: MiddlemanColors.purple,
      ),
      _ActivityModel(
        time: '07:40 น.',
        title: 'ส่งมอบให้โรงงานชัยภูมิ',
        detail: 'ยืนยันการรับสินค้าและลงลายมือชื่อเรียบร้อย',
        color: MiddlemanColors.green,
      ),
    ];

    return Column(
      children: activities
          .map(
            (activity) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: activity.color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      if (activities.last != activity)
                        Container(
                          width: 2,
                          height: 48,
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          color: activity.color.withOpacity(0.3),
                        ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          activity.time,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          activity.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          activity.detail,
                          style: const TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class _ActivityModel {
  final String time;
  final String title;
  final String detail;
  final Color color;

  _ActivityModel({
    required this.time,
    required this.title,
    required this.detail,
    required this.color,
  });
}
