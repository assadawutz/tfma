import 'package:flutter/material.dart';

import 'middleman_shared_widgets.dart';
import 'middleman_workflow_state.dart';

class MiddlemanTradeListPage extends StatefulWidget {
  const MiddlemanTradeListPage({super.key});

  @override
  State<MiddlemanTradeListPage> createState() => _MiddlemanTradeListPageState();
}

class _MiddlemanTradeListPageState extends State<MiddlemanTradeListPage> {
  TradeType? _filter = TradeType.purchase;

  MiddlemanWorkflowRepository get _repository =>
      MiddlemanWorkflowRepository.instance;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _repository,
      builder: (context, _) {
        final trades = _repository.tradeRecords
            .where((trade) => _filter == null || trade.type == _filter)
            .toList();
        final totalPurchase = _repository.tradeRecords
            .where((trade) => trade.type == TradeType.purchase)
            .fold<double>(0, (value, trade) => value + trade.amount);
        final totalSale = _repository.tradeRecords
            .where((trade) => trade.type == TradeType.sale)
            .fold<double>(0, (value, trade) => value + trade.amount);

        return MiddlemanScreenScaffold(
          title: 'รายการซื้อขายข้าวโพด',
          subtitle: 'ทบทวนประวัติรับซื้อ-ส่งมอบ พร้อมหลักฐานย้อนกลับถึงเกษตรกรและโรงงาน',
          actionChips: [
            MiddlemanTag(
              label: 'รับซื้อรวม ${_formatCurrency(totalPurchase)}',
              color: Colors.deepOrange,
            ),
            MiddlemanTag(
              label: 'ส่งขายรวม ${_formatCurrency(totalSale)}',
              color: MiddlemanPalette.success,
            ),
            MiddlemanTag(
              label: 'ปรับยอดแล้ว ${_repository.tradeRecords.where((trade) => trade.reconciled).length} รายการ',
              color: MiddlemanPalette.info,
            ),
          ],
          children: [
            _buildFilterChips(),
            const SizedBox(height: 12),
            ..._buildTradeList(trades),
          ],
        );
      },
    );
  }

  Widget _buildFilterChips() {
    return Wrap(
      spacing: 8,
      children: [
        FilterChip(
          selected: _filter == TradeType.purchase,
          label: const Text('เฉพาะรับซื้อ'),
          onSelected: (value) {
            setState(() {
              _filter = value ? TradeType.purchase : null;
            });
          },
        ),
        FilterChip(
          selected: _filter == TradeType.sale,
          label: const Text('เฉพาะส่งขาย'),
          onSelected: (value) {
            setState(() {
              _filter = value ? TradeType.sale : null;
            });
          },
        ),
        FilterChip(
          selected: _filter == null,
          label: const Text('ทั้งหมด'),
          onSelected: (value) {
            if (value) {
              setState(() => _filter = null);
            }
          },
        ),
      ],
    );
  }

  List<Widget> _buildTradeList(List<TradeRecord> trades) {
    if (trades.isEmpty) {
      return [
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
            'ไม่พบรายการในหมวดนี้ ลองเลือกช่วงอื่นหรือกลับไปบันทึกข้อมูลเพิ่มเติม',
            style: TextStyle(color: MiddlemanPalette.textSecondary),
          ),
        ),
      ];
    }

    return [
      for (final trade in trades)
        MiddlemanListTile(
          leadingIcon: trade.type == TradeType.purchase
              ? Icons.download_outlined
              : Icons.upload_outlined,
          iconColor: trade.type.color,
          title: '${trade.referenceId} • ${trade.counterparty}',
          subtitle:
              '${_formatWeight(trade.weightKg)} • ${_formatCurrency(trade.amount)}\n${_formatDateTime(trade.timestamp)}',
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Switch(
                value: trade.reconciled,
                onChanged: (value) =>
                    _repository.toggleTradeReconciled(trade, value),
                activeColor: MiddlemanPalette.success,
              ),
              const SizedBox(height: 4),
              Text(
                trade.reconciled ? 'ปรับยอดแล้ว' : 'รอตรวจสอบ',
                style: const TextStyle(
                  fontSize: 12,
                  color: MiddlemanPalette.textSecondary,
                ),
              ),
            ],
          ),
        ),
    ];
  }

  String _formatCurrency(double amount) {
    return '฿${amount.toStringAsFixed(2)}';
  }

  String _formatWeight(double weightKg) {
    return weightKg >= 1000
        ? '${(weightKg / 1000).toStringAsFixed(1)} ตัน'
        : '${weightKg.toStringAsFixed(0)} กก.';
  }

  String _formatDateTime(DateTime time) {
    final date = '${time.day.toString().padLeft(2, '0')}/${time.month.toString().padLeft(2, '0')}';
    final hour = '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    return '$date • $hour น.';
  }
}
