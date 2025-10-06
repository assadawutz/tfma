import 'package:flutter/material.dart';

import 'middleman_shared_widgets.dart';
import 'middleman_workflow_state.dart';

class MiddlemanMoisturePage extends StatefulWidget {
  const MiddlemanMoisturePage({super.key});

  @override
  State<MiddlemanMoisturePage> createState() => _MiddlemanMoisturePageState();
}

class _MiddlemanMoisturePageState extends State<MiddlemanMoisturePage> {
  final _formKey = GlobalKey<FormState>();
  final _moistureController = TextEditingController();
  final _inspectorController = TextEditingController(text: 'ผู้ตรวจใหม่');
  final _noteController = TextEditingController();
  String? _selectedTicket;
  final _historySearchController = TextEditingController();
  String _historyQuery = '';

  MiddlemanWorkflowRepository get _repository =>
      MiddlemanWorkflowRepository.instance;

  @override
  void dispose() {
    _moistureController.dispose();
    _inspectorController.dispose();
    _noteController.dispose();
    _historySearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _repository,
      builder: (context, _) {
        final pendingBatches = _repository.processingBatches
            .where((batch) => batch.stage != ProcessingStage.completed)
            .toList();
        final tickets = _repository.purchases;
        if (tickets.isEmpty) {
          _selectedTicket = null;
        } else if (_selectedTicket == null ||
            tickets.every((ticket) => ticket.ticketId != _selectedTicket)) {
          _selectedTicket = tickets.first.ticketId;
        }

        return MiddlemanScreenScaffold(
          title: 'วัดความชื้นข้าวโพด',
          subtitle: 'บันทึกผลการวัดและดูสถานะล็อตที่ต้องลดความชื้นก่อนส่งต่อ',
          actionChips: [
            MiddlemanTag(
              label: 'ต้องวัดวันนี้ ${pendingBatches.length} ล็อต',
              color: MiddlemanPalette.warning,
            ),
            MiddlemanTag(
              label: 'ค่าเฉลี่ยล่าสุด ${_repository.averageMoisture?.toStringAsFixed(1) ?? '-'}%',
              color: MiddlemanPalette.info,
            ),
          ],
          children: [
            _buildMeasurementForm(tickets),
            const MiddlemanSection(
              title: 'สถานะล็อตที่รอวัด',
              icon: Icons.timelapse_outlined,
            ),
            ..._buildPendingBatches(pendingBatches),
            const MiddlemanSection(
              title: 'ประวัติการวัดล่าสุด',
              icon: Icons.history,
            ),
            _buildHistorySearch(),
            const SizedBox(height: 12),
            _buildRecentHistory(),
          ],
        );
      },
    );
  }

  Widget _buildMeasurementForm(List<PurchaseTicket> tickets) {
    if (tickets.isEmpty) {
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
        child: const Text(
          'ยังไม่มีใบรับซื้อในระบบ โปรดบันทึกการรับซื้อก่อนเพื่อเชื่อมโยงข้อมูลความชื้น',
          style: TextStyle(color: MiddlemanPalette.textSecondary),
        ),
      );
    }

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
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.science_outlined, color: MiddlemanPalette.info),
                SizedBox(width: 8),
                Text('บันทึกค่าความชื้น',
                    style: TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'เลือกล็อตจากการรับซื้อหรือสแกนเลขใบรับซื้อเพื่อตรวจวัดความชื้น ทุกล็อตต้องต่ำกว่า 14% ก่อนส่งให้โรงงาน',
              style: TextStyle(fontSize: 13, color: MiddlemanPalette.textSecondary),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _selectedTicket,
              decoration: InputDecoration(
                labelText: 'ใบรับซื้อ',
                hintText: 'เลือกใบรับซื้อ',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: const Color(0xFFF7F9FC),
              ),
              items: [
                for (final ticket in tickets)
                  DropdownMenuItem(
                    value: ticket.ticketId,
                    child: Text('${ticket.ticketId} • ${ticket.farmerName}'),
                  ),
              ],
              onChanged: (value) => setState(() => _selectedTicket = value),
              validator: (value) => value == null ? 'เลือกใบรับซื้อ' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _moistureController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'ค่าความชื้น (%)',
                hintText: 'เช่น 13.5',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: const Color(0xFFF7F9FC),
              ),
              validator: (value) {
                final moisture = double.tryParse(value ?? '');
                if (moisture == null) {
                  return 'กรอกค่าความชื้นที่ถูกต้อง';
                }
                if (moisture <= 0 || moisture > 30) {
                  return 'ค่าความชื้นต้องอยู่ระหว่าง 0-30%';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _inspectorController,
              decoration: InputDecoration(
                labelText: 'ผู้ตรวจสอบ',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: const Color(0xFFF7F9FC),
              ),
              validator: (value) =>
                  value == null || value.isEmpty ? 'ระบุชื่อผู้ตรวจสอบ' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _noteController,
              maxLines: 2,
              decoration: InputDecoration(
                labelText: 'หมายเหตุเพิ่มเติม',
                hintText: 'ระบุเครื่องมือที่ใช้หรือการแก้ไขที่ต้องทำ',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: const Color(0xFFF7F9FC),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _noteController.text = 'ต้องอบแห้งเพิ่ม 30 นาที',
                    style: OutlinedButton.styleFrom(
                      foregroundColor: MiddlemanPalette.primary,
                      side: const BorderSide(color: MiddlemanPalette.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('ใช้บันทึกมาตรฐาน'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _submitMeasurement,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MiddlemanPalette.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('บันทึกค่าความชื้น'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPendingBatches(List<ProcessingBatch> batches) {
    if (batches.isEmpty) {
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
            'ไม่มีล็อตที่รอวัดความชื้น ลองตรวจสอบขั้นตอนอื่นต่อได้เลย',
            style: TextStyle(color: MiddlemanPalette.textSecondary),
          ),
        ),
      ];
    }

    return [
      for (final batch in batches)
        MiddlemanListTile(
          leadingIcon: Icons.inventory_2_outlined,
          iconColor: batch.stage == ProcessingStage.drying
              ? MiddlemanPalette.warning
              : MiddlemanPalette.info,
          title: '${batch.batchId} • ${batch.location}',
          subtitle:
              'น้ำหนัก ${batch.weightKg.toStringAsFixed(0)} กก.\nอัปเดตล่าสุด ${_relativeTime(batch.updatedAt)}',
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              MiddlemanTag(
                label: _stageLabel(batch.stage),
                color: batch.stage == ProcessingStage.drying
                    ? MiddlemanPalette.warning
                    : MiddlemanPalette.primary,
              ),
              const SizedBox(height: 6),
              TextButton(
                onPressed: () => _repository.advanceProcessingStage(batch),
                child: const Text('ขยับสถานะ'),
              ),
            ],
          ),
        ),
    ];
  }

  Widget _buildRecentHistory() {
    final histories = _filteredMoistureLogs();
    if (histories.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(color: Color(0x11000000), blurRadius: 10, offset: Offset(0, 4)),
          ],
        ),
        child: Text(
          _historyQuery.isEmpty
              ? 'ยังไม่มีประวัติการวัด ระบบจะเก็บข้อมูลเมื่อมีการบันทึก'
              : 'ไม่พบผลการค้นหาที่ตรงกับ "$_historyQuery"',
          style: const TextStyle(color: MiddlemanPalette.textSecondary),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Color(0x11000000), blurRadius: 10, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          for (final history in histories)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          history.ticketId,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${history.note}\nโดย ${history.inspector}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: MiddlemanPalette.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MiddlemanTag(
                    label: '${history.moisture.toStringAsFixed(1)} %',
                    color: history.moisture <= 14
                        ? MiddlemanPalette.success
                        : MiddlemanPalette.warning,
                  ),
                  IconButton(
                    onPressed: () => _removeMoistureLog(history),
                    icon: const Icon(Icons.delete_outline),
                    color: Colors.redAccent,
                    tooltip: 'ลบประวัติ',
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHistorySearch() {
    final results = _filteredMoistureLogs().length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MiddlemanSearchField(
          controller: _historySearchController,
          hintText: 'ค้นหาใบรับซื้อหรือผู้ตรวจสอบ',
          onChanged: (value) => setState(() => _historyQuery = value.trim()),
        ),
        const SizedBox(height: 8),
        Text(
          _historyQuery.isEmpty
              ? 'แสดงล่าสุด $results รายการ'
              : 'ผลการค้นหา $results รายการ',
          style: const TextStyle(
            fontSize: 12,
            color: MiddlemanPalette.textSecondary,
          ),
        ),
      ],
    );
  }

  List<MoistureLog> _filteredMoistureLogs() {
    final query = _historyQuery.toLowerCase();
    final logs = _repository.moistureLogs.toList();
    if (query.isEmpty) {
      return logs.take(10).toList();
    }
    return logs
        .where((log) =>
            '${log.ticketId} ${log.inspector} ${log.note}'.toLowerCase().contains(query))
        .take(20)
        .toList();
  }

  void _removeMoistureLog(MoistureLog log) {
    final success = _repository.deleteMoistureLog(log);
    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ไม่สามารถลบประวัติได้')),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('ลบประวัติความชื้น ${log.ticketId} แล้ว')),
    );
    setState(() {});
  }

  void _submitMeasurement() {
    if (_selectedTicket == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('เลือกใบรับซื้อก่อนบันทึกค่าความชื้น')),
      );
      return;
    }
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    final ticketId = _selectedTicket!;
    final moisture = double.parse(_moistureController.text.trim());
    final inspector = _inspectorController.text.trim();
    final note = _noteController.text.trim();

    FocusScope.of(context).unfocus();
    _repository.recordMoisture(
      ticketId: ticketId,
      moisture: moisture,
      inspector: inspector,
      note: note.isEmpty ? 'ตรวจสอบตามปกติ' : note,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('บันทึกค่าความชื้น $ticketId เรียบร้อย')),
    );
    _moistureController.clear();
    _noteController.clear();
  }

  String _stageLabel(ProcessingStage stage) {
    switch (stage) {
      case ProcessingStage.receiving:
        return 'รอตรวจ';
      case ProcessingStage.drying:
        return 'อบลดความชื้น';
      case ProcessingStage.grading:
        return 'คัดเกรด';
      case ProcessingStage.packaging:
        return 'แพ็กกิ้ง';
      case ProcessingStage.completed:
        return 'เสร็จสิ้น';
    }
  }

  String _relativeTime(DateTime time) {
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
}
