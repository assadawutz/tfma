import 'dart:collection';
import 'package:flutter/material.dart';

enum ProcessingStage {
  receiving,
  drying,
  grading,
  packaging,
  completed,
}

enum DeliveryStatus { scheduled, enRoute, delivered }

enum TradeType { purchase, sale }

class FarmerQueueItem {
  FarmerQueueItem({
    required this.farmerName,
    required this.village,
    required this.quotaId,
    required this.remainingWeightKg,
    required this.arrivalTime,
  });

  final String farmerName;
  final String village;
  final String quotaId;
  final double remainingWeightKg;
  final DateTime arrivalTime;
}

class PurchaseTicket {
  PurchaseTicket({
    required this.ticketId,
    required this.farmerName,
    required this.village,
    required this.weightKg,
    required this.pricePerKg,
    required this.grade,
    required this.timestamp,
  });

  final String ticketId;
  final String farmerName;
  final String village;
  final double weightKg;
  final double pricePerKg;
  final String grade;
  final DateTime timestamp;
  double? moisturePercentage;

  double get totalPrice => weightKg * pricePerKg;
}

class MoistureLog {
  MoistureLog({
    required this.ticketId,
    required this.moisture,
    required this.inspector,
    required this.note,
    required this.timestamp,
  });

  final String ticketId;
  final double moisture;
  final String inspector;
  final String note;
  final DateTime timestamp;
}

class ProcessingBatch {
  ProcessingBatch({
    required this.batchId,
    required this.originTicketId,
    required this.weightKg,
    required this.location,
    required this.stage,
    required this.updatedAt,
  });

  final String batchId;
  final String originTicketId;
  final double weightKg;
  String location;
  ProcessingStage stage;
  DateTime updatedAt;
}

class DeliverySchedule {
  DeliverySchedule({
    required this.deliveryId,
    required this.factoryName,
    required this.truckId,
    required this.departureTime,
    required this.weightKg,
    required this.ticketRefs,
    required this.status,
  });

  final String deliveryId;
  final String factoryName;
  final String truckId;
  DateTime departureTime;
  final double weightKg;
  final List<String> ticketRefs;
  DeliveryStatus status;

  bool get isToday {
    final now = DateTime.now();
    return departureTime.year == now.year &&
        departureTime.month == now.month &&
        departureTime.day == now.day;
  }
}

class BurnAlert {
  BurnAlert({
    required this.location,
    required this.detectedAt,
    required this.severity,
    required this.description,
    this.acknowledged = false,
  });

  final String location;
  final DateTime detectedAt;
  final String severity;
  final String description;
  bool acknowledged;
}

class TradeRecord {
  TradeRecord({
    required this.type,
    required this.referenceId,
    required this.counterparty,
    required this.timestamp,
    required this.weightKg,
    required this.amount,
    this.reconciled = false,
  });

  final TradeType type;
  final String referenceId;
  final String counterparty;
  final DateTime timestamp;
  final double weightKg;
  final double amount;
  bool reconciled;
}

class InventoryLot {
  InventoryLot({
    required this.siloName,
    required this.capacityTons,
    required this.filledTons,
    required this.temperatureC,
    required this.humidity,
    required this.lastInspection,
    this.locked = false,
  });

  final String siloName;
  final double capacityTons;
  double filledTons;
  double temperatureC;
  double humidity;
  DateTime lastInspection;
  bool locked;

  double get fillPercentage => (filledTons / capacityTons).clamp(0, 1) * 100;
}

class FinanceTransaction {
  FinanceTransaction({
    required this.transactionId,
    required this.description,
    required this.amount,
    required this.timestamp,
    required this.counterparty,
    required this.isExpense,
    this.settled = false,
  });

  final String transactionId;
  final String description;
  final double amount;
  final DateTime timestamp;
  final String counterparty;
  final bool isExpense;
  bool settled;
}

class WorkflowActivity {
  WorkflowActivity({
    required this.title,
    required this.detail,
    required this.icon,
    required this.color,
    required this.timestamp,
  });

  final String title;
  final String detail;
  final IconData icon;
  final Color color;
  final DateTime timestamp;
}

class MiddlemanWorkflowRepository extends ChangeNotifier {
  MiddlemanWorkflowRepository._internal() {
    _seedData();
  }

