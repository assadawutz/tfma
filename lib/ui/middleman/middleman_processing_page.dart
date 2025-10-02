import 'package:flutter/material.dart';

import 'middleman_shared_widgets.dart';
import 'middleman_workflow_state.dart';

class MiddlemanProcessingPage extends StatefulWidget {
  const MiddlemanProcessingPage({super.key});

  @override
  State<MiddlemanProcessingPage> createState() => _MiddlemanProcessingPageState();
}

class _MiddlemanProcessingPageState extends State<MiddlemanProcessingPage> {
  final _locationController = TextEditingController();
  final _noteController = TextEditingController();
  String? _selectedBatchId;

  MiddlemanWorkflowRepository get _repository =>
      MiddlemanWorkflowRepository.instance;

  @override
  void dispose() {
    _locationController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _repository,
      builder: (context, _) {
        final batches = _repository.processingBatches;
        final activeBatches =
            batches.where((batch) => batch.stage != ProcessingStage.completed).toList();
        final completed =
            batches.where((batch) => batch.stage == ProcessingStage.completed).toList();

        if (_selectedBatchId != null &&
            activeBatches.every((batch) => batch.batchId != _selectedBatchId)) {
          _selectedBatchId = activeBatches.isEmpty ? null : activeBatches.first.batchId;
          if (_selectedBatchId != null) {
            final selected =
                activeBatches.firstWhere((batch) => batch.batchId == _selectedBatchId);
            _locationController.text = selected.location;
          }
        }

        return MiddlemanScreenScaffold(
          title: 'แปรรูปเป็นข้าวโพดเม็ด',
          subtitle:
              'ติดตามสถานะอบแห้ง คัดแยก และแพ็กกิ้งก่อนนำส่งโรงงาน พร้อมบันทึกหมายเหตุหน้างาน',
          actionChips: [
            MiddlemanTag(
              label: 'กำลังดำเนินการ ${activeBatches.length} ล็อต',
              color: MiddlemanPalette.warning,
            ),
            MiddlemanTag(
              label: 'เสร็จสิ้น ${completed.length} ล็อต',
              color: MiddlemanPalette.success,
            ),
          ],
          children: [
            _buildAssignmentCard(activeBatches),
            const MiddlemanSection(
              title: 'งานที่กำลังดำเนินการ',
              icon: Icons.settings_suggest_outlined,
            ),
            ..._buildBatchList(activeBatches),
            const MiddlemanSection(
              title: 'งานที่เสร็จสิ้นวันนี้',
              icon: Icons.verified_outlined,
            ),
            ..._buildBatchList(completed, completed: true),
          ],
        );
      },
    );
  }

  Widget _buildAssignmentCard(List<ProcessingBatch> batches) {
    ProcessingBatch? selectedBatch;
    if (_selectedBatchId != null) {
      for (final batch in batches) {
        if (batch.batchId == _selectedBatchId) {
          selectedBatch = batch;
          break;
        }
      }
    } else if (batches.isNotEmpty) {
      selectedBatch = batches.first;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted || _selectedBatchId != null) return;
        setState(() {
          _selectedBatchId = batches.first.batchId;
          _locationController.text = batches.first.location;
        });
      });
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.assignment_turned_in, color: MiddlemanPalette.primary),
              SizedBox(width: 8),
              Text('บันทึกความคืบหน้าหน้างาน',
                  style: TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 12),
          if (batches.isEmpty)
            const Text(
              'ยังไม่มีล็อตที่ต้องแปรรูป ระบบจะสร้างอัตโนมัติเมื่อบันทึกการรับซื้อ',
              style: TextStyle(color: MiddlemanPalette.textSecondary),
            )
          else ...[
            const Text(
              'เลือกล็อตเพื่ออัปเดตสถานะ ระบุตำแหน่งจัดเก็บ และบันทึกปัญหาที่เกิดขึ้น',
              style: TextStyle(fontSize: 13, color: MiddlemanPalette.textSecondary),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedBatchId,
              items: [
                for (final batch in batches)
                  DropdownMenuItem(
                    value: batch.batchId,
                    child: Text('${batch.batchId} • ${batch.originTicketId}'),
                  ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedBatchId = value;
                  if (value != null) {
                    final batch =
                        batches.firstWhere((element) => element.batchId == value);
                    _locationController.text = batch.location;
                  }
                });
              },
              decoration: InputDecoration(
                labelText: 'เลือกล็อตที่ต้องการอัปเดต',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: const Color(0xFFF7F9FC),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: 'ตำแหน่งจัดเก็บ/โรงเรือน',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: const Color(0xFFF7F9FC),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _noteController,
              maxLines: 2,
              decoration: InputDecoration(
                labelText: 'หมายเหตุและงานค้าง',
                hintText: 'เช่น ตรวจความสะอาดก่อนแพ็กกิ้ง หรือรอเครื่องอบชุดที่ 2',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: const Color(0xFFF7F9FC),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final stage in ProcessingStage.values)
                  ChoiceChip(
                    label: Text(_stageLabel(stage)),
                    selected: selectedBatch?.stage == stage,
                    onSelected: (selected) {
                      if (!selected || selectedBatch == null) return;
                      _repository.updateProcessingBatch(selectedBatch, stage: stage);
                      _pushNote(selectedBatch);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'อัปเดต ${selectedBatch.batchId} เป็น ${_stageLabel(stage)}'),
                        ),
                      );
                    },
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _selectedBatchId = null;
                        _locationController.clear();
                        _noteController.clear();
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: MiddlemanPalette.textSecondary,
                      side: const BorderSide(color: Color(0xFFE0E6EE)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('ล้างข้อมูล'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (selectedBatch == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('เลือกล็อตก่อนบันทึก')),
                        );
                        return;
                      }
                      _repository.updateProcessingBatch(selectedBatch,
                          location: _locationController.text.isEmpty
                              ? selectedBatch.location
                              : _locationController.text);
                      _pushNote(selectedBatch);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('บันทึกข้อมูล ${selectedBatch.batchId} แล้ว'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MiddlemanPalette.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('บันทึกหมายเหตุ'),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  List<Widget> _buildBatchList(List<ProcessingBatch> batches,
      {bool completed = false}) {
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
          child: Text(
            completed
                ? 'ยังไม่มีงานที่เสร็จสิ้นในวันนี้'
                : 'ไม่มีงานกำลังดำเนินการ ลองตรวจสอบคิวรับซื้อเพิ่มเติม',
            style: const TextStyle(color: MiddlemanPalette.textSecondary),
          ),
        ),
      ];
    }

    return [
      for (final batch in batches)
        MiddlemanListTile(
          leadingIcon: Icons.precision_manufacturing_outlined,
          iconColor: completed
              ? MiddlemanPalette.success
              : MiddlemanPalette.warning,
          title: '${batch.batchId} • ${batch.originTicketId}',
          subtitle:
              '${_stageLabel(batch.stage)} • ${batch.location}\nน้ำหนัก ${batch.weightKg.toStringAsFixed(0)} กก. • อัปเดต ${_relativeTime(batch.updatedAt)}',
          trailing: completed
              ? MiddlemanTag(
                  label: 'พร้อมส่ง',
                  color: MiddlemanPalette.success,
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () => _repository.advanceProcessingStage(batch),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MiddlemanPalette.primary,
                        minimumSize: const Size(120, 36),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('ขยับขั้นตอน'),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'ความคืบหน้า ${_progress(batch.stage)}%',
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

  void _pushNote(ProcessingBatch batch) {
    if (_noteController.text.isEmpty) return;
    _repository.logCustomActivity(
      WorkflowActivity(
        title: 'หมายเหตุแปรรูป ${batch.batchId}',
        detail: _noteController.text,
        icon: Icons.notes,
        color: Colors.indigo,
        timestamp: DateTime.now(),
      ),
    );
    _noteController.clear();
  }

  String _stageLabel(ProcessingStage stage) {
    switch (stage) {
      case ProcessingStage.receiving:
        return 'รออบแห้ง';
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

  int _progress(ProcessingStage stage) {
    switch (stage) {
      case ProcessingStage.receiving:
        return 20;
      case ProcessingStage.drying:
        return 45;
      case ProcessingStage.grading:
        return 70;
      case ProcessingStage.packaging:
        return 90;
      case ProcessingStage.completed:
        return 100;
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
