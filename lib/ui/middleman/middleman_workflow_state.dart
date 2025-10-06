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

enum WorkflowMutationResult { created, updated, ignored }

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
    String? id,
  }) : id = id ??
            '${detectedAt.microsecondsSinceEpoch}_${location.hashCode.abs()}';

  final String location;
  final DateTime detectedAt;
  final String severity;
  final String description;
  bool acknowledged;
  final String id;
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

  double get fillPercentage {
    if (capacityTons <= 0) {
      return 0;
    }
    var ratio = filledTons / capacityTons;
    if (!ratio.isFinite) {
      ratio = 0;
    }
    if (ratio < 0) {
      ratio = 0;
    } else if (ratio > 1) {
      ratio = 1;
    }
    return ratio * 100;
  }
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
    this.referenceId,
  });

  final String title;
  final String detail;
  final IconData icon;
  final Color color;
  final DateTime timestamp;
  final String? referenceId;
}

class WorkflowInsight {
  WorkflowInsight({
    required this.title,
    required this.value,
    required this.trendLabel,
    required this.description,
    required this.icon,
    required this.color,
    this.progress,
  });

  final String title;
  final String value;
  final String trendLabel;
  final String description;
  final IconData icon;
  final Color color;
  final double? progress;
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

  UnmodifiableListView<PurchaseTicket> get highMoistureTickets {
    final flagged = _purchases
        .where((ticket) => (ticket.moisturePercentage ?? 0) > 14)
        .toList()
      ..sort((a, b) =>
          (b.moisturePercentage ?? 0).compareTo(a.moisturePercentage ?? 0));
    return UnmodifiableListView(flagged);
  }

  UnmodifiableListView<DeliverySchedule> get overdueDeliveries {
    final now = DateTime.now();
    final flagged = _deliveries
        .where((delivery) =>
            delivery.status != DeliveryStatus.delivered &&
            delivery.departureTime.isBefore(now))
        .toList()
      ..sort((a, b) => a.departureTime.compareTo(b.departureTime));
    return UnmodifiableListView(flagged);
  }

  UnmodifiableListView<FinanceTransaction> get pendingExpenseTransactions {
    final pending = _financeTransactions
        .where((transaction) => transaction.isExpense && !transaction.settled)
        .toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return UnmodifiableListView(pending);
  }

  UnmodifiableListView<FinanceTransaction> get pendingReceivableTransactions {
    final pending = _financeTransactions
        .where((transaction) => !transaction.isExpense && !transaction.settled)
        .toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return UnmodifiableListView(pending);
  }

