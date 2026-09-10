import 'package:flutter/material.dart';

enum AlertRiskLevel { low, moderate, high }

class FloodAlert {
  final String id;
  final String title;
  final AlertRiskLevel riskLevel;
  final String district;
  final String waterBody;
  final DateTime issuedAt;
  final List<String> safetyInstructions;
  final bool isRead;

  FloodAlert({
    required this.id,
    required this.title,
    required this.riskLevel,
    required this.district,
    required this.waterBody,
    required this.issuedAt,
    required this.safetyInstructions,
    this.isRead = false,
  });

  String get timeAgo {
    final diff = DateTime.now().difference(issuedAt);
    if (diff.inMinutes < 60) return '\${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '\${diff.inHours}h ago';
    return '\${diff.inDays}d ago';
  }

  Color get riskColor {
    switch (riskLevel) {
      case AlertRiskLevel.high: return Colors.red[700]!;
      case AlertRiskLevel.moderate: return Colors.orange[700]!;
      case AlertRiskLevel.low: return Colors.green[700]!;
    }
  }

  String get riskLabel {
    switch (riskLevel) {
      case AlertRiskLevel.high: return 'High Risk';
      case AlertRiskLevel.moderate: return 'Moderate Risk';
      case AlertRiskLevel.low: return 'Low Risk';
    }
  }
}

class ChartDataPoint {
  final String timeLabel;
  final double rainfallMm;
  final double riverLevelMeters;

  ChartDataPoint({required this.timeLabel, required this.rainfallMm, required this.riverLevelMeters});
}

class AiRiskAnalysis {
  final String alertId;
  final AlertRiskLevel riskLevel;
  final List<ChartDataPoint> historicalData;
  final String predictedFloodingTime;
  final String aiConfidence;

  AiRiskAnalysis({
    required this.alertId,
    required this.riskLevel,
    required this.historicalData,
    required this.predictedFloodingTime,
    required this.aiConfidence,
  });
}
