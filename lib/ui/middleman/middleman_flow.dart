import 'package:flutter/material.dart';

import 'middleman_alerts_page.dart';
import 'middleman_factory_delivery_page.dart';
import 'middleman_moisture_page.dart';
import 'middleman_processing_page.dart';
import 'middleman_purchase_page.dart';
import 'middleman_shared_widgets.dart';
import 'middleman_trade_list_page.dart';

/// Describes one step in the middleman workflow so the dashboard and
/// quick-action sections can be generated from a single source of truth.
class MiddlemanFlowStep {
  const MiddlemanFlowStep({
    required this.icon,
    required this.color,
    required this.title,
    required this.description,
    required this.actionLabel,
    this.shortcutLabel,
    this.isCoreStep = true,
    required this.builder,
  });

  /// Icon that represents the action in both the task list and shortcuts.
  final IconData icon;

  /// Accent color for the icon and supporting indicators.
  final Color color;

  /// The primary title shown in the dashboard list.
  final String title;

  /// Supporting description that explains the step to the operator.
  final String description;

  /// Call-to-action used on the dashboard row button.
  final String actionLabel;

  /// Optional label used for quick actions; falls back to [title] when null.
  final String? shortcutLabel;

  /// Flag that marks whether the step is part of the main operational flow.
  final bool isCoreStep;

  /// Builder that returns the screen dedicated to this flow step.
  final WidgetBuilder builder;

  /// Pushes the flow screen onto the navigator stack.
  void openPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: builder),
    );
  }
}

/// Canonical steps that describe the complete middleman workflow.
final List<MiddlemanFlowStep> middlemanFlowSteps = [
  MiddlemanFlowStep(
    icon: Icons.qr_code_scanner,
    color: MiddlemanPalette.primary,
    title: 'รับซื้อจากเกษตรกร',
    description: 'สแกนคิวอาร์โค้ดตัดโควต้า สร้างใบรับซื้อ และเชื่อมโยงข้อมูลฟาร์ม',
    actionLabel: 'เริ่มรับซื้อ',
    shortcutLabel: 'สแกนคิวอาร์รับซื้อ',
    builder: (_) => const MiddlemanPurchasePage(),
  ),
  MiddlemanFlowStep(
    icon: Icons.water_drop,
    color: MiddlemanPalette.info,
    title: 'วัดความชื้น',
    description: 'บันทึกค่าความชื้นจากเครื่องมือและปักธงล็อตที่ต้องอบแห้งซ้ำ',
    actionLabel: 'บันทึกค่า',
    shortcutLabel: 'บันทึกความชื้น',
    builder: (_) => const MiddlemanMoisturePage(),
  ),
  MiddlemanFlowStep(
    icon: Icons.factory,
    color: MiddlemanPalette.warning,
    title: 'แปรรูปเป็นข้าวโพดเม็ด',
    description: 'ติดตามสถานะอบแห้ง คัดแยก และแพ็กกิ้งก่อนนำส่งโรงงาน',
    actionLabel: 'ตรวจงาน',
    shortcutLabel: 'ตรวจงานแปรรูป',
    builder: (_) => const MiddlemanProcessingPage(),
  ),
  MiddlemanFlowStep(
    icon: Icons.local_shipping,
    color: MiddlemanPalette.success,
    title: 'จัดส่งโรงงาน',
    description: 'วางแผนรอบรถ ตรวจสอบปลายทาง และเช็กอินด้วยคิวอาร์โค้ดโรงงาน',
    actionLabel: 'วางแผนรอบ',
    shortcutLabel: 'ติดตามการจัดส่ง',
    builder: (_) => const MiddlemanFactoryDeliveryPage(),
  ),
  MiddlemanFlowStep(
    icon: Icons.notification_important_outlined,
    color: MiddlemanPalette.warning,
    title: 'แจ้งเตือนการเผาแปลง',
    description: 'เฝ้าระวังจุดความร้อนและแจ้งเตือนเกษตรกรให้หยุดการเผา',
    actionLabel: 'เปิดแจ้งเตือน',
    shortcutLabel: 'แจ้งเตือนการเผา',
    isCoreStep: false,
    builder: (_) => const MiddlemanAlertsPage(),
  ),
  MiddlemanFlowStep(
    icon: Icons.receipt_long,
    color: MiddlemanPalette.info,
    title: 'รายการซื้อขาย',
    description: 'ทบทวนประวัติรับซื้อ-ส่งมอบ พร้อมหลักฐานย้อนกลับถึงเกษตรกร',
    actionLabel: 'ดูรายการ',
    shortcutLabel: 'ประวัติซื้อขาย',
    isCoreStep: false,
    builder: (_) => const MiddlemanTradeListPage(),
  ),
];
