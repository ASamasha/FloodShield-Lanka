import 'package:flutter/material.dart';
import '../../domain/repos/home_repository.dart';
import '../../domain/entities/alert.dart';
import '../../../../../core/theme/app_theme.dart';

class LatestAlerts extends StatelessWidget {
  final HomeRepository repository;

  const LatestAlerts({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Alert>>(
      future: repository.getLatestAlerts(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox();
        final alerts = snapshot.data!;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'LATEST ALERTS',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'View All →',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryBlue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ...alerts.map((alert) => _AlertCard(alert: alert)),
            ],
          ),
        );
      },
    );
  }
}

class _AlertCard extends StatelessWidget {
  final Alert alert;

  const _AlertCard({required this.alert});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(Icons.warning_rounded, color: alert.severityColor, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    alert.title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    alert.timeAgo,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: alert.severityColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: alert.severityColor.withOpacity(0.5)),
              ),
              child: Text(
                alert.severity,
                style: TextStyle(
                  color: alert.severityColor,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
