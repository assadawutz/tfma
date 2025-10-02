import 'package:flutter/material.dart';

import 'middleman_flow.dart';
import 'middleman_shared_widgets.dart';

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
        MiddlemanTag(label: 'ยอดคงเหลือสุทธิ ฿1.28 ลบ.', color: MiddlemanPalette.primary),
      ],
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth >= 960
                ? 3
                : constraints.maxWidth >= 620
                    ? 2
                    : 1;
            const spacing = 12.0;
            final itemWidth =
                columns == 1 ? constraints.maxWidth : (constraints.maxWidth - spacing * (columns - 1)) / columns;
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
                icon: Icons.settings_suggest_outlined,
                color: MiddlemanPalette.warning,
                caption: 'เตรียมพร้อมสำหรับจัดส่งรอบเย็น',
              ),
              const MiddlemanSummaryCard(
                title: 'พื้นที่จัดเก็บคงเหลือ',
                value: '45 %',
                icon: Icons.inventory_2_outlined,
                color: MiddlemanPalette.info,
                caption: 'Silo #1 ใกล้เต็ม ควรย้ายเข้าคลังสำรอง',
              ),
              const MiddlemanSummaryCard(
                title: 'ส่งมอบสำเร็จ',
                value: '4 เที่ยว',
                icon: Icons.local_shipping_outlined,
                color: MiddlemanPalette.success,
                caption: 'โรงงานชัยภูมิ, ขอนแก่น, ลพบุรี',
              ),
              const MiddlemanSummaryCard(
                title: 'ยอดคงเหลือสุทธิ',
                value: '฿ 1.28 ลบ.',
                icon: Icons.account_balance_wallet_outlined,
                color: MiddlemanPalette.primary,
                caption: 'หลังหักค่าใช้จ่ายและเงินที่ต้องจ่าย',
              ),
            ];

            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
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
        for (final step in middlemanFlowSteps.where((step) => step.isCoreStep))
          MiddlemanListTile(
            leadingIcon: step.icon,
            iconColor: step.color,
            title: step.title,
            subtitle: step.description,
            trailing: TextButton(
              onPressed: () => step.openPage(context),
              child: Text(step.actionLabel),
            ),
          ),
        const MiddlemanSection(
          title: 'เมนูด่วน',
          icon: Icons.dashboard_customize_outlined,
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth >= 960
                ? 3
                : constraints.maxWidth >= 620
                    ? 2
                    : 1;
            const spacing = 12.0;
            final itemWidth =
                columns == 1 ? constraints.maxWidth : (constraints.maxWidth - spacing * (columns - 1)) / columns;
            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: [
                for (final step in middlemanFlowSteps)
                  SizedBox(
                    width: itemWidth,
                    child: MiddlemanActionButton(
                      icon: step.icon,
                      label: step.shortcutLabel ?? step.title,
                      description: step.shortcutDescription,
                      onTap: () => step.openPage(context),
                    ),
                  ),
              ],
            );
          },
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
        icon: Icons.inventory_2,
        color: MiddlemanPalette.info,
        title: 'ย้ายล็อต 230510-C เข้าคลัง',
        detail: 'Silo #2 ปรับสมดุลเหลือความจุ 68%',
      ),
      (
        icon: Icons.fireplace,
        color: MiddlemanPalette.warning,
        title: 'แจ้งเตือนการเผาแปลง',
        detail: 'พบควันในตำบลหนองสองห้อง แจ้งเจ้าหน้าที่ตรวจสอบ',
      ),
      (
        icon: Icons.payments,
        color: MiddlemanPalette.success,
        title: 'จ่ายเงินให้สหกรณ์บ้านหนองโน',
        detail: 'โอนจำนวน 185,000 บาท สำเร็จเมื่อ 14:10 น.',
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

}