  static final MiddlemanWorkflowRepository instance =
      MiddlemanWorkflowRepository._internal();

  final List<FarmerQueueItem> _farmerQueue = [];
  final List<PurchaseTicket> _purchases = [];
  final List<MoistureLog> _moistureLogs = [];
  final List<ProcessingBatch> _processingBatches = [];
  final List<DeliverySchedule> _deliveries = [];
  final List<BurnAlert> _burnAlerts = [];
  final List<TradeRecord> _tradeRecords = [];
  final List<InventoryLot> _inventoryLots = [];
  final List<FinanceTransaction> _financeTransactions = [];
  final List<WorkflowActivity> _activityFeed = [];

  UnmodifiableListView<FarmerQueueItem> get farmerQueue =>
      UnmodifiableListView(_farmerQueue);
  UnmodifiableListView<PurchaseTicket> get purchases =>
      UnmodifiableListView(_purchases);
  UnmodifiableListView<MoistureLog> get moistureLogs =>
      UnmodifiableListView(_moistureLogs);
  UnmodifiableListView<ProcessingBatch> get processingBatches =>
      UnmodifiableListView(_processingBatches);
  UnmodifiableListView<DeliverySchedule> get deliveries =>
      UnmodifiableListView(_deliveries);
  UnmodifiableListView<BurnAlert> get burnAlerts =>
      UnmodifiableListView(_burnAlerts);
  UnmodifiableListView<TradeRecord> get tradeRecords =>
      UnmodifiableListView(_tradeRecords);
  UnmodifiableListView<InventoryLot> get inventoryLots =>
      UnmodifiableListView(_inventoryLots);
  UnmodifiableListView<FinanceTransaction> get financeTransactions =>
      UnmodifiableListView(_financeTransactions);
  UnmodifiableListView<WorkflowActivity> get activityFeed =>
      UnmodifiableListView(_activityFeed);

  double get totalPurchasedToday {
    final today = DateTime.now();
    return _purchases
        .where((p) => _isSameDay(p.timestamp, today))
        .fold(0.0, (sum, p) => sum + p.weightKg);
  }

  double? get averageMoisture {
    if (_moistureLogs.isEmpty) return null;
    final today = DateTime.now();
    final todayMeasurements =
        _moistureLogs.where((log) => _isSameDay(log.timestamp, today)).toList();
    if (todayMeasurements.isEmpty) return null;
    final total =
        todayMeasurements.fold<double>(0, (value, log) => value + log.moisture);
    return total / todayMeasurements.length;
  }

  double get processingInProgressWeight => _processingBatches
      .where((batch) => batch.stage != ProcessingStage.completed)
      .fold(0.0, (sum, batch) => sum + batch.weightKg);

  double get averageStorageUsage {
    if (_inventoryLots.isEmpty) return 0;
    final percentages = _inventoryLots
        .map((lot) => lot.fillPercentage)
        .fold<double>(0, (value, element) => value + element);
    return percentages / _inventoryLots.length;
  }

  int get completedDeliveriesToday => _deliveries
      .where((delivery) =>
          delivery.status == DeliveryStatus.delivered && delivery.isToday)
      .length;

  double get netBalance {
    final income = _financeTransactions
        .where((tx) => !tx.isExpense)
        .fold<double>(0, (value, tx) => value + tx.amount);
    final expense = _financeTransactions
        .where((tx) => tx.isExpense)
        .fold<double>(0, (value, tx) => value + tx.amount);
    return income - expense;
  }

  void recordPurchase({
    required String ticketId,
    required String farmerName,
    required String village,
    required double weightKg,
    required double pricePerKg,
    required String grade,
  }) {
    final now = DateTime.now();
    final ticket = PurchaseTicket(
      ticketId: ticketId,
      farmerName: farmerName,
      village: village,
      weightKg: weightKg,
      pricePerKg: pricePerKg,
      grade: grade,
      timestamp: now,
    );
    _purchases.insert(0, ticket);
    _processingBatches.insert(
      0,
      ProcessingBatch(
        batchId: 'PR-${ticketId.substring(ticketId.length - 3)}',
        originTicketId: ticketId,
        weightKg: weightKg,
        location: 'ลานตากหลัก',
        stage: ProcessingStage.receiving,
        updatedAt: now,
      ),
    );
    _tradeRecords.insert(
      0,
      TradeRecord(
        type: TradeType.purchase,
        referenceId: ticketId,
        counterparty: farmerName,
        timestamp: now,
        weightKg: weightKg,
        amount: ticket.totalPrice,
      ),
    );
    _pushActivity(
      WorkflowActivity(
        title: 'รับซื้อ ${ticket.farmerName}',
        detail:
            'น้ำหนัก ${ticket.weightKg.toStringAsFixed(0)} กก. ที่ ${ticket.pricePerKg.toStringAsFixed(2)} บาท/กก.',
        icon: Icons.qr_code_scanner,
        color: Colors.deepOrange,
        timestamp: now,
      ),
    );
    notifyListeners();
  }

