import 'package:flutter/material.dart';

import 'middleman_flow.dart';
import 'middleman_shared_widgets.dart';
import 'middleman_workflow_state.dart';

class MiddlemanDashboardPage extends StatelessWidget {
  const MiddlemanDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = MiddlemanWorkflowRepository.instance;
    return AnimatedBuilder(
      animation: repository,
      builder: (context, _) {
        final totalPurchased = repository.totalPurchasedToday;
        final moisture = repository.averageMoisture;
        final processing = repository.processingInProgressWeight;
        final storageUsage = repository.averageStorageUsage;
        final deliveries = repository.completedDeliveriesToday;
        final netBalance = repository.netBalance;
        final activities = repository.activityFeed.take(8).toList();

        return MiddlemanScreenScaffold(
          title: 'ศูนย์พ่อค้าคนกลาง',
          subtitle:
              'ตรวจสอบสถานะงานรวบรวมข้าวโพดและไปยังขั้นตอนถัดไปได้จากหน้าเดียว',
          actionChips: [
            MiddlemanTag(
              label: 'สต็อกพร้อมขาย ${_formatWeight(repository.inventoryLots.fold<double>(0, (value, lot) => value + lot.filledTons * 1000))}',
              color: MiddlemanPalette.success,
            ),
            MiddlemanTag(
              label: 'คิวรอรับซื้อ ${repository.farmerQueue.length} ราย',
              color: MiddlemanPalette.info,
            ),
            MiddlemanTag(
              label: 'การแจ้งเตือน ${repository.burnAlerts.where((alert) => !alert.acknowledged).length} รายการ',
              color: MiddlemanPalette.warning,
            ),
            MiddlemanTag(
              label: 'ยอดคงเหลือสุทธิ ฿${netBalance.toStringAsFixed(2)}',
              color: MiddlemanPalette.primary,
            ),
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
                final itemWidth = columns == 1
                    ? constraints.maxWidth
                    : (constraints.maxWidth - spacing * (columns - 1)) / columns;
                final summaries = [
                  MiddlemanSummaryCard(
                    title: 'รับซื้อวันนี้',
                    value: _formatWeight(totalPurchased),
                    icon: Icons.shopping_bag_outlined,
                    color: MiddlemanPalette.primary,
                    caption: 'จาก ${repository.purchases.length} ใบรับซื้อ',
                  ),
                  MiddlemanSummaryCard(
                    title: 'ความชื้นเฉลี่ย',
                    value: moisture != null
                        ? '${moisture.toStringAsFixed(1)} %'
                        : 'ยังไม่มีข้อมูล',
                    icon: Icons.water_drop_outlined,
                    color: MiddlemanPalette.info,
                    caption: moisture != null
                        ? 'รวม ${repository.moistureLogs.length} รายการวันนี้'
                        : 'ยังไม่ได้บันทึกค่าความชื้น',
                  ),
                  MiddlemanSummaryCard(
                    title: 'กำลังแปรรูป',
                    value: _formatWeight(processing),
                    icon: Icons.settings_suggest_outlined,
                    color: MiddlemanPalette.warning,
                    caption: '${repository.processingBatches.where((batch) => batch.stage != ProcessingStage.completed).length} ล็อตอยู่ระหว่างดำเนินการ',
                  ),
                  MiddlemanSummaryCard(
                    title: 'พื้นที่จัดเก็บคงเหลือ',
                    value: '${(100 - storageUsage).clamp(0, 100).toStringAsFixed(0)} %',
                    icon: Icons.inventory_2_outlined,
                    color: MiddlemanPalette.info,
                    caption: 'เฉลี่ยแต่ละคลังใช้ไป ${storageUsage.toStringAsFixed(0)}%',
                  ),
                  MiddlemanSummaryCard(
                    title: 'ส่งมอบสำเร็จ',
                    value: '$deliveries เที่ยว',
                    icon: Icons.local_shipping_outlined,
                    color: MiddlemanPalette.success,
                    caption: 'อัปเดตล่าสุด ${_timeLabel()} น.',
                  ),
                  MiddlemanSummaryCard(
                    title: 'ยอดคงเหลือสุทธิ',
                    value: '฿ ${netBalance.toStringAsFixed(2)}',
                    icon: Icons.account_balance_wallet_outlined,
                    color: MiddlemanPalette.primary,
                    caption:
                        'รายรับ ${_formatCurrency(repository.financeTransactions.where((tx) => !tx.isExpense).fold(0.0, (value, tx) => value + tx.amount))} / รายจ่าย ${_formatCurrency(repository.financeTransactions.where((tx) => tx.isExpense).fold(0.0, (value, tx) => value + tx.amount))}',
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
                final itemWidth = columns == 1
                    ? constraints.maxWidth
                    : (constraints.maxWidth - spacing * (columns - 1)) / columns;
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
            _buildActivityTimeline(activities),
          ],
        );
      },
    );
  }

  Widget _buildActivityTimeline(List<WorkflowActivity> activities) {
    return Column(
      children: [
        if (activities.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(color: Color(0x11000000), blurRadius: 10, offset: Offset(0, 4)),
              ],
            ),
            child: const Text(
              'ยังไม่มีความเคลื่อนไหวล่าสุด ระบบจะบันทึกกิจกรรมที่เกิดขึ้นโดยอัตโนมัติ',
              style: TextStyle(color: MiddlemanPalette.textSecondary),
            ),
          ),
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
                      const SizedBox(height: 6),
                      Text(
                        _relativeTime(activity.timestamp),
                        style: const TextStyle(
                          fontSize: 12,
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

  static String _formatWeight(double weightKg) {
    if (weightKg >= 1000) {
      return '${(weightKg / 1000).toStringAsFixed(1)} ตัน';
    }
    return '${weightKg.toStringAsFixed(0)} กก.';
  }

  static String _formatCurrency(double amount) {
    if (amount >= 1000000) {
      return '${(amount / 1000000).toStringAsFixed(2)} ลบ.';
    }
    if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(1)} พันบาท';
    }
    return '${amount.toStringAsFixed(0)} บาท';
  }

  static String _relativeTime(DateTime time) {
    final diff = DateTime.now().difference(time);
    if (diff.inMinutes < 1) return 'เมื่อสักครู่';
    if (diff.inMinutes < 60) {
      return '${diff.inMinutes} นาทีที่แล้ว';
    }
    if (diff.inHours < 24) {
      return '${diff.inHours} ชั่วโมงที่แล้ว';
    }
    return '${diff.inDays} วันที่แล้ว';
  }

  static String _timeLabel() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }
}
