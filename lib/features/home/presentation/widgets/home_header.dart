import 'package:flutter/material.dart';
import '../../domain/repos/home_repository.dart';
import '../../domain/entities/user_profile.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../alerts/presentation/screens/alerts_list_screen.dart';

class HomeHeader extends StatelessWidget {
  final HomeRepository repository;

  const HomeHeader({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.primaryBlue,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.shield, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'FloodShield Lanka',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text('EN | SI | TA', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const AlertsListScreen()));
                    },
                    child: Stack(
                      children: [
                        const Icon(Icons.notifications_outlined, color: Colors.white),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: AppTheme.criticalRed,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 12,
                              minHeight: 12,
                            ),
                            child: const Text(
                              '3',
                              style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 24),
          FutureBuilder<UserProfile>(
            future: repository.getUserProfile(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const SizedBox(height: 48);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Good morning,',
                    style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
                  ),
                  Text(
                    snapshot.data!.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.white70, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        snapshot.data!.district,
                        style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
