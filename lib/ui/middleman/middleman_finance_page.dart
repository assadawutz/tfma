import 'package:flutter/material.dart';

import 'middleman_shared_widgets.dart';
import 'middleman_workflow_state.dart';

class MiddlemanFinancePage extends StatefulWidget {
  const MiddlemanFinancePage({super.key});

  @override
  State<MiddlemanFinancePage> createState() => _MiddlemanFinancePageState();
}

class _MiddlemanFinancePageState extends State<MiddlemanFinancePage> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  final _counterpartyController = TextEditingController();
  bool _isExpense = true;
  final _searchController = TextEditingController();
  String _searchTerm = '';

  MiddlemanWorkflowRepository get _repository =>
      MiddlemanWorkflowRepository.instance;

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    _counterpartyController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _repository,
      builder: (context, _) {
        final transactions = _repository.financeTransactions;
        final expenses = transactions
            .where((tx) => tx.isExpense)
            .fold<double>(0, (value, tx) => value + tx.amount);
        final incomes = transactions
            .where((tx) => !tx.isExpense)
            .fold<double>(0, (value, tx) => value + tx.amount);
        final settled = transactions.where((tx) => tx.settled).length;
        final filteredTransactions = _filterTransactions(transactions);
        final resultCount = filteredTransactions.length;

        return MiddlemanScreenScaffold(
          title: 'การเงินและการชำระเงิน',
          subtitle: 'ยืนยันการจ่ายเงินให้เกษตรกรและติดตามการรับชำระจากโรงงานแบบโปร่งใส',
          actionChips: [
            MiddlemanTag(
              label: 'รายรับ ${_formatCurrency(incomes)}',
              color: MiddlemanPalette.success,
            ),
            MiddlemanTag(
              label: 'รายจ่าย ${_formatCurrency(expenses)}',
              color: MiddlemanPalette.warning,
            ),
            MiddlemanTag(
              label: 'ปรับสถานะแล้ว $settled รายการ',
              color: MiddlemanPalette.info,
            ),
          ],
          children: [
            _buildBalanceCard(incomes, expenses),
            const MiddlemanSection(
              title: 'บันทึกการทำธุรกรรม',
              icon: Icons.receipt_long,
            ),
            _buildTransactionForm(),
            const MiddlemanSection(
              title: 'รายการล่าสุด',
              icon: Icons.list_alt_outlined,
            ),
            _buildTransactionSearch(resultCount),
            const SizedBox(height: 12),
            ..._buildTransactionList(filteredTransactions),
          ],
        );
      },
    );
  }

  Widget _buildBalanceCard(double incomes, double expenses) {
    final balance = incomes - expenses;
    final progress = incomes == 0 ? 0 : (expenses / incomes).clamp(0, 1);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Color(0x14000000), blurRadius: 12, offset: Offset(0, 6)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: MiddlemanPalette.primary.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(12),
                child: const Icon(Icons.account_balance_wallet_outlined,
                    color: MiddlemanPalette.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'สรุปสถานะการเงิน',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'ยอดคงเหลือสุทธิ ${_formatCurrency(balance)}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: MiddlemanPalette.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              MiddlemanTag(
                label: balance >= 0 ? 'สภาพคล่องดี' : 'ควบคุมค่าใช้จ่าย',
                color: balance >= 0 ? MiddlemanPalette.success : MiddlemanPalette.warning,
              ),
            ],
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: const Color(0xFFE0E6EE),
            color: balance >= 0 ? MiddlemanPalette.success : MiddlemanPalette.warning,
            minHeight: 10,
            borderRadius: BorderRadius.circular(8),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('รายจ่าย ${_formatCurrency(expenses)}',
                  style: const TextStyle(color: MiddlemanPalette.textSecondary)),
              Text('รายรับ ${_formatCurrency(incomes)}',
                  style: const TextStyle(color: MiddlemanPalette.textSecondary)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionForm() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Color(0x11000000), blurRadius: 10, offset: Offset(0, 4)),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'รายละเอียดรายการ',
                hintText: 'เช่น ชำระเงินรับซื้อ RC-2024-074',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: const Color(0xFFF7F9FC),
              ),
              validator: (value) =>
                  value == null || value.isEmpty ? 'ระบุรายละเอียดรายการ' : null,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _amountController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'จำนวนเงิน (บาท)',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: const Color(0xFFF7F9FC),
                    ),
                    validator: (value) {
                      final parsed = double.tryParse(value ?? '');
                      if (parsed == null || parsed <= 0) {
                        return 'กรอกจำนวนเงินที่ถูกต้อง';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _counterpartyController,
                    decoration: InputDecoration(
                      labelText: 'คู่สัญญา/ผู้รับเงิน',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: const Color(0xFFF7F9FC),
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'กรอกชื่อคู่สัญญา' : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: SwitchListTile(
                    value: _isExpense,
                    onChanged: (value) => setState(() => _isExpense = value),
                    contentPadding: EdgeInsets.zero,
                    title: const Text('บันทึกเป็นรายจ่าย'),
                    subtitle: const Text('ปิดสวิตช์เพื่อบันทึกเป็นรายรับ'),
                    activeColor: MiddlemanPalette.warning,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _recordTransaction,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MiddlemanPalette.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text('บันทึก'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionSearch(int resultCount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MiddlemanSearchField(
          controller: _searchController,
          hintText: 'ค้นหาเลขธุรกรรม รายละเอียด หรือคู่ค้า',
          onChanged: (value) => setState(() => _searchTerm = value.trim()),
        ),
        const SizedBox(height: 8),
        Text(
          _searchTerm.isEmpty
              ? 'แสดงทั้งหมด $resultCount รายการ'
              : 'ผลการค้นหา $resultCount รายการ',
          style: const TextStyle(
            fontSize: 12,
            color: MiddlemanPalette.textSecondary,
          ),
        ),
      ],
    );
  }

  List<FinanceTransaction> _filterTransactions(
      List<FinanceTransaction> transactions) {
    if (_searchTerm.isEmpty) {
      return transactions;
    }
    final query = _searchTerm.toLowerCase();
    return transactions
        .where((tx) =>
            '${tx.transactionId} ${tx.description} ${tx.counterparty}'
                .toLowerCase()
                .contains(query))
        .toList();
  }

  Future<void> _confirmDeleteTransaction(FinanceTransaction tx) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ลบรายการเงิน'),
        content: Text('ยืนยันการลบ ${tx.transactionId} (${tx.description}) หรือไม่?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('ยกเลิก'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child: const Text('ลบรายการ'),
          ),
        ],
      ),
    );
    if (shouldDelete != true) {
      return;
    }
    final success = _repository.deleteFinanceTransaction(tx.transactionId);
    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ไม่พบรายการในระบบ')), 
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('ลบรายการ ${tx.transactionId} แล้ว')), 
    );
    setState(() {});
  }

  List<Widget> _buildTransactionList(List<FinanceTransaction> transactions) {
    if (transactions.isEmpty) {
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
          child: Text(
            _searchTerm.isEmpty
                ? 'ยังไม่มีรายการในระบบ กดบันทึกด้านบนเพื่อเพิ่มข้อมูล'
                : 'ไม่พบรายการที่ตรงกับ "$_searchTerm"',
            style: const TextStyle(color: MiddlemanPalette.textSecondary),
          ),
        ),
      ];
    }

    return [
      for (final tx in transactions)
        MiddlemanListTile(
          leadingIcon: tx.isExpense ? Icons.south_west : Icons.north_east,
          iconColor: tx.isExpense ? MiddlemanPalette.warning : MiddlemanPalette.success,
          title: '${tx.transactionId} • ${tx.counterparty}',
          subtitle:
              '${_formatCurrency(tx.amount)} • ${_formatDateTime(tx.timestamp)}\n${tx.description}',
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Switch(
                value: tx.settled,
                onChanged: (value) =>
                    _repository.toggleFinanceSettlement(tx, value),
                activeColor: MiddlemanPalette.success,
              ),
              const SizedBox(height: 4),
              Text(
                tx.settled ? 'ชำระเรียบร้อย' : 'รอตรวจสอบ',
                style: const TextStyle(
                  fontSize: 12,
                  color: MiddlemanPalette.textSecondary,
                ),
              ),
              TextButton(
                onPressed: () => _confirmDeleteTransaction(tx),
                child: const Text(
                  'ลบ',
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
            ],
          ),
        ),
    ];
  }

  void _recordTransaction() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    final amount = double.parse(_amountController.text.trim());
    final description = _descriptionController.text.trim();
    final counterparty = _counterpartyController.text.trim();

    FocusScope.of(context).unfocus();
    final id = 'FIN-${DateTime.now().millisecondsSinceEpoch.toString().substring(6)}';
    final result = _repository.recordFinanceTransaction(
      transactionId: id,
      description: description,
      amount: amount,
      counterparty: counterparty,
      isExpense: _isExpense,
    );

    if (result == WorkflowMutationResult.ignored) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ไม่สามารถบันทึกธุรกรรมได้ กรุณาตรวจสอบข้อมูล')),
      );
      return;
    }

    _formKey.currentState?.reset();
    _descriptionController.clear();
    _amountController.clear();
    _counterpartyController.clear();
    setState(() {
      _isExpense = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          result == WorkflowMutationResult.created
              ? 'บันทึกธุรกรรม $id แล้ว'
              : 'อัปเดตรายการการเงิน $id แล้ว',
        ),
      ),
    );
  }

  String _formatCurrency(double amount) {
    return '฿${amount.toStringAsFixed(2)}';
  }

  String _formatDateTime(DateTime time) {
    final date = '${time.day.toString().padLeft(2, '0')}/${time.month.toString().padLeft(2, '0')}';
    final hour = '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    return '$date • $hour น.';
  }
}
