import 'package:flutter/material.dart';
import '../../data/repos/mock_home_repository.dart';
import '../../domain/repos/home_repository.dart';
import '../widgets/home_header.dart';
import '../widgets/quick_actions.dart';
import '../widgets/risk_banner.dart';
import '../widgets/latest_alerts.dart';
import '../widgets/video_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeRepository _repository = MockHomeRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HomeHeader(repository: _repository),
              RiskBanner(repository: _repository),
              const QuickActions(),
              LatestAlerts(repository: _repository),
              VideoCard(repository: _repository),
              const SizedBox(height: 80), // padding for bottom nav & FAB
            ],
          ),
        ),
      ),
    );
  }
}
