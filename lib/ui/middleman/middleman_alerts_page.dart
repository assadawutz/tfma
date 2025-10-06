import 'package:flutter/material.dart';

import 'middleman_shared_widgets.dart';
import 'middleman_workflow_state.dart';

class MiddlemanAlertsPage extends StatefulWidget {
  const MiddlemanAlertsPage({super.key});

  @override
  State<MiddlemanAlertsPage> createState() => _MiddlemanAlertsPageState();
}

class _MiddlemanAlertsPageState extends State<MiddlemanAlertsPage> {
  final _formKey = GlobalKey<FormState>();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _searchController = TextEditingController();
  String _severity = 'สูง';
  String _searchTerm = '';
  String? _severityFilter;

  MiddlemanWorkflowRepository get _repository =>
      MiddlemanWorkflowRepository.instance;

  @override
  void dispose() {
    _locationController.dispose();
    _descriptionController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _repository,
      builder: (context, _) {
        final alerts = _repository.burnAlerts;
        final unresolved = alerts.where((alert) => !alert.acknowledged).length;
        final filteredAlerts = _filterAlerts(alerts);
        final baseCount = _severityFilter == null
            ? alerts.length
            : alerts.where((alert) => alert.severity == _severityFilter).length;

        return MiddlemanScreenScaffold(
          title: 'แจ้งเตือนการเผาแปลง',
          subtitle:
              'เฝ้าระวังจุดความร้อนและแจ้งเตือนเกษตรกรเพื่อหยุดการเผาอย่างทันท่วงที',
          actionChips: [
            MiddlemanTag(
              label: 'ต้องติดตาม $unresolved จุด',
              color: unresolved > 0
                  ? MiddlemanPalette.warning
                  : MiddlemanPalette.success,
            ),
            MiddlemanTag(
              label: 'บันทึกทั้งหมด ${alerts.length} รายการ',
              color: MiddlemanPalette.info,
            ),
          ],
          children: [
            _buildManualAlertCard(),
            const MiddlemanSection(
              title: 'รายการแจ้งเตือน',
              icon: Icons.warning_amber_outlined,
            ),
            _buildSeverityFilter(alerts),
            const SizedBox(height: 12),
            _buildAlertSearch(filteredAlerts.length, baseCount),
            const SizedBox(height: 12),
            ..._buildAlertList(filteredAlerts, alerts.isNotEmpty),
          ],
        );
      },
    );
  }

  Widget _buildManualAlertCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
              color: Color(0x14000000), blurRadius: 12, offset: Offset(0, 6)),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.add_alert_outlined, color: MiddlemanPalette.warning),
                SizedBox(width: 8),
                Text('บันทึกเหตุการณ์จากภาคสนาม',
                    style: TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'หากทีมภาคสนามพบการเผาเพิ่มเติม สามารถบันทึกจุดเกิดเหตุและรายละเอียดเพื่อแจ้งเตือนทีมความปลอดภัยและเกษตรกรในเครือข่าย',
              style: TextStyle(
                  fontSize: 13, color: MiddlemanPalette.textSecondary),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: 'สถานที่เกิดเหตุ',
                hintText: 'เช่น ต.โนนแดง อ.เมือง',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: const Color(0xFFF7F9FC),
              ),
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'ระบุสถานที่เกิดเหตุ'
                  : null,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _severity,
              decoration: InputDecoration(
                labelText: 'ระดับความรุนแรง',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: const Color(0xFFF7F9FC),
              ),
              items: const [
                DropdownMenuItem(
                    value: 'สูง', child: Text('สูง - มีควันและไฟลุก')),
                DropdownMenuItem(
                    value: 'กลาง', child: Text('กลาง - มีควัน/แสงไฟเล็กน้อย')),
                DropdownMenuItem(
                    value: 'ต่ำ',
                    child: Text('ต่ำ - พบกลิ่นไหม้/ร่องรอยก่อนเกิดเหตุ')),
              ],
              onChanged: (value) => setState(() => _severity = value ?? 'สูง'),
              validator: (value) =>
                  value == null ? 'เลือกระดับความรุนแรง' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _descriptionController,
              maxLines: 2,
              decoration: InputDecoration(
                labelText: 'รายละเอียดเพิ่มเติม',
                hintText: 'เช่น พบการเผาเศษซากหลังเก็บเกี่ยว มีลมแรง',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: const Color(0xFFF7F9FC),
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: _createManualAlert,
                style: ElevatedButton.styleFrom(
                  backgroundColor: MiddlemanPalette.warning,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.save_outlined),
                label: const Text('บันทึกเหตุการณ์'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeverityFilter(List<BurnAlert> alerts) {
    final high = alerts.where((alert) => alert.severity == 'สูง').length;
    final medium = alerts.where((alert) => alert.severity == 'กลาง').length;
    final low = alerts.where((alert) => alert.severity == 'ต่ำ').length;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        FilterChip(
          label: Text('ทั้งหมด (${alerts.length})'),
          selected: _severityFilter == null,
          onSelected: (value) {
            if (value) {
              setState(() => _severityFilter = null);
            }
          },
        ),
        FilterChip(
          label: Text('ระดับสูง ($high)'),
          selected: _severityFilter == 'สูง',
          onSelected: high == 0
              ? null
              : (value) =>
                  setState(() => _severityFilter = value ? 'สูง' : null),
        ),
        FilterChip(
          label: Text('ระดับกลาง ($medium)'),
          selected: _severityFilter == 'กลาง',
          onSelected: medium == 0
              ? null
              : (value) =>
                  setState(() => _severityFilter = value ? 'กลาง' : null),
        ),
        FilterChip(
          label: Text('ระดับต่ำ ($low)'),
          selected: _severityFilter == 'ต่ำ',
          onSelected: low == 0
              ? null
              : (value) =>
                  setState(() => _severityFilter = value ? 'ต่ำ' : null),
        ),
      ],
    );
  }

  Widget _buildAlertSearch(int resultCount, int baseCount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MiddlemanSearchField(
          controller: _searchController,
          hintText: 'ค้นหาตามพื้นที่ รายละเอียด หรือระดับความรุนแรง',
          onChanged: (value) => setState(() => _searchTerm = value.trim()),
        ),
        const SizedBox(height: 8),
        Text(
          _searchTerm.isEmpty
              ? 'แสดงทั้งหมด $baseCount รายการ'
              : 'ผลการค้นหา $resultCount รายการ',
          style: const TextStyle(
            fontSize: 12,
            color: MiddlemanPalette.textSecondary,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildAlertList(List<BurnAlert> alerts, bool hasAnyAlerts) {
    if (alerts.isEmpty) {
      final message = !hasAnyAlerts
          ? 'ยังไม่มีแจ้งเตือนการเผา ระบบจะดึงข้อมูลจากดาวเทียมและภาคสนามอัตโนมัติ'
          : _searchTerm.isNotEmpty
              ? 'ไม่พบแจ้งเตือนที่ตรงกับ "$_searchTerm"'
              : 'ไม่มีแจ้งเตือนในระดับที่เลือก';
      return [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                  color: Color(0x11000000),
                  blurRadius: 10,
                  offset: Offset(0, 4)),
            ],
          ),
          child: Text(
            message,
            style: const TextStyle(color: MiddlemanPalette.textSecondary),
          ),
        ),
      ];
    }

    return [
      for (final alert in alerts)
        MiddlemanListTile(
          leadingIcon: Icons.fireplace_outlined,
          iconColor: alert.acknowledged
              ? MiddlemanPalette.success
              : MiddlemanPalette.warning,
          title: alert.location,
          subtitle:
              'ระดับ${alert.severity} • ตรวจพบ ${_relativeTime(alert.detectedAt)}\n${alert.description}',
          trailing: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Switch(
                value: alert.acknowledged,
                onChanged: (value) => _toggleAlert(alert, value),
                activeThumbColor: MiddlemanPalette.success,
              ),
              const SizedBox(height: 4),
              Text(
                alert.acknowledged ? 'แจ้งแล้ว' : 'รอแจ้งเตือน',
                style: const TextStyle(
                  fontSize: 12,
                  color: MiddlemanPalette.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              IconButton(
                onPressed: () => _confirmDeleteAlert(alert),
                icon: const Icon(Icons.delete_outline),
                color: Colors.redAccent,
                tooltip: 'ลบแจ้งเตือน',
              ),
            ],
          ),
        ),
    ];
  }

  List<BurnAlert> _filterAlerts(List<BurnAlert> alerts) {
    Iterable<BurnAlert> filtered = alerts;
    if (_severityFilter != null) {
      filtered = filtered.where((alert) => alert.severity == _severityFilter);
    }
    if (_searchTerm.isEmpty) {
      return filtered.toList();
    }
    final query = _searchTerm.toLowerCase();
    return filtered
        .where((alert) =>
            '${alert.location} ${alert.description} ${alert.severity}'
                .toLowerCase()
                .contains(query))
        .toList();
  }

  void _createManualAlert() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    FocusScope.of(context).unfocus();
    final location = _locationController.text.trim();
    final description = _descriptionController.text.trim();
    _repository.addManualAlert(
      location: location,
      severity: _severity,
      description: description,
    );
    _locationController.clear();
    _descriptionController.clear();
    setState(() {
      _severity = 'สูง';
    });
    _formKey.currentState?.reset();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('บันทึกการแจ้งเตือน $location แล้ว')),
    );
  }

  void _toggleAlert(BurnAlert alert, bool acknowledged) {
    _repository.acknowledgeAlert(alert, acknowledged);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          acknowledged
              ? 'รับทราบเหตุไฟที่ ${alert.location} แล้ว'
              : 'กลับมาเฝ้าระวังจุด ${alert.location}',
        ),
      ),
    );
  }

  Future<void> _confirmDeleteAlert(BurnAlert alert) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ลบแจ้งเตือน'),
        content: Text('ต้องการลบแจ้งเตือนบริเวณ ${alert.location} หรือไม่?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('ยกเลิก'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child: const Text('ลบแจ้งเตือน'),
          ),
        ],
      ),
    );
    if (shouldDelete != true) {
      return;
    }
    final success = _repository.deleteAlert(alert);
    if (!success) {
      ScaffoldMessenger.of(mounted as BuildContext).showSnackBar(
        const SnackBar(content: Text('ไม่สามารถลบแจ้งเตือนได้')),
      );
      return;
    }
    ScaffoldMessenger.of(mounted as BuildContext).showSnackBar(
      SnackBar(content: Text('ลบแจ้งเตือน ${alert.location} แล้ว')),
    );
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