  List<WorkflowInsight> get workflowInsights {
    const dailyQuotaKg = 60000.0;
    final purchasedToday = totalPurchasedToday;
    final quotaUsage = dailyQuotaKg <= 0
        ? 0.0
        : (purchasedToday / dailyQuotaKg).clamp(0.0, 1.0);
    final highMoistureCount = highMoistureTickets.length;
    final average = averageMoisture;
    final enRoute = _deliveries
        .where((delivery) => delivery.status == DeliveryStatus.enRoute)
        .length;
    final scheduled = _deliveries
        .where((delivery) => delivery.status == DeliveryStatus.scheduled)
        .length;
    final overdueCount = overdueDeliveries.length;
    final completedToday = completedDeliveriesToday;
    final totalDeliveries = _deliveries.length;

    final totalCapacityTons = _inventoryLots.fold<double>(
        0, (value, lot) => value + lot.capacityTons);
    final totalFilledTons =
        _inventoryLots.fold<double>(0, (value, lot) => value + lot.filledTons);
    final storageUtilization = totalCapacityTons <= 0
        ? 0.0
        : (totalFilledTons / totalCapacityTons).clamp(0.0, 1.0);

    final pendingExpenseAmount = pendingExpenseTransactions.fold<double>(
        0, (value, tx) => value + tx.amount);
    final pendingReceivableAmount = pendingReceivableTransactions.fold<double>(
        0, (value, tx) => value + tx.amount);
    final liquidityGap = pendingReceivableAmount - pendingExpenseAmount;

    String _formatNumber(double value, {String unit = 'กก.'}) {
      if (unit == 'กก.' && value >= 1000) {
        return '${(value / 1000).toStringAsFixed(1)} ตัน';
      }
      if (value >= 1000000) {
        return '${(value / 1000000).toStringAsFixed(2)} ลบ.';
      }
      if (value >= 1000) {
        return '${(value / 1000).toStringAsFixed(1)} พัน$unit';
      }
      return '${value.toStringAsFixed(0)} $unit';
    }

    String _formatCurrency(double value) {
      if (value >= 1000000) {
        return '฿${(value / 1000000).toStringAsFixed(2)} ลบ.';
      }
      if (value >= 1000) {
        return '฿${(value / 1000).toStringAsFixed(1)} พัน';
      }
      return '฿${value.toStringAsFixed(0)}';
    }

    final remainingQuota =
        (dailyQuotaKg - purchasedToday).clamp(0, dailyQuotaKg).toDouble();
    final availableStorageTons = (totalCapacityTons - totalFilledTons)
        .clamp(0, totalCapacityTons)
        .toDouble();

    return [
      WorkflowInsight(
        title: 'การใช้โควต้ารับซื้อวันนี้',
        value: '${(quotaUsage * 100).toStringAsFixed(0)}%',
        trendLabel: 'รับซื้อแล้ว ${_formatNumber(purchasedToday)}',
        description: quotaUsage >= 0.9
            ? 'โควต้ากำลังเต็ม ควรประสานโรงงานเพื่อเปิดรอบรับเพิ่ม'
            : 'ยังเหลือ ${_formatNumber(remainingQuota)} สำหรับการรับซื้อวันนี้',
        icon: Icons.speed,
        color: Colors.deepOrangeAccent,
        progress: quotaUsage,
      ),
      WorkflowInsight(
        title: 'คุณภาพค่าความชื้น',
        value: average != null
            ? '${average.toStringAsFixed(1)}%'
            : 'ยังไม่มีข้อมูล',
        trendLabel: highMoistureCount > 0
            ? 'พบความชื้นเกิน 14% $highMoistureCount ล็อต'
            : 'ทุกล็อตอยู่ในเกณฑ์มาตรฐาน',
        description: highMoistureCount > 0
            ? 'เร่งอบแห้งล็อตที่มีความชื้นสูงก่อนจัดส่ง'
            : 'ค่าเฉลี่ยพร้อมสำหรับการส่งต่อให้โรงงาน',
        icon: Icons.water_drop,
        color: highMoistureCount > 0 ? Colors.orangeAccent : Colors.teal,
        progress: average != null ? (average / 14).clamp(0.0, 1.0) : null,
      ),
      WorkflowInsight(
        title: 'สถานะการจัดส่ง',
        value: overdueCount > 0
            ? 'ล่าช้า $overdueCount เที่ยว'
            : '${enRoute + scheduled} เที่ยวอยู่ระหว่างทาง',
        trendLabel: 'สำเร็จแล้ววันนี้ $completedToday เที่ยว',
        description: overdueCount > 0
            ? 'ตรวจสอบรอบรถที่เกินกำหนดและอัปเดตสถานะให้โรงงานรับทราบ'
            : 'ทุกการจัดส่งยังอยู่ตามแผนเวลา',
        icon: Icons.local_shipping,
        color: overdueCount > 0 ? Colors.redAccent : Colors.green,
        progress: totalDeliveries == 0
            ? null
            : (completedToday / totalDeliveries).clamp(0.0, 1.0),
      ),
      WorkflowInsight(
        title: 'สต็อกคลังสินค้า',
        value: '${(storageUtilization * 100).toStringAsFixed(0)}%',
        trendLabel: 'พร้อมขาย ${_formatNumber(totalFilledTons * 1000)}',
        description: storageUtilization >= 0.85
            ? 'พื้นที่เก็บใกล้เต็ม ควรเร่งกระจายล็อตออกสู่โรงงาน'
            : 'ยังเหลือพื้นที่ว่าง ${availableStorageTons.toStringAsFixed(1)} ตัน สำหรับรับเข้า',
        icon: Icons.inventory_2,
        color: storageUtilization >= 0.85
            ? Colors.deepOrange
            : Colors.lightBlueAccent,
        progress: storageUtilization,
      ),
      WorkflowInsight(
        title: 'สถานะการเงิน',
        value: 'ค้างจ่าย ${_formatCurrency(pendingExpenseAmount)}',
        trendLabel: pendingReceivableAmount > 0
            ? 'รอรับเงิน ${_formatCurrency(pendingReceivableAmount)}'
            : 'ไม่มีรายรับที่รออยู่',
        description: liquidityGap < 0
            ? 'ยอดค้างจ่ายสูงกว่ายอดรอรับเงิน ควรเร่งทวงถามจากโรงงาน'
            : 'ยอดรอรับเงินครอบคลุมค่าใช้จ่ายที่ต้องจ่าย',
        icon: Icons.payments_outlined,
        color: liquidityGap < 0 ? Colors.redAccent : Colors.blueAccent,
        progress: pendingReceivableAmount <= 0
            ? null
            : (pendingExpenseAmount / pendingReceivableAmount).clamp(0.0, 1.0),
      ),
    ];
  }

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
    final validLots =
        _inventoryLots.where((lot) => lot.capacityTons > 0).toList();
    if (validLots.isEmpty) {
      return 0;
    }
    final percentages = validLots
        .map((lot) => lot.fillPercentage)
        .fold<double>(0, (value, element) => value + element);
    return percentages / validLots.length;
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

