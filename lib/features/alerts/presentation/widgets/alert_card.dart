import 'package:flutter/material.dart';
import '../../domain/entities/alert_entities.dart';

class AlertCard extends StatelessWidget {
  final FloodAlert alert;
  final VoidCallback onTap;

  const AlertCard({super.key, required this.alert, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withOpacity(0.15)),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4, offset: const Offset(0, 2))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    alert.title,
                    style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: Color(0xFF1A2B3C)),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: alert.riskColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: alert.riskColor.withOpacity(0.3)),
                  ),
                  child: Text(
                    alert.riskLabel,
                    style: TextStyle(color: alert.riskColor, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '\${alert.district} · \${alert.waterBody}',
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Issued \${alert.timeAgo}',
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                ),
                Text(
                  'View Details →',
                  style: TextStyle(color: Colors.blue[700], fontSize: 12, fontWeight: FontWeight.bold),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
