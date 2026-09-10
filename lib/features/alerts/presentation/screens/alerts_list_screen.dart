import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/alert_entities.dart';
import '../../domain/repos/alerts_repository.dart';
import '../../data/repos/mock_alerts_repository.dart';
import 'alert_detail_screen.dart';
import '../widgets/alert_card.dart';

class AlertsListScreen extends StatefulWidget {
  const AlertsListScreen({super.key});

  @override
  State<AlertsListScreen> createState() => _AlertsListScreenState();
}

class _AlertsListScreenState extends State<AlertsListScreen> {
  final AlertsRepository _repo = MockAlertsRepository();
  List<FloodAlert>? _alerts;
  AlertRiskLevel? _currentFilter;

  @override
  void initState() {
    super.initState();
    _loadAlerts();
  }

  Future<void> _loadAlerts() async {
    setState(() => _alerts = null);
    final alerts = await _repo.getAlerts(filter: _currentFilter);
    if (mounted) setState(() => _alerts = alerts);
  }

  void _setFilter(AlertRiskLevel? filter) {
    if (_currentFilter == filter) return;
    setState(() => _currentFilter = filter);
    _loadAlerts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: AppBar(
        title: const Text('Flood Alerts', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
        backgroundColor: AppTheme.primaryBlue,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Issued by Disaster Management Centre',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _FilterChip(label: 'All', isSelected: _currentFilter == null, onTap: () => _setFilter(null)),
                      const SizedBox(width: 8),
                      _FilterChip(label: 'High', isSelected: _currentFilter == AlertRiskLevel.high, onTap: () => _setFilter(AlertRiskLevel.high)),
                      const SizedBox(width: 8),
                      _FilterChip(label: 'Moderate', isSelected: _currentFilter == AlertRiskLevel.moderate, onTap: () => _setFilter(AlertRiskLevel.moderate)),
                      const SizedBox(width: 8),
                      _FilterChip(label: 'Low', isSelected: _currentFilter == AlertRiskLevel.low, onTap: () => _setFilter(AlertRiskLevel.low)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _alerts == null
                ? const Center(child: CircularProgressIndicator())
                : _alerts!.isEmpty
                    ? const Center(child: Text('No alerts found for this filter.', style: TextStyle(color: Colors.grey)))
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _alerts!.length,
                        itemBuilder: (context, index) {
                          final alert = _alerts![index];
                          return AlertCard(
                            alert: alert,
                            onTap: () {
                              _repo.markAlertAsRead(alert.id);
                              Navigator.push(context, MaterialPageRoute(builder: (_) => AlertDetailScreen(alert: alert, repository: _repo)))
                                .then((_) => _loadAlerts());
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryBlue : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? AppTheme.primaryBlue : Colors.grey[300]!),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[700],
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