  WorkflowMutationResult recordPurchase({
    required String ticketId,
    required String farmerName,
    required String village,
    required double weightKg,
    required double pricePerKg,
    required String grade,
  }) {
    if (weightKg <= 0 || pricePerKg <= 0) {
      return WorkflowMutationResult.ignored;
    }
    final id = ticketId.trim();
    if (id.isEmpty) {
      return WorkflowMutationResult.ignored;
    }
    final seller =
        farmerName.trim().isEmpty ? 'ไม่ระบุผู้ขาย' : farmerName.trim();
    final villageName =
        village.trim().isEmpty ? 'ไม่ระบุพื้นที่' : village.trim();
    final now = DateTime.now();
    final existingPurchaseIndex =
        _purchases.indexWhere((ticket) => ticket.ticketId == id);
    double? preservedMoisture;
    if (existingPurchaseIndex != -1) {
      preservedMoisture =
          _purchases.removeAt(existingPurchaseIndex).moisturePercentage;
      _tradeRecords.removeWhere((trade) =>
          trade.type == TradeType.purchase && trade.referenceId == id);
    }

    final existingBatchIndex =
        _processingBatches.indexWhere((batch) => batch.originTicketId == id);
    var preservedStage = ProcessingStage.receiving;
    var preservedLocation = 'ลานตากหลัก';
    if (existingBatchIndex != -1) {
      final existingBatch = _processingBatches.removeAt(existingBatchIndex);
      preservedStage = existingBatch.stage;
      preservedLocation = existingBatch.location;
    }

    final result = existingPurchaseIndex == -1
        ? WorkflowMutationResult.created
        : WorkflowMutationResult.updated;

    final ticket = PurchaseTicket(
      ticketId: id,
      farmerName: seller,
      village: villageName,
      weightKg: weightKg,
      pricePerKg: pricePerKg,
      grade: grade,
      timestamp: now,
    )..moisturePercentage = preservedMoisture;
    _purchases.insert(0, ticket);
    _processingBatches.insert(
      0,
      ProcessingBatch(
        batchId: _batchIdFromTicket(ticketId),
        originTicketId: id,
        weightKg: weightKg,
        location: result == WorkflowMutationResult.created
            ? 'ลานตากหลัก'
            : preservedLocation,
        stage: result == WorkflowMutationResult.created
            ? ProcessingStage.receiving
            : preservedStage,
        updatedAt: now,
      ),
    );
    _tradeRecords.insert(
      0,
      TradeRecord(
        type: TradeType.purchase,
        referenceId: id,
        counterparty: seller,
        timestamp: now,
        weightKg: weightKg,
        amount: ticket.totalPrice,
      ),
    );
    _pushActivity(
      WorkflowActivity(
        title: result == WorkflowMutationResult.created
            ? 'รับซื้อ ${ticket.farmerName}'
            : 'อัปเดตรายการรับซื้อ ${ticket.farmerName}',
        detail:
            'น้ำหนัก ${ticket.weightKg.toStringAsFixed(0)} กก. ที่ ${ticket.pricePerKg.toStringAsFixed(2)} บาท/กก.',
        icon: Icons.qr_code_scanner,
        color: Colors.deepOrange,
        timestamp: now,
        referenceId: id,
      ),
    );
    notifyListeners();
    return result;
  }

