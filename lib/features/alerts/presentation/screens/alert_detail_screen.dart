import 'package:flutter/material.dart';
import '../../domain/entities/alert_entities.dart';
import '../../domain/repos/alerts_repository.dart';
import '../widgets/ai_risk_chart.dart';

class AlertDetailScreen extends StatefulWidget {
  final FloodAlert alert;
  final AlertsRepository repository;

  const AlertDetailScreen({super.key, required this.alert, required this.repository});

  @override
  State<AlertDetailScreen> createState() => _AlertDetailScreenState();
}

class _AlertDetailScreenState extends State<AlertDetailScreen> {
  bool _isAiExpanded = false;
  AiRiskAnalysis? _aiAnalysis;
  bool _isLoadingAi = false;

  void _toggleAiPanel() async {
    setState(() {
      _isAiExpanded = !_isAiExpanded;
      if (_isAiExpanded && _aiAnalysis == null) {
        _isLoadingAi = true;
      }
    });

    if (_isAiExpanded && _aiAnalysis == null) {
      final analysis = await widget.repository.getAiRiskAnalysis(widget.alert.id);
      if (mounted) {
        setState(() {
          _aiAnalysis = analysis;
          _isLoadingAi = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.alert.riskColor;
    final isLowRisk = widget.alert.riskLevel == AlertRiskLevel.low;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: AppBar(
        title: const Text('Flood Alert', style: TextStyle(color: Colors.white, fontSize: 14)),
        backgroundColor: bgColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Colored Header
            Container(
              width: double.infinity,
              color: bgColor,
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FLOOD ALERT - \${widget.alert.district.toUpperCase()}',
                    style: const TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.alert.title,
                    style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\${widget.alert.waterBody}\nIssued \${widget.alert.timeAgo}',
                    style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
                  ),
                ],
              ),
            ),
            
            // Content
            Transform.translate(
              offset: const Offset(0, -16),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    // Instructions Card
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Safety Instructions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 16),
                          ...widget.alert.safetyInstructions.map((inst) => Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      isLowRisk ? Icons.check_circle : Icons.warning_rounded,
                                      color: bgColor,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(inst, style: const TextStyle(fontSize: 14, height: 1.3)),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // AI Risk Analysis Button / Panel
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
                      ),
                      child: Column(
                        children: [
                          if (_isAiExpanded) ...[
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: _isLoadingAi || _aiAnalysis == null
                                  ? const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 40),
                                      child: Center(child: CircularProgressIndicator()),
                                    )
                                  : AiRiskChartPanel(analysis: _aiAnalysis!),
                            ),
                          ],
                          InkWell(
                            onTap: _toggleAiPanel,
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                color: const Color(0xFF004B8F),
                                borderRadius: _isAiExpanded
                                    ? const BorderRadius.vertical(bottom: Radius.circular(16))
                                    : BorderRadius.circular(16),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _isAiExpanded ? 'Hide AI Risk Analysis' : 'View AI Risk Analysis',
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(
                                    _isAiExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Actions
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Deep linking to Shelter Finder...')));
                        },
                        icon: const Icon(Icons.location_on, color: Colors.green),
                        label: const Text('Find Nearest Shelter', style: TextStyle(color: Colors.black87)),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.white,
                          side: BorderSide(color: Colors.grey.withOpacity(0.3)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                    
                    if (!isLowRisk) ...[
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.green[200]!),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.directions, color: Colors.green, size: 16),
                                  SizedBox(width: 8),
                                  Text('Safe Evacuation Route', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12)),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Starting Navigation...')));
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green[700],
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                child: const Text('Start Navigation →', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
