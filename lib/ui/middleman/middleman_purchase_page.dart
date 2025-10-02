import 'package:flutter/material.dart';

import 'middleman_shared_widgets.dart';
import 'middleman_workflow_state.dart';

class MiddlemanPurchasePage extends StatefulWidget {
  const MiddlemanPurchasePage({super.key});

  @override
  State<MiddlemanPurchasePage> createState() => _MiddlemanPurchasePageState();
}

class _MiddlemanPurchasePageState extends State<MiddlemanPurchasePage> {
  final _formKey = GlobalKey<FormState>();
  final _ticketIdController = TextEditingController();
  final _farmerController = TextEditingController();
  final _villageController = TextEditingController();
  final _weightController = TextEditingController();
  final _priceController = TextEditingController(text: '8.40');
  String _grade = 'A';
  FarmerQueueItem? _reservedQueue;

  MiddlemanWorkflowRepository get _repository =>
      MiddlemanWorkflowRepository.instance;

  @override
  void dispose() {
    _ticketIdController.dispose();
    _farmerController.dispose();
    _villageController.dispose();
    _weightController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _repository,
      builder: (context, _) {
        return MiddlemanScreenScaffold(
          title: 'รับซื้อจากเกษตรกร',
          subtitle:
              'สแกนคิวอาร์โค้ดตัดโควต้า ตรวจสอบปริมาณ และออกเอกสารรับซื้อ',
          actionChips: [
            MiddlemanTag(
              label: 'คิวรอ ${_repository.farmerQueue.length} ราย',
              color: MiddlemanPalette.primary,
            ),
            MiddlemanTag(
              label:
                  'รับซื้อวันนี้ ${_repository.totalPurchasedToday.toStringAsFixed(0)} กก.',
              color: MiddlemanPalette.success,
            ),
          ],
          children: [
            _buildScannerCard(context),
            const MiddlemanSection(
              title: 'คิวเกษตรกรที่รอรับซื้อ',
              icon: Icons.people_alt_outlined,
            ),
            ..._buildFarmerQueue(),
            const MiddlemanSection(
              title: 'ตรวจสอบโควต้าและราคาประจำวัน',
              icon: Icons.receipt_long_outlined,
            ),
            _buildQuotaTable(),
          ],
        );
      },
    );
  }

  Widget _buildScannerCard(BuildContext context) {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: MiddlemanPalette.primary.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: const Icon(Icons.qr_code_scanner,
                      color: MiddlemanPalette.primary, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'สแกนคิวอาร์โค้ดเกษตรกร',
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'ใช้กล้องเพื่ออ่านคิวอาร์โค้ดจากแอปเกษตรกรแล้วตัดโควต้าอัตโนมัติ หากสแกนไม่ได้สามารถกรอกรหัสได้ที่แบบฟอร์มด้านล่าง',
                        style:
                            TextStyle(fontSize: 13, color: MiddlemanPalette.textSecondary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _handleScan,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: MiddlemanPalette.primary,
                      side: const BorderSide(color: MiddlemanPalette.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.camera_alt_outlined),
                    label: const Text('สแกนคิวอาร์โค้ด'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _resetForm,
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
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _ticketIdController,
              decoration: InputDecoration(
                labelText: 'เลขที่ใบรับซื้อ',
                hintText: 'ตัวอย่าง: RC-2024-073',
                filled: true,
                fillColor: const Color(0xFFF7F9FC),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              validator: (value) =>
                  value == null || value.isEmpty ? 'กรอกเลขที่ใบรับซื้อ' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _farmerController,
              decoration: InputDecoration(
                labelText: 'ชื่อเกษตรกร/สหกรณ์',
                filled: true,
                fillColor: const Color(0xFFF7F9FC),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              validator: (value) =>
                  value == null || value.isEmpty ? 'กรอกชื่อผู้ขาย' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _villageController,
              decoration: InputDecoration(
                labelText: 'หมู่บ้าน/พื้นที่',
                filled: true,
                fillColor: const Color(0xFFF7F9FC),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _weightController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'น้ำหนัก (กก.)',
                      filled: true,
                      fillColor: const Color(0xFFF7F9FC),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      final parsed = double.tryParse(value ?? '');
                      if (parsed == null || parsed <= 0) {
                        return 'กรอกน้ำหนักที่ถูกต้อง';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _priceController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'ราคาต่อกิโลกรัม',
                      suffixText: 'บาท',
                      filled: true,
                      fillColor: const Color(0xFFF7F9FC),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      final parsed = double.tryParse(value ?? '');
                      if (parsed == null || parsed <= 0) {
                        return 'กรอกราคาที่ถูกต้อง';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _grade,
              decoration: InputDecoration(
                labelText: 'เกรดสินค้า',
                filled: true,
                fillColor: const Color(0xFFF7F9FC),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              items: const [
                DropdownMenuItem(value: 'A', child: Text('เกรด A')), 
                DropdownMenuItem(value: 'B', child: Text('เกรด B')), 
                DropdownMenuItem(value: 'C', child: Text('เกรด C')), 
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() => _grade = value);
                }
              },
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MiddlemanPalette.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _submitForm,
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('ตรวจสอบและสร้างใบรับซื้อ'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildFarmerQueue() {
    if (_repository.farmerQueue.isEmpty) {
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
            'ไม่มีคิวรอในขณะนี้ เมื่อเกษตรกรสแกนคิวอาร์จะปรากฏที่นี่โดยอัตโนมัติ',
            style: TextStyle(color: MiddlemanPalette.textSecondary),
          ),
        ),
      ];
    }

    return [
      for (final farmer in _repository.farmerQueue)
        MiddlemanListTile(
          leadingIcon: Icons.person_outline,
          iconColor: MiddlemanPalette.primary,
          title: farmer.farmerName,
          subtitle:
              'โควต้า ${farmer.quotaId}\nคงเหลือ ${farmer.remainingWeightKg.toStringAsFixed(0)} กก. • ${farmer.village}',
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () => _claimFarmer(farmer),
                style: ElevatedButton.styleFrom(
                  backgroundColor: MiddlemanPalette.primary,
                  minimumSize: const Size(120, 36),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('นำเข้าฟอร์ม'),
              ),
              const SizedBox(height: 6),
              Text(
                'มาตั้งแต่ ${_relativeTime(farmer.arrivalTime)}',
                style: const TextStyle(
                  fontSize: 11,
                  color: MiddlemanPalette.textSecondary,
                ),
              ),
            ],
          ),
        ),
    ];
  }

  Widget _buildQuotaTable() {
    final quotas = [
      _QuotaSummary('โควต้าประจำวัน', '60,000 กก.',
          'ใช้ไปแล้ว ${_repository.totalPurchasedToday.toStringAsFixed(0)} กก.'),
      const _QuotaSummary('ราคารับซื้อเกรด A', '8.40 บาท/กก.', 'ความชื้นไม่เกิน 14%'),
      const _QuotaSummary('ราคารับซื้อเกรด B', '7.10 บาท/กก.', 'ความชื้น 14-17%'),
      const _QuotaSummary('ราคารับซื้อเกรด C', '6.40 บาท/กก.', 'ความชื้นมากกว่า 17%'),
      const _QuotaSummary('กำลังคนประจำด่าน', '5 คน', 'พร้อมให้บริการทุกจุดชั่ง'),
    ];

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
          for (final item in quotas)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      item.title,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(
                    item.value,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: MiddlemanPalette.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    item.detail,
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

  void _handleScan() {
    if (_reservedQueue != null) {
      _repository.enqueueFarmer(_reservedQueue!);
      _reservedQueue = null;
    }
    final farmer = _repository.claimNextFarmer();
    if (farmer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ไม่มีคิวให้สแกนในขณะนี้')),
      );
      return;
    }
    setState(() {
      _reservedQueue = farmer;
      _ticketIdController.text = 'RC-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';
      _farmerController.text = farmer.farmerName;
      _villageController.text = farmer.village;
      _weightController.text = farmer.remainingWeightKg.toStringAsFixed(0);
    });
  }

  void _claimFarmer(FarmerQueueItem farmer) {
    if (_reservedQueue != null) {
      _repository.enqueueFarmer(_reservedQueue!);
    }
    _repository.removeFarmerFromQueue(farmer);
    setState(() {
      _reservedQueue = farmer;
      _ticketIdController.text =
          'RC-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';
      _farmerController.text = farmer.farmerName;
      _villageController.text = farmer.village;
      _weightController.text = farmer.remainingWeightKg.toStringAsFixed(0);
    });
  }

  void _resetForm() {
    if (_reservedQueue != null) {
      _repository.enqueueFarmer(_reservedQueue!);
    }
    setState(() {
      _reservedQueue = null;
      _ticketIdController.clear();
      _farmerController.clear();
      _villageController.clear();
      _weightController.clear();
      _priceController.text = '8.40';
      _grade = 'A';
    });
  }

  void _submitForm() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    final ticketId = _ticketIdController.text.trim();
    final farmerName = _farmerController.text.trim();
    final village = _villageController.text.trim();
    final weight = double.parse(_weightController.text.trim());
    final price = double.parse(_priceController.text.trim());

    _repository.recordPurchase(
      ticketId: ticketId,
      farmerName: farmerName,
      village: village,
      weightKg: weight,
      pricePerKg: price,
      grade: _grade,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('บันทึกใบรับซื้อ $ticketId เรียบร้อย')),
    );
    _reservedQueue = null;
    _resetForm();
  }

  String _relativeTime(DateTime arrival) {
    final diff = DateTime.now().difference(arrival);
    if (diff.inMinutes < 1) return 'เมื่อสักครู่';
    if (diff.inMinutes < 60) {
      return '${diff.inMinutes} นาทีที่แล้ว';
    }
    return '${diff.inHours} ชั่วโมงที่แล้ว';
  }
}

class _QuotaSummary {
  final String title;
  final String value;
  final String detail;

  const _QuotaSummary(this.title, this.value, this.detail);
}
