import 'package:flutter/material.dart';

import 'middleman_shared_widgets.dart';
import 'middleman_workflow_state.dart';

class MiddlemanAlertsPage extends StatefulWidget {
  const MiddlemanAlertsPage({super.key});

  @override
  State<MiddlemanAlertsPage> createState() => _MiddlemanAlertsPageState();
}

class _MiddlemanAlertsPageState extends State<MiddlemanAlertsPage> {
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _severity = 'สูง';

  MiddlemanWorkflowRepository get _repository =>
      MiddlemanWorkflowRepository.instance;

  @override
  void dispose() {
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _repository,
      builder: (context, _) {
        final alerts = _repository.burnAlerts;
        final unresolved = alerts.where((alert) => !alert.acknowledged).length;

        return MiddlemanScreenScaffold(
          title: 'แจ้งเตือนการเผาแปลง',
          subtitle: 'เฝ้าระวังจุดความร้อนและแจ้งเตือนเกษตรกรเพื่อหยุดการเผาอย่างทันท่วงที',
          actionChips: [
            MiddlemanTag(
              label: 'ต้องติดตาม $unresolved จุด',
              color: unresolved > 0 ? MiddlemanPalette.warning : MiddlemanPalette.success,
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
            ..._buildAlertList(alerts),
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
          BoxShadow(color: Color(0x14000000), blurRadius: 12, offset: Offset(0, 6)),
        ],
      ),
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
            style: TextStyle(fontSize: 13, color: MiddlemanPalette.textSecondary),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _locationController,
            decoration: InputDecoration(
              labelText: 'สถานที่เกิดเหตุ',
              hintText: 'เช่น ต.โนนแดง อ.เมือง',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
              fillColor: const Color(0xFFF7F9FC),
            ),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _severity,
            decoration: InputDecoration(
              labelText: 'ระดับความรุนแรง',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
              fillColor: const Color(0xFFF7F9FC),
            ),
            items: const [
              DropdownMenuItem(value: 'สูง', child: Text('สูง - มีควันและไฟลุก')), 
              DropdownMenuItem(value: 'กลาง', child: Text('กลาง - มีควัน/แสงไฟเล็กน้อย')), 
              DropdownMenuItem(value: 'ต่ำ', child: Text('ต่ำ - พบกลิ่นไหม้/ร่องรอยก่อนเกิดเหตุ')), 
            ],
            onChanged: (value) => setState(() => _severity = value ?? 'สูง'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _descriptionController,
            maxLines: 2,
            decoration: InputDecoration(
              labelText: 'รายละเอียดเพิ่มเติม',
              hintText: 'เช่น พบการเผาเศษซากหลังเก็บเกี่ยว มีลมแรง',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
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
    );
  }

  List<Widget> _buildAlertList(List<BurnAlert> alerts) {
    if (alerts.isEmpty) {
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
            'ยังไม่มีแจ้งเตือนการเผา ระบบจะดึงข้อมูลจากดาวเทียมและการรายงานภาคสนามอัตโนมัติ',
            style: TextStyle(color: MiddlemanPalette.textSecondary),
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
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Switch(
                value: alert.acknowledged,
                onChanged: (value) =>
                    _repository.acknowledgeAlert(alert, value),
                activeColor: MiddlemanPalette.success,
              ),
              const SizedBox(height: 4),
              Text(
                alert.acknowledged ? 'แจ้งแล้ว' : 'รอแจ้งเตือน',
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

  void _createManualAlert() {
    final location = _locationController.text.trim();
    if (location.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('กรอกสถานที่ก่อนบันทึก')),
      );
      return;
    }
    final description = _descriptionController.text.trim();
    _repository.addManualAlert(
      location: location,
      severity: _severity,
      description:
          description.isEmpty ? 'ทีมภาคสนามรายงานเหตุการณ์เพิ่มเติม' : description,
    );
    _locationController.clear();
    _descriptionController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('บันทึกการแจ้งเตือน $location แล้ว')),
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
