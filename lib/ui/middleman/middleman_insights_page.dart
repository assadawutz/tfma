import 'package:flutter/material.dart';

import 'middleman_factory_delivery_page.dart';
import 'middleman_finance_page.dart';
import 'middleman_moisture_page.dart';
import 'middleman_shared_widgets.dart';
import 'middleman_workflow_state.dart';

class MiddlemanInsightsPage extends StatelessWidget {
  const MiddlemanInsightsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = MiddlemanWorkflowRepository.instance;
    return AnimatedBuilder(
      animation: repository,
      builder: (context, _) {
        final insights = repository.workflowInsights;
        final highMoisture = repository.highMoistureTickets;
        final overdueDeliveries = repository.overdueDeliveries;
        final pendingExpenses = repository.pendingExpenseTransactions;
        final pendingReceivables = repository.pendingReceivableTransactions;

        return MiddlemanScreenScaffold(
          title: 'มุมมองเชิงลึก',
          subtitle: 'ตรวจจับคอขวดและโอกาสในการบริหารงานรวบรวมแบบเรียลไทม์',
          actionChips: [
            MiddlemanTag(
              label: 'อินไซท์ ${insights.length} ประเด็น',
              color: MiddlemanPalette.primary,
            ),
            if (highMoisture.isNotEmpty)
              MiddlemanTag(
                label: 'ความชื้นเกินเกณฑ์ ${highMoisture.length} ล็อต',
                color: MiddlemanPalette.warning,
              ),
            if (overdueDeliveries.isNotEmpty)
              MiddlemanTag(
                label: 'จัดส่งล่าช้า ${overdueDeliveries.length} เที่ยว',
                color: MiddlemanPalette.warning,
              ),
            if (pendingExpenses.isNotEmpty)
              MiddlemanTag(
                label: 'รอจ่าย ${pendingExpenses.length} รายการ',
                color: MiddlemanPalette.info,
              ),
            if (pendingReceivables.isNotEmpty)
              MiddlemanTag(
                label: 'รอรับเงิน ${pendingReceivables.length} รายการ',
                color: MiddlemanPalette.success,
              ),
          ],
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                final columns = constraints.maxWidth >= 1080
                    ? 3
                    : constraints.maxWidth >= 720
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
                    for (final insight in insights)
                      SizedBox(
                        width: itemWidth,
                        child: MiddlemanInsightCard(
                          icon: insight.icon,
                          color: insight.color,
                          title: insight.title,
                          value: insight.value,
                          trend: insight.trendLabel,
                          description: insight.description,
                          progress: insight.progress,
                        ),
                      ),
                  ],
                );
              },
            ),
            const MiddlemanSection(
              title: 'สัญญาณที่ต้องจับตา',
              icon: Icons.troubleshoot_outlined,
            ),
            if (highMoisture.isEmpty &&
                overdueDeliveries.isEmpty &&
                pendingExpenses.isEmpty &&
                pendingReceivables.isEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(color: Color(0x11000000), blurRadius: 10, offset: Offset(0, 4)),
                  ],
                ),
                child: const Text(
                  'ยังไม่พบประเด็นเร่งด่วน ระบบจะอัปเดตทันทีเมื่อข้อมูลเปลี่ยนแปลง',
                  style: TextStyle(color: MiddlemanPalette.textSecondary),
                ),
              )
            else ...[
              if (highMoisture.isNotEmpty) ...[
                const _InsightGroupHeader(
                  title: 'ล็อตที่ความชื้นเกิน 14%',
                  subtitle: 'จัดการอบแห้งซ้ำหรือคัดแยกก่อนเข้าสู่กระบวนการถัดไป',
                  icon: Icons.water_drop_outlined,
                ),
                for (final ticket in highMoisture.take(4))
                  MiddlemanListTile(
                    leadingIcon: Icons.qr_code_2,
                    iconColor: MiddlemanPalette.warning,
                    title: '${ticket.ticketId} • ${ticket.farmerName}',
                    subtitle:
                        'ความชื้น ${ticket.moisturePercentage?.toStringAsFixed(1) ?? '-'}% • ${ticket.village}\nปริมาณ ${ticket.weightKg.toStringAsFixed(0)} กก.',
                    trailing: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const MiddlemanMoisturePage(),
                          ),
                        );
                      },
                      child: const Text('บันทึกผล'),
                    ),
                  ),
              ],
              if (overdueDeliveries.isNotEmpty) ...[
                const _InsightGroupHeader(
                  title: 'รอบจัดส่งที่เกินกำหนด',
                  subtitle: 'ติดตามสถานะรถบรรทุกและแจ้งเวลาใหม่ให้โรงงานรับทราบ',
                  icon: Icons.local_shipping_outlined,
                ),
                for (final delivery in overdueDeliveries.take(4))
                  MiddlemanListTile(
                    leadingIcon: Icons.access_time,
                    iconColor: MiddlemanPalette.warning,
                    title: '${delivery.deliveryId} • ${delivery.factoryName}',
                    subtitle:
                        'ออกเดินทาง ${_formatDateTime(delivery.departureTime)}\nสถานะ ${_statusLabel(delivery.status)} • รถ ${delivery.truckId}',
                    trailing: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const MiddlemanFactoryDeliveryPage(),
                          ),
                        );
                      },
                      child: const Text('อัปเดตสถานะ'),
                    ),
                  ),
              ],
              if (pendingExpenses.isNotEmpty) ...[
                const _InsightGroupHeader(
                  title: 'ค่าใช้จ่ายที่รออนุมัติจ่าย',
                  subtitle: 'ตรวจสอบหลักฐานจ่ายเงินและยืนยันการโอนให้เกษตรกร',
                  icon: Icons.payments_outlined,
                ),
                for (final tx in pendingExpenses.take(4))
                  MiddlemanListTile(
                    leadingIcon: Icons.trending_down,
                    iconColor: Colors.redAccent,
                    title: '${tx.transactionId} • ${tx.counterparty}',
                    subtitle:
                        '${_formatCurrency(tx.amount)} • ${_formatDateTime(tx.timestamp)}\n${tx.description}',
                    trailing: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const MiddlemanFinancePage(),
                          ),
                        );
                      },
                      child: const Text('อัปเดตการเงิน'),
                    ),
                  ),
              ],
              if (pendingReceivables.isNotEmpty) ...[
                const _InsightGroupHeader(
                  title: 'รายรับที่ต้องติดตาม',
                  subtitle: 'ติดต่อโรงงานหรือคู่ค้าที่ค้างชำระเพื่อวางแผนสภาพคล่อง',
                  icon: Icons.request_quote_outlined,
                ),
                for (final tx in pendingReceivables.take(4))
                  MiddlemanListTile(
                    leadingIcon: Icons.trending_up,
                    iconColor: MiddlemanPalette.success,
                    title: '${tx.transactionId} • ${tx.counterparty}',
                    subtitle:
                        '${_formatCurrency(tx.amount)} • ${_formatDateTime(tx.timestamp)}\n${tx.description}',
                    trailing: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const MiddlemanFinancePage(),
                          ),
                        );
                      },
                      child: const Text('ทำเครื่องหมายรับแล้ว'),
                    ),
                  ),
              ],
            ],
            if (repository.activityFeed.isNotEmpty) ...[
              const MiddlemanSection(
                title: 'ไทม์ไลน์กิจกรรมล่าสุด',
                icon: Icons.timeline_outlined,
              ),
              for (final activity in repository.activityFeed.take(6))
                MiddlemanListTile(
                  leadingIcon: activity.icon,
                  iconColor: activity.color,
                  title: activity.title,
                  subtitle:
                      '${activity.detail}\n${_formatDateTime(activity.timestamp)}',
                ),
            ],
          ],
        );
      },
    );
  }

  String _statusLabel(DeliveryStatus status) {
    switch (status) {
      case DeliveryStatus.scheduled:
        return 'รอออกเดินทาง';
      case DeliveryStatus.enRoute:
        return 'กำลังเดินทาง';
      case DeliveryStatus.delivered:
        return 'ส่งมอบแล้ว';
    }
  }

  String _formatDateTime(DateTime time) {
    final date =
        '${time.day.toString().padLeft(2, '0')}/${time.month.toString().padLeft(2, '0')}';
    final hour = '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    return '$date • $hour น.';
  }

  String _formatCurrency(double amount) {
    if (amount >= 1000000) {
      return '฿${(amount / 1000000).toStringAsFixed(2)} ลบ.';
    }
    if (amount >= 1000) {
      return '฿${(amount / 1000).toStringAsFixed(1)} พัน';
    }
    return '฿${amount.toStringAsFixed(0)}';
  }
}

class _InsightGroupHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const _InsightGroupHeader({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 16),
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFEFF4FA),
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(8),
            child: Icon(icon, color: MiddlemanPalette.primary, size: 18),
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
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
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
    );
  }
}
