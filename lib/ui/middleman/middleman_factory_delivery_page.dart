import 'package:flutter/material.dart';

import 'middleman_shared_widgets.dart';
import 'middleman_workflow_state.dart';

class MiddlemanFactoryDeliveryPage extends StatefulWidget {
  const MiddlemanFactoryDeliveryPage({super.key});

  @override
  State<MiddlemanFactoryDeliveryPage> createState() =>
      _MiddlemanFactoryDeliveryPageState();
}

class _MiddlemanFactoryDeliveryPageState
    extends State<MiddlemanFactoryDeliveryPage> {
  final _formKey = GlobalKey<FormState>();
  final _deliveryIdController = TextEditingController();
  final _factoryController = TextEditingController();
  final _truckController = TextEditingController();
  final _weightController = TextEditingController(text: '15000');
  final _ticketController = TextEditingController();
  DateTime _selectedDeparture = DateTime.now().add(const Duration(hours: 2));
  final _searchController = TextEditingController();
  String _searchTerm = '';

  MiddlemanWorkflowRepository get _repository =>
      MiddlemanWorkflowRepository.instance;

  @override
  void dispose() {
    _deliveryIdController.dispose();
    _factoryController.dispose();
    _truckController.dispose();
    _weightController.dispose();
    _ticketController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _repository,
      builder: (context, _) {
        final deliveries = _repository.deliveries;
        final scheduled = deliveries
            .where((delivery) => delivery.status == DeliveryStatus.scheduled)
            .toList();
        final enRoute = deliveries
            .where((delivery) => delivery.status == DeliveryStatus.enRoute)
            .toList();
        final delivered = deliveries
            .where((delivery) => delivery.status == DeliveryStatus.delivered)
            .toList();
        final filteredScheduled = _filterDeliveries(scheduled);
        final filteredEnRoute = _filterDeliveries(enRoute);
        final filteredDelivered = _filterDeliveries(delivered);
        final resultCount = filteredScheduled.length +
            filteredEnRoute.length +
            filteredDelivered.length;

        return MiddlemanScreenScaffold(
          title: 'จัดส่งโรงงาน',
          subtitle:
              'วางแผนรอบรถ ตรวจสอบปลายทาง และเช็กอินด้วยคิวอาร์โค้ดโรงงานเพื่อบันทึกย้อนกลับ',
          actionChips: [
            MiddlemanTag(
              label: 'รอออกเดินทาง ${scheduled.length} เที่ยว',
              color: MiddlemanPalette.info,
            ),
            MiddlemanTag(
              label: 'กำลังเดินทาง ${enRoute.length} เที่ยว',
              color: MiddlemanPalette.warning,
            ),
            MiddlemanTag(
              label: 'ส่งมอบแล้ว ${delivered.length} เที่ยว',
              color: MiddlemanPalette.success,
            ),
          ],
          children: [
            _buildPlanForm(),
            _buildDeliverySearch(resultCount),
            const SizedBox(height: 12),
            const MiddlemanSection(
              title: 'รอออกเดินทาง',
              icon: Icons.route_outlined,
            ),
            ..._buildDeliveryList(filteredScheduled),
            const MiddlemanSection(
              title: 'กำลังเดินทาง',
              icon: Icons.airport_shuttle,
            ),
            ..._buildDeliveryList(filteredEnRoute),
            const MiddlemanSection(
              title: 'ส่งมอบสำเร็จ',
              icon: Icons.verified_user_outlined,
            ),
            ..._buildDeliveryList(filteredDelivered, isCompleted: true),
          ],
        );
      },
    );
  }

  Widget _buildPlanForm() {
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
                Icon(Icons.local_shipping_outlined,
                    color: MiddlemanPalette.success),
                SizedBox(width: 8),
                Text('วางแผนจัดส่งรอบใหม่',
                    style: TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'กำหนดปลายทาง รถบรรทุก และล็อตสินค้าที่จะจัดส่ง พร้อมแนบเลขอ้างอิงจากใบรับซื้อเพื่อให้โรงงานตรวจสอบย้อนกลับได้',
              style: TextStyle(
                  fontSize: 13, color: MiddlemanPalette.textSecondary),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _deliveryIdController,
              decoration: InputDecoration(
                labelText: 'รหัสรอบจัดส่ง',
                hintText: 'เช่น DL-2024-036',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: const Color(0xFFF7F9FC),
              ),
              validator: (value) =>
                  value == null || value.isEmpty ? 'กรอกรหัสรอบจัดส่ง' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _factoryController,
              decoration: InputDecoration(
                labelText: 'ปลายทาง/โรงงาน',
                hintText: 'เช่น โรงงานนครราชสีมา',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: const Color(0xFFF7F9FC),
              ),
              validator: (value) => value == null || value.isEmpty
                  ? 'กรอกชื่อโรงงานปลายทาง'
                  : null,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _truckController,
                    decoration: InputDecoration(
                      labelText: 'ทะเบียนรถบรรทุก',
                      hintText: 'เช่น 82-4495',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: const Color(0xFFF7F9FC),
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'กรอกทะเบียนรถ' : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _weightController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'น้ำหนักรวม (กก.)',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: const Color(0xFFF7F9FC),
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
              ],
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _ticketController,
              decoration: InputDecoration(
                labelText: 'เลขที่ใบรับซื้อที่เกี่ยวข้อง',
                hintText:
                    'คั่นด้วยเครื่องหมายคอมม่า เช่น RC-2024-068,RC-2024-069',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: const Color(0xFFF7F9FC),
              ),
              validator: (value) => value == null || value.isEmpty
                  ? 'ระบุใบรับซื้ออย่างน้อย 1 รายการ'
                  : null,
            ),
            const SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('เวลาออกเดินทาง'),
              subtitle: Text(_formatDateTime(_selectedDeparture)),
              trailing: TextButton(
                onPressed: _pickDateTime,
                child: const Text('เลือกเวลา'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _scheduleDelivery,
                style: ElevatedButton.styleFrom(
                  backgroundColor: MiddlemanPalette.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.playlist_add_check),
                label: const Text('บันทึกแผนจัดส่ง'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliverySearch(int resultCount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MiddlemanSearchField(
          controller: _searchController,
          hintText: 'ค้นหาด้วยรหัสรอบจัดส่ง โรงงาน หรือทะเบียนรถ',
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

  List<DeliverySchedule> _filterDeliveries(List<DeliverySchedule> deliveries) {
    if (_searchTerm.isEmpty) {
      return deliveries;
    }
    final query = _searchTerm.toLowerCase();
    return deliveries.where((delivery) {
      final haystack =
          '${delivery.deliveryId} ${delivery.factoryName} ${delivery.truckId}'
              .toLowerCase();
      return haystack.contains(query);
    }).toList();
  }

  List<Widget> _buildDeliveryList(List<DeliverySchedule> deliveries,
      {bool isCompleted = false}) {
    if (deliveries.isEmpty) {
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
            isCompleted
                ? 'ยังไม่มีรอบที่ส่งมอบแล้วในวันนี้'
                : 'ไม่มีรอบจัดส่งในหมวดนี้',
            style: const TextStyle(color: MiddlemanPalette.textSecondary),
          ),
        ),
      ];
    }

    return [
      for (final delivery in deliveries)
        MiddlemanListTile(
          leadingIcon: Icons.local_shipping,
          iconColor: isCompleted
              ? MiddlemanPalette.success
              : delivery.status == DeliveryStatus.enRoute
                  ? MiddlemanPalette.warning
                  : MiddlemanPalette.info,
          title: '${delivery.deliveryId} • ${delivery.factoryName}',
          subtitle:
              'รถ ${delivery.truckId}\nน้ำหนัก ${delivery.weightKg.toStringAsFixed(0)} กก. • ใบรับซื้อ ${delivery.ticketRefs.join(', ')}\nเวลา ${_formatDateTime(delivery.departureTime)}',
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (isCompleted)
                const MiddlemanTag(
                    label: 'ส่งมอบแล้ว', color: MiddlemanPalette.success)
              else if (delivery.status == DeliveryStatus.scheduled)
                ElevatedButton(
                  onPressed: () => _repository.updateDeliveryStatus(
                      delivery, DeliveryStatus.enRoute),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MiddlemanPalette.warning,
                    minimumSize: const Size(130, 36),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('เริ่มออกเดินทาง'),
                )
              else
                ElevatedButton(
                  onPressed: () => _repository.updateDeliveryStatus(
                      delivery, DeliveryStatus.delivered),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MiddlemanPalette.success,
                    minimumSize: const Size(130, 36),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('เช็กอินส่งมอบ'),
                ),
              const SizedBox(height: 6),
              Text(
                _statusLabel(delivery.status),
                style: const TextStyle(
                  fontSize: 12,
                  color: MiddlemanPalette.textSecondary,
                ),
              ),
              TextButton(
                onPressed: () => _confirmDeleteDelivery(delivery),
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

  Future<void> _confirmDeleteDelivery(DeliverySchedule delivery) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ลบรอบจัดส่ง'),
        content: Text(
            'ยืนยันการลบ ${delivery.deliveryId} ไปยัง ${delivery.factoryName} หรือไม่?'),
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
    final success = _repository.deleteDelivery(delivery.deliveryId);
    if (!success) {
      ScaffoldMessenger.of(mounted as BuildContext).showSnackBar(
        const SnackBar(content: Text('ไม่พบรอบจัดส่งในระบบ')),
      );
      return;
    }
    ScaffoldMessenger.of(mounted as BuildContext).showSnackBar(
      SnackBar(content: Text('ลบรอบจัดส่ง ${delivery.deliveryId} แล้ว')),
    );
    setState(() {});
  }

  Future<void> _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDeparture,
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (date == null) return;
    final time = await showTimePicker(
      context: mounted as BuildContext,
      initialTime: TimeOfDay.fromDateTime(_selectedDeparture),
    );
    if (time == null) return;
    setState(() {
      _selectedDeparture = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  void _scheduleDelivery() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    final id = _deliveryIdController.text.trim();
    final factory = _factoryController.text.trim();
    final truck = _truckController.text.trim();
    final weight = double.parse(_weightController.text.trim());
    final tickets = _ticketController.text
        .split(',')
        .map((ref) => ref.trim())
        .where((ref) => ref.isNotEmpty)
        .toList();

    if (tickets.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ระบุเลขใบรับซื้ออย่างน้อย 1 รายการ')),
      );
      return;
    }

    FocusScope.of(context).unfocus();
    final result = _repository.scheduleDelivery(
      deliveryId: id,
      factoryName: factory,
      truckId: truck,
      departureTime: _selectedDeparture,
      weightKg: weight,
      ticketRefs: tickets,
    );

    if (result == WorkflowMutationResult.ignored) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('ไม่สามารถบันทึกแผนจัดส่งได้ กรุณาตรวจสอบข้อมูล')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          result == WorkflowMutationResult.created
              ? 'บันทึกแผนจัดส่ง $id แล้ว'
              : 'อัปเดตแผนจัดส่ง $id แล้ว',
        ),
      ),
    );
    _formKey.currentState?.reset();
    _deliveryIdController.clear();
    _factoryController.clear();
    _truckController.clear();
    _weightController.text = '15000';
    _ticketController.clear();
    setState(() {
      _selectedDeparture = DateTime.now().add(const Duration(hours: 2));
    });
  }

  String _formatDateTime(DateTime time) {
    final date =
        '${time.day.toString().padLeft(2, '0')}/${time.month.toString().padLeft(2, '0')}';
    final hour =
        '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    return '$date เวลา $hour น.';
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
}
