import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../domain/entities/alert_entities.dart';

class AiRiskChartPanel extends StatelessWidget {
  final AiRiskAnalysis analysis;

  const AiRiskChartPanel({super.key, required this.analysis});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('RISK LEVEL GAUGE',
            style: TextStyle(
                color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        // Gauge
        Row(
          children: [
            _buildGaugeSegment(
                'Low', Colors.green, analysis.riskLevel == AlertRiskLevel.low),
            const SizedBox(width: 4),
            _buildGaugeSegment('Moderate', Colors.orange,
                analysis.riskLevel == AlertRiskLevel.moderate),
            const SizedBox(width: 4),
            _buildGaugeSegment(
                'High', Colors.red, analysis.riskLevel == AlertRiskLevel.high),
            const SizedBox(width: 4),
            _buildGaugeSegment('Severe', Colors.red[900]!, false),
          ],
        ),
        const SizedBox(height: 12),
        Center(
          child: Text(
            'Current: ${analysis.riskLevel.toString().split('.').last.toUpperCase()} RISK',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: _getColor(analysis.riskLevel)),
          ),
        ),
        const SizedBox(height: 24),

        const Text('RAINFALL + RIVER LEVEL - LAST 24 HOURS',
            style: TextStyle(
                color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        // FL Chart
        SizedBox(
          height: 180,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: false),
              titlesData: FlTitlesData(
                show: true,
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                        showTitles: false)), // Hide Y axis for clean UI
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 22,
                    interval: 6, // Show label every 6 hours
                    getTitlesWidget: (value, meta) {
                      if (value.toInt() < 0 ||
                          value.toInt() >= analysis.historicalData.length)
                        return const SizedBox.shrink();
                      return Text(
                        analysis.historicalData[value.toInt()].timeLabel,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 10),
                      );
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                // Rainfall Line (Blue, filled)
                LineChartBarData(
                  spots: analysis.historicalData
                      .asMap()
                      .entries
                      .map((e) => FlSpot(e.key.toDouble(), e.value.rainfallMm))
                      .toList(),
                  isCurved: true,
                  color: Colors.blue.withOpacity(0.5),
                  barWidth: 2,
                  isStrokeCapRound: true,
                  dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(
                      show: true, color: Colors.blue.withOpacity(0.2)),
                ),
                // River Level Line (Dark Blue)
                LineChartBarData(
                  spots: analysis.historicalData
                      .asMap()
                      .entries
                      .map((e) => FlSpot(
                          e.key.toDouble(), e.value.riverLevelMeters * 10))
                      .toList(), // Scaled for visibility
                  isCurved: true,
                  color: const Color(0xFF004B8F),
                  barWidth: 3,
                  isStrokeCapRound: true,
                  dotData: FlDotData(show: false),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 12, height: 4, color: Colors.blue.withOpacity(0.3)),
            const SizedBox(width: 4),
            const Text('Rainfall (mm)',
                style: TextStyle(fontSize: 10, color: Colors.grey)),
            const SizedBox(width: 16),
            Container(width: 12, height: 4, color: const Color(0xFF004B8F)),
            const SizedBox(width: 4),
            const Text('River Level (m)',
                style: TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
        const SizedBox(height: 24),

        // Stats Row
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Predicted Flooding',
                        style: TextStyle(color: Colors.red, fontSize: 10)),
                    const SizedBox(height: 4),
                    Text(analysis.predictedFloodingTime,
                        style: const TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('AI Confidence',
                        style: TextStyle(color: Colors.blue, fontSize: 10)),
                    const SizedBox(height: 4),
                    Text(analysis.aiConfidence,
                        style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildGaugeSegment(String label, Color color, bool isActive) {
    return Expanded(
      child: Container(
        height: 24,
        decoration: BoxDecoration(
          color: isActive ? color : color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white : color.withOpacity(0.6),
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Color _getColor(AlertRiskLevel level) {
    switch (level) {
      case AlertRiskLevel.high:
        return Colors.red;
      case AlertRiskLevel.moderate:
        return Colors.orange;
      case AlertRiskLevel.low:
        return Colors.green;
    }
  }
}
