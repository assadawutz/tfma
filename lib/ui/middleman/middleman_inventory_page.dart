import 'package:flutter/material.dart';

import 'middleman_shared_widgets.dart';
import 'middleman_workflow_state.dart';

class MiddlemanInventoryPage extends StatefulWidget {
  const MiddlemanInventoryPage({super.key});

  @override
  State<MiddlemanInventoryPage> createState() => _MiddlemanInventoryPageState();
}

class _MiddlemanInventoryPageState extends State<MiddlemanInventoryPage> {
  final _lotNameController = TextEditingController();
  final _capacityController = TextEditingController();
  final _filledController = TextEditingController();
  final _temperatureController = TextEditingController(text: '26.5');
  final _humidityController = TextEditingController(text: '60');

  MiddlemanWorkflowRepository get _repository =>
      MiddlemanWorkflowRepository.instance;

  @override
  void dispose() {
    _lotNameController.dispose();
    _capacityController.dispose();
    _filledController.dispose();
    _temperatureController.dispose();
    _humidityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _repository,
      builder: (context, _) {
        final lots = _repository.inventoryLots;
        final totalCapacity = lots.fold<double>(0, (value, lot) => value + lot.capacityTons);
        final totalStored = lots.fold<double>(0, (value, lot) => value + lot.filledTons);
        final avgTemp = lots.isEmpty
            ? 0
            : lots.fold<double>(0, (value, lot) => value + lot.temperatureC) / lots.length;
        final avgHumidity = lots.isEmpty
            ? 0
            : lots.fold<double>(0, (value, lot) => value + lot.humidity) / lots.length;
        final availablePercent = totalCapacity == 0
            ? 0
            : ((totalCapacity - totalStored) / totalCapacity * 100).clamp(0, 100);

        return MiddlemanScreenScaffold(
          title: 'จัดการคลังสินค้า',
          subtitle: 'วางแผนการหมุนเวียนสต็อก ดูสภาพแวดล้อม และแจ้งเตือนล็อตที่ต้องดูแล',
          actionChips: [
            MiddlemanTag(
              label: 'พื้นที่ว่าง ${availablePercent.toStringAsFixed(0)}%',
              color: MiddlemanPalette.info,
            ),
            MiddlemanTag(
              label: 'อุณหภูมิเฉลี่ย ${avgTemp.toStringAsFixed(1)}°C',
              color: MiddlemanPalette.success,
            ),
            MiddlemanTag(
              label: 'ความชื้นเฉลี่ย ${avgHumidity.toStringAsFixed(0)}%',
              color: MiddlemanPalette.primary,
            ),
          ],
          children: [
            _buildStorageSummary(totalStored, totalCapacity),
            const MiddlemanSection(
              title: 'พื้นที่จัดเก็บ',
              icon: Icons.store_mall_directory_outlined,
              trailing: MiddlemanTag(
                label: 'สแกนล่าสุด 5 นาที',
                color: MiddlemanPalette.info,
              ),
            ),
            ..._buildStorageGrid(lots),
            const MiddlemanSection(
              title: 'เพิ่มพื้นที่จัดเก็บใหม่',
              icon: Icons.add_business,
            ),
            _buildNewLotForm(),
          ],
        );
      },
    );
  }

  Widget _buildStorageSummary(double totalStored, double totalCapacity) {
    final readyToSell = _repository.processingBatches
        .where((batch) => batch.stage == ProcessingStage.completed)
        .fold<double>(0, (value, batch) => value + batch.weightKg);
    final drying = _repository.processingBatches
        .where((batch) => batch.stage == ProcessingStage.drying)
        .fold<double>(0, (value, batch) => value + batch.weightKg);
    final pendingInspect =
        _repository.moistureLogs.where((log) => log.moisture > 14).length;

    final metrics = [
      (
        title: 'สต็อกพร้อมขาย',
        value: '${(readyToSell / 1000).toStringAsFixed(1)} ตัน',
        caption: 'ผ่านการอบแห้งและตรวจคุณภาพครบ',
        icon: Icons.inventory_2_outlined,
        color: MiddlemanPalette.success,
      ),
      (
        title: 'ระหว่างอบแห้ง',
        value: '${(drying / 1000).toStringAsFixed(1)} ตัน',
        caption: 'คาดว่าจะเสร็จภายใน 12 ชั่วโมง',
        icon: Icons.waves,
        color: MiddlemanPalette.warning,
      ),
      (
        title: 'พื้นที่รวมทั้งหมด',
        value: '${totalCapacity.toStringAsFixed(1)} ตัน',
        caption: 'ใช้ไปแล้ว ${(totalStored / totalCapacity * 100).clamp(0, 100).toStringAsFixed(0)}%',
        icon: Icons.warehouse_outlined,
        color: MiddlemanPalette.info,
      ),
      (
        title: 'ล็อตต้องติดตาม',
        value: '$pendingInspect รายการ',
        caption: 'ความชื้นเกินเกณฑ์ ต้องตรวจซ้ำก่อนโอนเข้าคลัง',
        icon: Icons.fact_check_outlined,
        color: MiddlemanPalette.primary,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 960
            ? 4
            : constraints.maxWidth >= 720
                ? 3
                : constraints.maxWidth >= 520
                    ? 2
                    : 1;
        const spacing = 12.0;
        final width = columns == 1
            ? constraints.maxWidth
            : (constraints.maxWidth - spacing * (columns - 1)) / columns;
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final metric in metrics)
              SizedBox(
                width: width,
                child: MiddlemanSummaryCard(
                  title: metric.title,
                  value: metric.value,
                  caption: metric.caption,
                  icon: metric.icon,
                  color: metric.color,
                ),
              ),
          ],
        );
      },
    );
  }

  List<Widget> _buildStorageGrid(List<InventoryLot> lots) {
    if (lots.isEmpty) {
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
            'ยังไม่มีพื้นที่จัดเก็บในระบบ โปรดเพิ่มข้อมูลด้านล่างเพื่อเริ่มติดตามสต็อก',
            style: TextStyle(color: MiddlemanPalette.textSecondary),
          ),
        ),
      ];
    }

    return [
      for (final lot in lots)
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
                    padding: const EdgeInsets.all(10),
                    child: const Icon(Icons.storage_rounded, color: MiddlemanPalette.primary),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lot.siloName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'ความจุ ${lot.capacityTons.toStringAsFixed(1)} ตัน • ใช้ไป ${lot.fillPercentage.toStringAsFixed(0)}%',
                          style: const TextStyle(
                            fontSize: 12,
                            color: MiddlemanPalette.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: lot.locked,
                    onChanged: (value) =>
                        _repository.updateInventoryLot(lot, locked: value),
                    activeColor: MiddlemanPalette.warning,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              LinearProgressIndicator(
                value: (lot.filledTons / lot.capacityTons).clamp(0, 1),
                backgroundColor: const Color(0xFFE0E6EE),
                color: MiddlemanPalette.primary,
                minHeight: 10,
                borderRadius: BorderRadius.circular(8),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'อุณหภูมิ ${lot.temperatureC.toStringAsFixed(1)}°C • ความชื้น ${lot.humidity.toStringAsFixed(0)}%\nตรวจล่าสุด ${_relativeTime(lot.lastInspection)}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: MiddlemanPalette.textSecondary,
                        height: 1.4,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => _showUpdateDialog(lot),
                    icon: const Icon(Icons.edit_outlined),
                    tooltip: 'อัปเดตข้อมูลคลัง',
                  ),
                ],
              ),
            ],
          ),
        ),
    ];
  }

  Widget _buildNewLotForm() {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _lotNameController,
            decoration: InputDecoration(
              labelText: 'ชื่อพื้นที่จัดเก็บ',
              hintText: 'เช่น Silo #3 หรือ คลังสำรองเหนือ',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
              fillColor: const Color(0xFFF7F9FC),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _capacityController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'ความจุ (ตัน)',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: const Color(0xFFF7F9FC),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _filledController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'ปริมาณปัจจุบัน (ตัน)',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: const Color(0xFFF7F9FC),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _temperatureController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'อุณหภูมิ (°C)',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: const Color(0xFFF7F9FC),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _humidityController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'ความชื้น (%)',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: const Color(0xFFF7F9FC),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: _addInventoryLot,
              style: ElevatedButton.styleFrom(
                backgroundColor: MiddlemanPalette.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.add_circle_outline),
              label: const Text('เพิ่มพื้นที่จัดเก็บ'),
            ),
          ),
        ],
      ),
    );
  }

  void _addInventoryLot() {
    final name = _lotNameController.text.trim();
    final capacity = double.tryParse(_capacityController.text.trim());
    final filled = double.tryParse(_filledController.text.trim());
    final temp = double.tryParse(_temperatureController.text.trim());
    final humidity = double.tryParse(_humidityController.text.trim());

    if (name.isEmpty || capacity == null || filled == null || temp == null || humidity == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('กรอกข้อมูลให้ครบถ้วนก่อนเพิ่มคลังสินค้า')), 
      );
      return;
    }

    _repository.addInventoryLot(
      siloName: name,
      capacityTons: capacity,
      filledTons: filled,
      temperatureC: temp,
      humidity: humidity,
    );

    _lotNameController.clear();
    _capacityController.clear();
    _filledController.clear();
    _temperatureController.text = '26.5';
    _humidityController.text = '60';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('เพิ่ม ${name} เข้าระบบคลังแล้ว')),
    );
  }

  Future<void> _showUpdateDialog(InventoryLot lot) async {
    final fillController = TextEditingController(text: lot.filledTons.toStringAsFixed(1));
    final tempController = TextEditingController(text: lot.temperatureC.toStringAsFixed(1));
    final humidityController = TextEditingController(text: lot.humidity.toStringAsFixed(0));

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('อัปเดต ${lot.siloName}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: fillController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'ปริมาณปัจจุบัน (ตัน)'),
              ),
              TextField(
                controller: tempController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'อุณหภูมิ (°C)'),
              ),
              TextField(
                controller: humidityController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'ความชื้น (%)'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('ยกเลิก'),
            ),
            ElevatedButton(
              onPressed: () {
                final filled = double.tryParse(fillController.text.trim());
                final temp = double.tryParse(tempController.text.trim());
                final humidity = double.tryParse(humidityController.text.trim());
                if (filled == null || temp == null || humidity == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('กรอกข้อมูลตัวเลขให้ถูกต้อง')), 
                  );
                  return;
                }
                _repository.updateInventoryLot(
                  lot,
                  filledTons: filled,
                  temperatureC: temp,
                  humidity: humidity,
                );
                Navigator.of(context).pop();
              },
              child: const Text('บันทึก'),
            ),
          ],
        );
      },
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
