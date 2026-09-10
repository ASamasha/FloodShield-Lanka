import 'package:flutter/material.dart';
import 'home_screen.dart';
import '../../../../features/sos/presentation/screens/sos_screen.dart';
import '../../../../features/learn/presentation/screens/learn_home_screen.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../profile/presentation/screens/profile_home_screen.dart';
import '../../../alerts/presentation/screens/alerts_list_screen.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          const HomeScreen(),
          const AlertsListScreen(),
          const SosScreen(),
          const LearnHomeScreen(), // Index 3
          const ProfileHomeScreen(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: SizedBox(
          height: 64,
          width: 64,
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                _currentIndex = 2;
              });
            },
            backgroundColor: AppTheme.criticalRed,
            elevation: 4,
            shape: const CircleBorder(),
            child: const Text(
              'SOS',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                const Icon(Icons.notifications),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: AppTheme.criticalRed,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: const BoxConstraints(minWidth: 12, minHeight: 12),
                    child: const Text(
                      '3',
                      style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ), 
            label: 'Alerts'
          ),
          const BottomNavigationBarItem(icon: SizedBox.shrink(), label: ''),
          const BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Learn'),
          const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _placeholderScreen(String title) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('\$title Module not implemented yet.')),
    );
  }
}
