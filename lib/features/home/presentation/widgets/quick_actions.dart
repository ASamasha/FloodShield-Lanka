import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../sos/presentation/screens/sos_screen.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'QUICK ACTIONS',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _ActionItem(
                icon: Icons.sos,
                label: 'SOS',
                color: AppTheme.criticalRed,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const SosScreen()));
                },
              ),
              _ActionItem(
                icon: Icons.report_problem,
                label: 'Report',
                color: AppTheme.primaryBlue,
                onTap: () => _navigateToPlaceholder(context, 'Report'),
              ),
              _ActionItem(
                icon: Icons.house,
                label: 'Shelter',
                color: Colors.green[700]!,
                onTap: () => _navigateToPlaceholder(context, 'Shelter'),
              ),
              _ActionItem(
                icon: Icons.phone,
                label: 'Contacts',
                color: Colors.blueGrey,
                onTap: () => _navigateToPlaceholder(context, 'Contacts'),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _navigateToPlaceholder(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: Text(title)),
          body: Center(child: Text('\$title Screen not implemented yet.')),
        ),
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                )
              ],
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.primaryBlue,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
