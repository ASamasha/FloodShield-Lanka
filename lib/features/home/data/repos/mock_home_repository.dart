import 'package:flutter/material.dart';
import '../../domain/entities/alert.dart';
import '../../domain/entities/current_risk.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/entities/video_lesson.dart';
import '../../domain/repos/home_repository.dart';

class MockHomeRepository implements HomeRepository {
  @override
  Future<UserProfile> getUserProfile() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return UserProfile(name: 'Kamal Perera', district: 'Colombo District');
  }

  @override
  Future<CurrentRisk> getCurrentRiskLevel() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return CurrentRisk(
      level: 'Moderate Risk',
      instructions: 'Avoid low-lying areas. Keep emergency bag ready.',
      color: const Color(0xFFF57C00),
    );
  }

  @override
  Future<List<Alert>> getLatestAlerts() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      Alert(
        id: '1',
        title: 'High Flood Warning',
        timeAgo: 'Colombo • 2 mins ago',
        severity: 'High Risk',
        severityColor: const Color(0xFFD32F2F),
      ),
      Alert(
        id: '2',
        title: 'Moderate Risk Alert',
        timeAgo: 'Gampaha • 18 mins ago',
        severity: 'Moderate Risk',
        severityColor: const Color(0xFFF57C00),
      ),
      Alert(
        id: '3',
        title: 'Flood Watch Active',
        timeAgo: 'Kalutara • 1 hr ago',
        severity: 'Moderate Risk',
        severityColor: const Color(0xFFF57C00),
      ),
    ];
  }

  @override
  Future<VideoLesson> getFeaturedVideo() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return VideoLesson(
      title: 'What to Do When Floods Strike',
      duration: '4:12',
      progressPercent: 0.63,
    );
  }
}