  FarmerQueueItem? claimNextFarmer() {
    if (_farmerQueue.isEmpty) return null;
    final item = _farmerQueue.removeAt(0);
    notifyListeners();
    return item;
  }

  void removeFarmerFromQueue(FarmerQueueItem item) {
    _farmerQueue.remove(item);
    notifyListeners();
  }

  void returnFarmerToQueue(FarmerQueueItem item) {
    _farmerQueue.insert(0, item);
    notifyListeners();
  }

  void enqueueFarmer(FarmerQueueItem item) {
    _farmerQueue.add(item);
    notifyListeners();
  }

  void recordMoisture({
    required String ticketId,
    required double moisture,
    required String inspector,
    required String note,
  }) {
    final now = DateTime.now();
    final log = MoistureLog(
      ticketId: ticketId,
      moisture: moisture,
      inspector: inspector,
      note: note,
      timestamp: now,
    );
    _moistureLogs.insert(0, log);

    for (final ticket in _purchases) {
      if (ticket.ticketId == ticketId) {
        ticket.moisturePercentage = moisture;
        break;
      }
    }

    for (final batch in _processingBatches) {
      if (batch.originTicketId == ticketId) {
        batch.stage = moisture <= 14
            ? ProcessingStage.grading
            : ProcessingStage.drying;
        batch.updatedAt = now;
      }
    }

    _pushActivity(
      WorkflowActivity(
        title: 'บันทึกความชื้น $ticketId',
        detail: 'ค่าความชื้น ${moisture.toStringAsFixed(1)}% โดย $inspector',
        icon: Icons.water_drop,
        color: Colors.blueAccent,
        timestamp: now,
      ),
    );
    notifyListeners();
  }

  void advanceProcessingStage(ProcessingBatch batch) {
    switch (batch.stage) {
      case ProcessingStage.receiving:
        batch.stage = ProcessingStage.drying;
        break;
      case ProcessingStage.drying:
        batch.stage = ProcessingStage.grading;
        break;
      case ProcessingStage.grading:
        batch.stage = ProcessingStage.packaging;
        break;
      case ProcessingStage.packaging:
        batch.stage = ProcessingStage.completed;
        break;
      case ProcessingStage.completed:
        return;
    }
    batch.updatedAt = DateTime.now();
    _pushActivity(
      WorkflowActivity(
        title: 'อัปเดตสถานะแปรรูป ${batch.batchId}',
        detail: 'ขั้นตอนปัจจุบัน: ${batch.stage.name}',
        icon: Icons.settings,
        color: Colors.orange,
        timestamp: batch.updatedAt,
      ),
    );
    notifyListeners();
  }

  void updateProcessingBatch(ProcessingBatch batch,
      {ProcessingStage? stage, String? location}) {
    if (stage != null) {
      batch.stage = stage;
    }
    if (location != null) {
      batch.location = location;
    }
    batch.updatedAt = DateTime.now();
    notifyListeners();
  }

