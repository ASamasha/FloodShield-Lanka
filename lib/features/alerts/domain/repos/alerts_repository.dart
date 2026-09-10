import '../entities/alert_entities.dart';

abstract class AlertsRepository {
  Future<List<FloodAlert>> getAlerts({AlertRiskLevel? filter});
  Future<AiRiskAnalysis> getAiRiskAnalysis(String alertId);
  Future<int> getUnreadAlertsCount();
  Future<void> markAlertAsRead(String alertId);
}