  bool deletePurchase(String ticketId) {
    final index =
        _purchases.indexWhere((ticket) => ticket.ticketId == ticketId);
    if (index == -1) {
      return false;
    }
    final removedTicket = _purchases.removeAt(index);

    _moistureLogs.removeWhere((log) => log.ticketId == ticketId);
    _processingBatches.removeWhere((batch) => batch.originTicketId == ticketId);

    final removedDeliveries = <DeliverySchedule>[];
    for (final delivery in _deliveries) {
      delivery.ticketRefs.removeWhere((ref) => ref == ticketId);
      if (delivery.ticketRefs.isEmpty) {
        removedDeliveries.add(delivery);
      }
    }
    for (final delivery in removedDeliveries) {
      _deliveries.remove(delivery);
      _tradeRecords.removeWhere((trade) =>
          trade.type == TradeType.sale &&
          trade.referenceId == delivery.deliveryId);
      _activityFeed.removeWhere(
          (activity) => activity.referenceId == delivery.deliveryId);
    }

    _tradeRecords.removeWhere((trade) =>
        trade.type == TradeType.purchase && trade.referenceId == ticketId);
    _activityFeed.removeWhere(
        (activity) => activity.referenceId == removedTicket.ticketId);

    _pushActivity(
      WorkflowActivity(
        title: 'ลบใบรับซื้อ ${removedTicket.farmerName}',
        detail: 'ลบข้อมูล ${removedTicket.ticketId} ออกจากระบบ',
        icon: Icons.delete_forever,
        color: Colors.redAccent,
        timestamp: DateTime.now(),
        referenceId: removedTicket.ticketId,
      ),
    );
    notifyListeners();
    return true;
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
    final id = ticketId.trim();
    if (id.isEmpty) {
      return;
    }
    final safeMoisture = moisture.clamp(0, 100).toDouble();
    final inspectorName =
        inspector.trim().isEmpty ? 'ไม่ระบุผู้ตรวจ' : inspector.trim();
    final now = DateTime.now();
    final log = MoistureLog(
      ticketId: id,
      moisture: safeMoisture,
      inspector: inspectorName,
      note: note.trim().isEmpty ? '-' : note.trim(),
      timestamp: now,
    );
    _moistureLogs.insert(0, log);

    for (final ticket in _purchases) {
      if (ticket.ticketId == id) {
        ticket.moisturePercentage = safeMoisture;
        break;
      }
    }

    for (final batch in _processingBatches) {
      if (batch.originTicketId == id) {
        batch.stage = safeMoisture <= 14
            ? ProcessingStage.grading
            : ProcessingStage.drying;
        batch.updatedAt = now;
      }
    }

    _pushActivity(
      WorkflowActivity(
        title: 'บันทึกความชื้น $id',
        detail:
            'ค่าความชื้น ${safeMoisture.toStringAsFixed(1)}% โดย $inspectorName',
        icon: Icons.water_drop,
        color: Colors.blueAccent,
        timestamp: now,
        referenceId: id,
      ),
    );
    notifyListeners();
  }