  void scheduleDelivery({
    required String deliveryId,
    required String factoryName,
    required String truckId,
    required DateTime departureTime,
    required double weightKg,
    required List<String> ticketRefs,
  }) {
    final schedule = DeliverySchedule(
      deliveryId: deliveryId,
      factoryName: factoryName,
      truckId: truckId,
      departureTime: departureTime,
      weightKg: weightKg,
      ticketRefs: ticketRefs,
      status: DeliveryStatus.scheduled,
    );
    _deliveries.insert(0, schedule);
    _pushActivity(
      WorkflowActivity(
        title: 'วางแผนจัดส่ง $deliveryId',
        detail: 'รถ $truckId ไปยัง $factoryName น้ำหนัก ${weightKg.toStringAsFixed(0)} กก.',
        icon: Icons.local_shipping,
        color: Colors.green,
        timestamp: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  void updateDeliveryStatus(DeliverySchedule delivery, DeliveryStatus status) {
    delivery.status = status;
    if (status == DeliveryStatus.delivered) {
      final now = DateTime.now();
      delivery.departureTime = now;
      _tradeRecords.insert(
        0,
        TradeRecord(
          type: TradeType.sale,
          referenceId: delivery.deliveryId,
          counterparty: delivery.factoryName,
          timestamp: now,
          weightKg: delivery.weightKg,
          amount: delivery.weightKg * 9.10,
        ),
      );
      _pushActivity(
        WorkflowActivity(
          title: 'ส่งมอบสำเร็จ ${delivery.deliveryId}',
          detail: 'โรงงาน ${delivery.factoryName} รับมอบเรียบร้อย',
          icon: Icons.check_circle,
          color: Colors.green,
          timestamp: now,
        ),
      );
    }
    notifyListeners();
  }

  void acknowledgeAlert(BurnAlert alert, bool acknowledged) {
    alert.acknowledged = acknowledged;
    notifyListeners();
  }

  void addManualAlert({
    required String location,
    required String severity,
    required String description,
  }) {
    final alert = BurnAlert(
      location: location,
      detectedAt: DateTime.now(),
      severity: severity,
      description: description,
    );
    _burnAlerts.insert(0, alert);
    _pushActivity(
      WorkflowActivity(
        title: 'แจ้งเตือนการเผาใหม่',
        detail: '$location • ระดับ$severity',
        icon: Icons.warning,
        color: Colors.deepOrangeAccent,
        timestamp: alert.detectedAt,
      ),
    );
    notifyListeners();
  }

  void addInventoryLot({
    required String siloName,
    required double capacityTons,
    required double filledTons,
    required double temperatureC,
    required double humidity,
  }) {
    final lot = InventoryLot(
      siloName: siloName,
      capacityTons: capacityTons,
      filledTons: filledTons,
      temperatureC: temperatureC,
      humidity: humidity,
      lastInspection: DateTime.now(),
    );
    _inventoryLots.insert(0, lot);
    notifyListeners();
  }

  void updateInventoryLot(InventoryLot lot,
      {double? filledTons, double? temperatureC, double? humidity, bool? locked}) {
    if (filledTons != null) {
      lot.filledTons = filledTons;
    }
    if (temperatureC != null) {
      lot.temperatureC = temperatureC;
    }
    if (humidity != null) {
      lot.humidity = humidity;
    }
    if (locked != null) {
      lot.locked = locked;
    }
    lot.lastInspection = DateTime.now();
    notifyListeners();
  }

  void recordFinanceTransaction({
    required String transactionId,
    required String description,
    required double amount,
    required String counterparty,
    required bool isExpense,
  }) {
    final tx = FinanceTransaction(
      transactionId: transactionId,
      description: description,
      amount: amount,
      timestamp: DateTime.now(),
      counterparty: counterparty,
      isExpense: isExpense,
    );
    _financeTransactions.insert(0, tx);
    _pushActivity(
      WorkflowActivity(
        title: isExpense
            ? 'จ่ายเงิน $counterparty'
            : 'รับเงินจาก $counterparty',
        detail: '${amount.toStringAsFixed(2)} บาท - $description',
        icon: isExpense ? Icons.payments : Icons.account_balance_wallet,
        color: isExpense ? Colors.redAccent : Colors.teal,
        timestamp: tx.timestamp,
      ),
    );
    notifyListeners();
  }

  void toggleFinanceSettlement(FinanceTransaction tx, bool settled) {
    tx.settled = settled;
    notifyListeners();
  }

  void toggleTradeReconciled(TradeRecord trade, bool reconciled) {
    trade.reconciled = reconciled;
    notifyListeners();
  }

  void logCustomActivity(WorkflowActivity activity) {
    _pushActivity(activity);
    notifyListeners();
  }

  void _pushActivity(WorkflowActivity activity) {
    _activityFeed.insert(0, activity);
    if (_activityFeed.length > 50) {
      _activityFeed.removeLast();
    }
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  void _seedData() {
    _farmerQueue
      ..addAll([
        FarmerQueueItem(
          farmerName: 'สหกรณ์บ้านหนองโน',
          village: 'หมู่ 8 ตำบลโนนแดง',
          quotaId: '57-000341-01',
          remainingWeightKg: 6500,
          arrivalTime: DateTime.now().subtract(const Duration(minutes: 18)),
        ),
        FarmerQueueItem(
          farmerName: 'คุณสมศรี ทองดี',
          village: 'หมู่ 2 ตำบลหนองสองห้อง',
          quotaId: '57-000342-02',
          remainingWeightKg: 3200,
          arrivalTime: DateTime.now().subtract(const Duration(minutes: 10)),
        ),
        FarmerQueueItem(
          farmerName: 'กลุ่มวิสาหกิจบ้านโคก',
          village: 'หมู่ 11 ตำบลคอนฉิม',
          quotaId: '57-000343-03',
          remainingWeightKg: 8900,
          arrivalTime: DateTime.now().subtract(const Duration(minutes: 5)),
        ),
      ]);

    final now = DateTime.now();
    final purchase = PurchaseTicket(
      ticketId: 'RC-2024-068',
      farmerName: 'สหกรณ์บ้านหนองโน',
      village: 'หมู่ 8 ตำบลโนนแดง',
      weightKg: 8200,
      pricePerKg: 8.4,
      grade: 'A',
      timestamp: now.subtract(const Duration(hours: 3)),
    )..moisturePercentage = 13.4;
    final purchase2 = PurchaseTicket(
      ticketId: 'RC-2024-067',
      farmerName: 'คุณสมศรี ทองดี',
      village: 'หมู่ 2 ตำบลหนองสองห้อง',
      weightKg: 5900,
      pricePerKg: 7.1,
      grade: 'B',
      timestamp: now.subtract(const Duration(hours: 5)),
    )..moisturePercentage = 12.9;
    _purchases.addAll([purchase, purchase2]);

    _moistureLogs.addAll([
      MoistureLog(
        ticketId: purchase.ticketId,
        moisture: 13.4,
        inspector: 'จิตติพล',
        note: 'อบแล้วพร้อมส่งโรงงาน',
        timestamp: now.subtract(const Duration(hours: 2, minutes: 30)),
      ),
      MoistureLog(
        ticketId: purchase2.ticketId,
        moisture: 12.9,
        inspector: 'นิภา',
        note: 'เกรด A พร้อมส่งรอบเย็น',
        timestamp: now.subtract(const Duration(hours: 3, minutes: 45)),
      ),
    ]);

    _processingBatches.addAll([
      ProcessingBatch(
        batchId: 'PR-068',
        originTicketId: purchase.ticketId,
        weightKg: 8200,
        location: 'ลานตากหลัก',
        stage: ProcessingStage.packaging,
        updatedAt: now.subtract(const Duration(hours: 1, minutes: 10)),
      ),
      ProcessingBatch(
        batchId: 'PR-067',
        originTicketId: purchase2.ticketId,
        weightKg: 5900,
        location: 'โรงเรือนอบ #2',
        stage: ProcessingStage.drying,
        updatedAt: now.subtract(const Duration(hours: 2)),
      ),
    ]);

    _deliveries.addAll([
      DeliverySchedule(
        deliveryId: 'DL-2024-034',
        factoryName: 'โรงงานชัยภูมิ',
        truckId: '82-4495',
        departureTime: now.subtract(const Duration(hours: 1)),
        weightKg: 18500,
        ticketRefs: [purchase.ticketId],
        status: DeliveryStatus.delivered,
      ),
      DeliverySchedule(
        deliveryId: 'DL-2024-035',
        factoryName: 'โรงงานขอนแก่น',
        truckId: '83-1120',
        departureTime: now.add(const Duration(hours: 4)),
        weightKg: 16000,
        ticketRefs: [purchase2.ticketId],
        status: DeliveryStatus.scheduled,
      ),
    ]);

    _burnAlerts.addAll([
      BurnAlert(
        location: 'ต.หนองสองห้อง อ.แก้งคร้อ',
        detectedAt: now.subtract(const Duration(minutes: 25)),
        severity: 'สูง',
        description: 'พบควันและความร้อนผิดปกติจากภาพถ่ายดาวเทียม',
      ),
      BurnAlert(
        location: 'ต.โนนแดง อ.เมือง',
        detectedAt: now.subtract(const Duration(hours: 2)),
        severity: 'กลาง',
        description: 'มีการจุดไฟล้อมพื้นที่ แนะนำแจ้งเตือนเกษตรกร',
      ),
    ]);

    _tradeRecords.addAll([
      TradeRecord(
        type: TradeType.sale,
        referenceId: 'DL-2024-034',
        counterparty: 'โรงงานชัยภูมิ',
        timestamp: now.subtract(const Duration(hours: 1)),
        weightKg: 18500,
        amount: 168250,
      ),
      TradeRecord(
        type: TradeType.purchase,
        referenceId: purchase.ticketId,
        counterparty: purchase.farmerName,
        timestamp: purchase.timestamp,
        weightKg: purchase.weightKg,
        amount: purchase.totalPrice,
      ),
      TradeRecord(
        type: TradeType.purchase,
        referenceId: purchase2.ticketId,
        counterparty: purchase2.farmerName,
        timestamp: purchase2.timestamp,
        weightKg: purchase2.weightKg,
        amount: purchase2.totalPrice,
      ),
    ]);

    _inventoryLots.addAll([
      InventoryLot(
        siloName: 'Silo #1',
        capacityTons: 60,
        filledTons: 52,
        temperatureC: 28.4,
        humidity: 62,
        lastInspection: now.subtract(const Duration(hours: 2)),
        locked: true,
      ),
      InventoryLot(
        siloName: 'Silo #2',
        capacityTons: 55,
        filledTons: 36,
        temperatureC: 27.0,
        humidity: 58,
        lastInspection: now.subtract(const Duration(hours: 4)),
      ),
      InventoryLot(
        siloName: 'คลังสำรอง',
        capacityTons: 45,
        filledTons: 12,
        temperatureC: 26.5,
        humidity: 55,
        lastInspection: now.subtract(const Duration(hours: 5)),
      ),
    ]);

    _financeTransactions.addAll([
      FinanceTransaction(
        transactionId: 'FIN-1021',
        description: 'ชำระเงินรับซื้อ RC-2024-068',
        amount: purchase.totalPrice,
        timestamp: purchase.timestamp,
        counterparty: purchase.farmerName,
        isExpense: true,
        settled: true,
      ),
      FinanceTransaction(
        transactionId: 'FIN-1022',
        description: 'ชำระเงินรับซื้อ RC-2024-067',
        amount: purchase2.totalPrice,
        timestamp: purchase2.timestamp,
        counterparty: purchase2.farmerName,
        isExpense: true,
      ),
      FinanceTransaction(
        transactionId: 'FIN-2024-15',
        description: 'รับเงินมัดจำจากโรงงานชัยภูมิ',
        amount: 85000,
        timestamp: now.subtract(const Duration(hours: 2)),
        counterparty: 'โรงงานชัยภูมิ',
        isExpense: false,
      ),
    ]);

    _activityFeed.addAll([
      WorkflowActivity(
        title: 'จัดส่งเที่ยวที่ 4 สำเร็จ',
        detail: 'รถบรรทุกทะเบียน 82-4495 ถึงโรงงานชัยภูมิ เวลา 15:20 น.',
        icon: Icons.check_circle,
        color: Colors.green,
        timestamp: now.subtract(const Duration(hours: 1)),
      ),
      WorkflowActivity(
        title: 'บันทึกความชื้นแปลง 7',
        detail: 'ความชื้น 13.5% โดยเครื่องวัด Silo #2',
        icon: Icons.water_drop,
        color: Colors.blueAccent,
        timestamp: now.subtract(const Duration(hours: 2)),
      ),
      WorkflowActivity(
        title: 'ย้ายล็อต 230510-C เข้าคลัง',
        detail: 'Silo #2 ปรับสมดุลเหลือความจุ 68%',
        icon: Icons.inventory_2,
        color: Colors.indigo,
        timestamp: now.subtract(const Duration(hours: 3)),
      ),
    ]);
  }
}

extension TradeTypeLabel on TradeType {
  String get label {
    switch (this) {
      case TradeType.purchase:
        return 'รับซื้อ';
      case TradeType.sale:
        return 'ขาย';
    }
  }

  Color get color {
    switch (this) {
      case TradeType.purchase:
        return Colors.deepOrange;
      case TradeType.sale:
        return Colors.green;
    }
  }
}
