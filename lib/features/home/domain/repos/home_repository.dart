import '../entities/alert.dart';
import '../entities/current_risk.dart';
import '../entities/user_profile.dart';
import '../entities/video_lesson.dart';

abstract class HomeRepository {
  Future<UserProfile> getUserProfile();
  Future<CurrentRisk> getCurrentRiskLevel();
  Future<List<Alert>> getLatestAlerts();
  Future<VideoLesson> getFeaturedVideo();
}
