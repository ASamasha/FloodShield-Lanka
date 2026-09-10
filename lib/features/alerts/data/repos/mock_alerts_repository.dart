import 'package:floodshield_lanka/features/alerts/domain/entities/alert_entities.dart';
import 'package:floodshield_lanka/features/alerts/domain/repos/alerts_repository.dart';

class MockAlertsRepository implements AlertsRepository {
  final List<FloodAlert> _mockAlerts = [
    FloodAlert(
      id: 'a1',
      title: 'High Flood Warning',
      riskLevel: AlertRiskLevel.high,
      district: 'Colombo',
      waterBody: 'Kelani Ganga',
      issuedAt: DateTime.now().subtract(const Duration(minutes: 45)),
      safetyInstructions: [
        'Evacuate all low-lying areas immediately',
        'Do not attempt to cross flooded roads',
        'Move to designated shelters with essentials',
        'Call 1938 if you are in immediate danger',
      ],
      isRead: false,
    ),
    FloodAlert(
      id: 'a2',
      title: 'Moderate Risk Alert',
      riskLevel: AlertRiskLevel.moderate,
      district: 'Gampaha',
      waterBody: 'Attanagalu Oya',
      issuedAt: DateTime.now().subtract(const Duration(hours: 2)),
      safetyInstructions: [
        'Avoid low-lying and riverbank areas',
        'Prepare emergency supply bag',
        'Stay indoors and monitor official updates',
        'Keep emergency contacts ready',
      ],
      isRead: false,
    ),
    FloodAlert(
      id: 'a3',
      title: 'Flood Watch Active',
      riskLevel: AlertRiskLevel.moderate,
      district: 'Kalutara',
      waterBody: 'Kalu Ganga',
      issuedAt: DateTime.now().subtract(const Duration(hours: 5)),
      safetyInstructions: [
        'Monitor local weather reports',
        'Move valuables to higher ground if near river',
        'Avoid unnecessary travel in affected zones',
      ],
      isRead: true,
    ),
    FloodAlert(
      id: 'a4',
      title: 'All Clear Issued',
      riskLevel: AlertRiskLevel.low,
      district: 'Galle',
      waterBody: 'Gin Ganga',
      issuedAt: DateTime.now().subtract(const Duration(hours: 12)),
      safetyInstructions: [
        'Conditions have improved significantly',
        'Check roads before traveling',
        'Report any remaining damage via the app',
      ],
      isRead: true,
    ),
  ];

  @override
  Future<List<FloodAlert>> getAlerts({AlertRiskLevel? filter}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (filter == null) return _mockAlerts;
    return _mockAlerts.where((a) => a.riskLevel == filter).toList();
  }

  @override
  Future<int> getUnreadAlertsCount() async {
    return _mockAlerts.where((a) => !a.isRead).length;
  }

  @override
  Future<void> markAlertAsRead(String alertId) async {
    final index = _mockAlerts.indexWhere((a) => a.id == alertId);
    if (index != -1) {
      _mockAlerts[index] = FloodAlert(
        id: _mockAlerts[index].id,
        title: _mockAlerts[index].title,
        riskLevel: _mockAlerts[index].riskLevel,
        district: _mockAlerts[index].district,
        waterBody: _mockAlerts[index].waterBody,
        issuedAt: _mockAlerts[index].issuedAt,
        safetyInstructions: _mockAlerts[index].safetyInstructions,
        isRead: true,
      );
    }
  }

  @override
  Future<AiRiskAnalysis> getAiRiskAnalysis(String alertId) async {
    await Future.delayed(
        const Duration(seconds: 1)); // Simulate AI computation/network

    final alert = _mockAlerts.firstWhere((a) => a.id == alertId,
        orElse: () => _mockAlerts.first);

    // Generate some mock chart data (last 24 hours)
    final List<ChartDataPoint> data = [];
    double baseRain = alert.riskLevel == AlertRiskLevel.high
        ? 40
        : (alert.riskLevel == AlertRiskLevel.moderate ? 20 : 5);
    double baseRiver = alert.riskLevel == AlertRiskLevel.high
        ? 6.5
        : (alert.riskLevel == AlertRiskLevel.moderate ? 4.0 : 2.0);

    for (int i = 24; i >= 0; i--) {
      data.add(ChartDataPoint(
        timeLabel: '-\${i}h',
        rainfallMm: baseRain + (i % 5) * 2,
        riverLevelMeters: baseRiver - (i * 0.1),
      ));
    }

    String predicted = alert.riskLevel == AlertRiskLevel.high
        ? '~2 Hours'
        : (alert.riskLevel == AlertRiskLevel.moderate ? '~6 Hours' : 'None');
    String confidence = alert.riskLevel == AlertRiskLevel.high ? '87%' : '92%';

    return AiRiskAnalysis(
      alertId: alertId,
      riskLevel: alert.riskLevel,
      historicalData: data,
      predictedFloodingTime: predicted,
      aiConfidence: confidence,
    );
  }
}