  bool deleteMoistureLog(MoistureLog log) {
    final removed = _moistureLogs.remove(log);
    if (!removed) {
      return false;
    }
    MoistureLog? latest;
    for (final entry in _moistureLogs) {
      if (entry.ticketId == log.ticketId) {
        latest = entry;
        break;
      }
    }
    for (final ticket in _purchases) {
      if (ticket.ticketId == log.ticketId) {
        ticket.moisturePercentage = latest?.moisture;
        break;
      }
    }
    for (final batch in _processingBatches) {
      if (batch.originTicketId == log.ticketId) {
        if (latest == null && batch.stage != ProcessingStage.completed) {
          batch.stage = ProcessingStage.receiving;
        }
        batch.updatedAt = DateTime.now();
        break;
      }
    }
    _activityFeed
        .removeWhere((activity) => activity.referenceId == log.ticketId);
    _pushActivity(
      WorkflowActivity(
        title: 'ยกเลิกการวัดความชื้น ${log.ticketId}',
        detail:
            'ลบค่าความชื้น ${log.moisture.toStringAsFixed(1)}% ออกจากประวัติ',
        icon: Icons.water_drop_outlined,
        color: Colors.grey,
        timestamp: DateTime.now(),
        referenceId: log.ticketId,
      ),
    );
    notifyListeners();
    return true;
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
        referenceId: batch.batchId,
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

  WorkflowMutationResult scheduleDelivery({
    required String deliveryId,
    required String factoryName,
    required String truckId,
    required DateTime departureTime,
    required double weightKg,
    required List<String> ticketRefs,
  }) {
    final sanitizedTickets =
        ticketRefs.where((ticket) => ticket.trim().isNotEmpty).toList();
    final id = deliveryId.trim();
    if (sanitizedTickets.isEmpty || weightKg <= 0 || id.isEmpty) {
      return WorkflowMutationResult.ignored;
    }
    final factory =
        factoryName.trim().isEmpty ? 'โรงงานไม่ระบุ' : factoryName.trim();
    final truck = truckId.trim().isEmpty ? 'ไม่ระบุรถ' : truckId.trim();
    final now = DateTime.now();
    final existingIndex =
        _deliveries.indexWhere((delivery) => delivery.deliveryId == id);
    var preservedStatus = DeliveryStatus.scheduled;
    if (existingIndex != -1) {
      final existing = _deliveries.removeAt(existingIndex);
      preservedStatus = existing.status;
      _tradeRecords.removeWhere(
          (trade) => trade.type == TradeType.sale && trade.referenceId == id);
    }

    final result = existingIndex == -1
        ? WorkflowMutationResult.created
        : WorkflowMutationResult.updated;

    final schedule = DeliverySchedule(
      deliveryId: id,
      factoryName: factory,
      truckId: truck,
      departureTime: departureTime,
      weightKg: weightKg,
      ticketRefs: sanitizedTickets,
      status: result == WorkflowMutationResult.created
          ? DeliveryStatus.scheduled
          : preservedStatus,
    );
    _deliveries.insert(0, schedule);
    if (result == WorkflowMutationResult.updated &&
        preservedStatus == DeliveryStatus.delivered) {
      _tradeRecords.insert(
        0,
        TradeRecord(
          type: TradeType.sale,
          referenceId: id,
          counterparty: factory,
          timestamp: now,
          weightKg: weightKg,
          amount: weightKg * 9.10,
        ),
      );
    }
    _pushActivity(
      WorkflowActivity(
        title: result == WorkflowMutationResult.created
            ? 'วางแผนจัดส่ง $id'
            : 'อัปเดตแผนจัดส่ง $id',
        detail:
            'รถ $truck ไปยัง $factory น้ำหนัก ${weightKg.toStringAsFixed(0)} กก.',
        icon: Icons.local_shipping,
        color: Colors.green,
        timestamp: now,
        referenceId: id,
      ),
    );
    notifyListeners();
    return result;
  }

  bool deleteDelivery(String deliveryId) {
    final index =
        _deliveries.indexWhere((delivery) => delivery.deliveryId == deliveryId);
    if (index == -1) {
      return false;
    }
    final removed = _deliveries.removeAt(index);
    _tradeRecords.removeWhere((trade) =>
        trade.type == TradeType.sale && trade.referenceId == deliveryId);
    _activityFeed.removeWhere((activity) => activity.referenceId == deliveryId);
    _pushActivity(
      WorkflowActivity(
        title: 'ยกเลิกรอบจัดส่ง ${removed.deliveryId}',
        detail: 'ลบแผนจัดส่งไปยัง ${removed.factoryName}',
        icon: Icons.delete_outline,
        color: Colors.redAccent,
        timestamp: DateTime.now(),
        referenceId: deliveryId,
      ),
    );
    notifyListeners();
    return true;
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
          referenceId: delivery.deliveryId,
        ),
      );
    }
    notifyListeners();
  }

  void acknowledgeAlert(BurnAlert alert, bool acknowledged) {
    alert.acknowledged = acknowledged;
    _pushActivity(
      WorkflowActivity(
        title: acknowledged
            ? 'รับทราบเหตุไฟ ${alert.location}'
            : 'เปิดแจ้งเตือนซ้ำ ${alert.location}',
        detail: 'ระดับ${alert.severity}',
        icon: acknowledged ? Icons.task_alt : Icons.warning_amber_outlined,
        color: acknowledged ? Colors.green : Colors.orangeAccent,
        timestamp: DateTime.now(),
        referenceId: 'alert-${alert.id}-ack',
      ),
    );
    notifyListeners();
  }

  void addManualAlert({
    required String location,
    required String severity,
    required String description,
  }) {
    final trimmedLocation =
        location.trim().isEmpty ? 'ไม่ระบุพื้นที่' : location.trim();
    final detail = description.trim();
    final alert = BurnAlert(
      location: trimmedLocation,
      detectedAt: DateTime.now(),
      severity: severity,
      description: detail.isEmpty ? 'ไม่มีรายละเอียดเพิ่มเติม' : detail,
    );
    _burnAlerts.insert(0, alert);
    _pushActivity(
      WorkflowActivity(
        title: 'แจ้งเตือนการเผาใหม่',
        detail: '${alert.location} • ระดับ${alert.severity}',
        icon: Icons.warning,
        color: Colors.deepOrangeAccent,
        timestamp: alert.detectedAt,
        referenceId: 'alert-${alert.id}',
      ),
    );
    notifyListeners();
  }

  bool deleteAlert(BurnAlert alert) {
    final removed = _burnAlerts.remove(alert);
    if (!removed) {
      return false;
    }
    _activityFeed.removeWhere((activity) =>
        activity.referenceId == 'alert-${alert.id}' ||
        activity.referenceId == 'alert-${alert.id}-ack');
    _pushActivity(
      WorkflowActivity(
        title: 'ลบแจ้งเตือนการเผา',
        detail: alert.location,
        icon: Icons.delete_forever,
        color: Colors.redAccent,
        timestamp: DateTime.now(),
        referenceId: 'alert-${alert.id}-delete',
      ),
    );
    notifyListeners();
    return true;
  }

  void addInventoryLot({
    required String siloName,
    required double capacityTons,
    required double filledTons,
    required double temperatureC,
    required double humidity,
  }) {
    if (capacityTons <= 0) {
      return;
    }
    var safeFilled = filledTons.isFinite ? filledTons : 0;
    if (safeFilled < 0) {
      safeFilled = 0;
    } else if (safeFilled > capacityTons) {
      safeFilled = capacityTons;
    }
    final safeTemperature = temperatureC.isFinite ? temperatureC : 0;
    final safeHumidity =
        humidity.isFinite ? humidity.clamp(0, 100).toDouble() : 0;
    final lot = InventoryLot(
      siloName: siloName,
      capacityTons: capacityTons,
      filledTons: safeFilled.toDouble(),
      temperatureC: safeTemperature.toDouble(),
      humidity: safeHumidity.toDouble(),
      lastInspection: DateTime.now(),
    );
    _inventoryLots.insert(0, lot);
    notifyListeners();
  }

  void updateInventoryLot(InventoryLot lot,
      {double? filledTons,
      double? temperatureC,
      double? humidity,
      bool? locked}) {
    if (filledTons != null) {
      var safeFilled = filledTons.isFinite ? filledTons : lot.filledTons;
      if (safeFilled < 0) {
        safeFilled = 0;
      } else if (lot.capacityTons > 0 && safeFilled > lot.capacityTons) {
        safeFilled = lot.capacityTons;
      }
      lot.filledTons = safeFilled;
    }
    if (temperatureC != null) {
      lot.temperatureC =
          temperatureC.isFinite ? temperatureC : lot.temperatureC;
    }
    if (humidity != null) {
      if (humidity.isFinite) {
        lot.humidity = humidity.clamp(0, 100).toDouble();
      }
    }
    if (locked != null) {
      lot.locked = locked;
    }
    lot.lastInspection = DateTime.now();
    notifyListeners();
  }

  bool removeInventoryLot(InventoryLot lot) {
    final removed = _inventoryLots.remove(lot);
    if (!removed) {
      return false;
    }
    _pushActivity(
      WorkflowActivity(
        title: 'ลบพื้นที่จัดเก็บ ${lot.siloName}',
        detail:
            'นำ ${lot.siloName} ออกจากรายการคลังสินค้าเพื่อจัดระเบียบพื้นที่',
        icon: Icons.delete_rounded,
        color: Colors.redAccent,
        timestamp: DateTime.now(),
        referenceId: lot.siloName,
      ),
    );
    notifyListeners();
    return true;
  }

  WorkflowMutationResult recordFinanceTransaction({
    required String transactionId,
    required String description,
    required double amount,
    required String counterparty,
    required bool isExpense,
  }) {
    if (amount <= 0) {
      return WorkflowMutationResult.ignored;
    }
    final id = transactionId.trim();
    if (id.isEmpty) {
      return WorkflowMutationResult.ignored;
    }
    final detail =
        description.trim().isEmpty ? 'ไม่ระบุรายการ' : description.trim();
    final partner =
        counterparty.trim().isEmpty ? 'ไม่ระบุคู่ค้า' : counterparty.trim();
    final existingIndex = _financeTransactions
        .indexWhere((transaction) => transaction.transactionId == id);
    var preservedSettlement = false;
    if (existingIndex != -1) {
      preservedSettlement =
          _financeTransactions.removeAt(existingIndex).settled;
    }

    final result = existingIndex == -1
        ? WorkflowMutationResult.created
        : WorkflowMutationResult.updated;

    final tx = FinanceTransaction(
      transactionId: id,
      description: detail,
      amount: amount,
      timestamp: DateTime.now(),
      counterparty: partner,
      isExpense: isExpense,
      settled: result == WorkflowMutationResult.created
          ? false
          : preservedSettlement,
    );
    _financeTransactions.insert(0, tx);
    _pushActivity(
      WorkflowActivity(
        title: isExpense ? 'จ่ายเงิน $partner' : 'รับเงินจาก $partner',
        detail: '${amount.toStringAsFixed(2)} บาท - $detail',
        icon: isExpense ? Icons.payments : Icons.account_balance_wallet,
        color: isExpense ? Colors.redAccent : Colors.teal,
        timestamp: tx.timestamp,
        referenceId: id,
      ),
    );
    notifyListeners();
    return result;
  }

  void toggleFinanceSettlement(FinanceTransaction tx, bool settled) {
    tx.settled = settled;
    notifyListeners();
  }

  bool deleteFinanceTransaction(String transactionId) {
    final index = _financeTransactions
        .indexWhere((tx) => tx.transactionId == transactionId);
    if (index == -1) {
      return false;
    }
    final removed = _financeTransactions.removeAt(index);
    _activityFeed
        .removeWhere((activity) => activity.referenceId == transactionId);
    _pushActivity(
      WorkflowActivity(
        title: 'ลบธุรกรรม ${removed.transactionId}',
        detail: removed.description,
        icon: Icons.delete_sweep_outlined,
        color: Colors.redAccent,
        timestamp: DateTime.now(),
        referenceId: transactionId,
      ),
    );
    notifyListeners();
    return true;
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
    if (activity.referenceId != null) {
      _activityFeed.removeWhere(
          (existing) => existing.referenceId == activity.referenceId);
    }
    _activityFeed.insert(0, activity);
    if (_activityFeed.length > 50) {
      _activityFeed.removeLast();
    }
  }

  String _batchIdFromTicket(String ticketId) {
    final numeric = RegExp(r'\d+')
        .allMatches(ticketId)
        .map((match) => match.group(0)!)
        .join();
    final cleaned = (numeric.isNotEmpty ? numeric : ticketId)
        .replaceAll(RegExp(r'[^A-Za-z0-9]'), '');
    if (cleaned.isEmpty) {
      final fallback = (DateTime.now().millisecondsSinceEpoch % 1000)
          .toString()
          .padLeft(3, '0');
      return 'PR-$fallback';
    }
    final suffixLength = cleaned.length >= 3 ? 3 : cleaned.length;
    final suffix =
        cleaned.substring(cleaned.length - suffixLength).padLeft(3, '0');
    return 'PR-$suffix';
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
