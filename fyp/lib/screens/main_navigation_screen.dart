import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import 'dashboard_screen.dart';
import 'diet_plan_screen.dart';
import 'cheat_tricks_screen.dart';
import 'meal_database_screen.dart';
import 'glucometer_scanner_screen.dart';
import 'daily_tracker_screen.dart';
import 'weekly_report_screen.dart';
import 'profile_screen.dart';
import 'widgets/custom_button.dart';
import '../services/user_profile_service.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;
  String _userName = 'User';

  final List<Widget> _screens = [
    const DashboardScreen(),
    const DietPlanScreen(),
    const CheatTricksScreen(),
    const MealDatabaseScreen(),
    const GlucometerScannerScreen(),
    const DailyTrackerScreen(),
    const WeeklyReportScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final profileData = await UserProfileService.getProfileData();
    setState(() {
      _userName = profileData['name'] ?? 'User';
    });
  }

  String _getInitials() {
    if (_userName.isEmpty || _userName == 'User') return 'U';
    final parts = _userName.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return _userName.substring(0, 1).toUpperCase();
  }

  Widget _buildNavigationDrawer() {
    return Drawer(
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            decoration: BoxDecoration(
              color: AppColors.primary,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.favorite,
                  color: AppColors.white,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'Health Dashboard',
                  style: AppTextStyles.heading4.copyWith(
                    color: AppColors.white,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close, color: AppColors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          // User Profile Section
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: AppColors.textLight,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      _getInitials(),
                      style: AppTextStyles.heading4.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _userName,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Welcome Back!',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const Divider(),

          // Navigation Menu
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(Icons.dashboard, 'Dashboard', () {
                  setState(() => _currentIndex = 0);
                  Navigator.pop(context);
                }),
                _buildDrawerItem(Icons.restaurant_menu, 'Diet Plan', () {
                  setState(() => _currentIndex = 1);
                  Navigator.pop(context);
                }),
                _buildDrawerItem(Icons.lightbulb, 'Cheat Tricks', () {
                  setState(() => _currentIndex = 2);
                  Navigator.pop(context);
                }),
                _buildDrawerItem(Icons.storage, 'Meal Database', () {
                  setState(() => _currentIndex = 3);
                  Navigator.pop(context);
                }),
                _buildDrawerItem(Icons.person, 'Profile', () {
                  setState(() => _currentIndex = 7);
                  Navigator.pop(context);
                }),
                _buildDrawerItem(Icons.camera_alt, 'Glucometer Scanner', () {
                  setState(() => _currentIndex = 4);
                  Navigator.pop(context);
                }),
                _buildDrawerItem(Icons.favorite, 'Daily Tracker', () {
                  setState(() => _currentIndex = 5);
                  Navigator.pop(context);
                }),
                _buildDrawerItem(Icons.analytics, 'Weekly Report', () {
                  setState(() => _currentIndex = 6);
                  Navigator.pop(context);
                }),
              ],
            ),
          ),

          const Divider(),

          // Sign Out Button
          Padding(
            padding: const EdgeInsets.all(16),
            child: CustomButton(
              text: 'Sign Out',
              onPressed: () {
                // Handle sign out
              },
              backgroundColor: AppColors.error,
              icon: Icons.exit_to_app,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textPrimary),
      title: Text(
        title,
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textPrimary,
        ),
      ),
      onTap: onTap,
    );
  }

  final List<NavigationItem> _navigationItems = [
    NavigationItem(
      icon: Icons.dashboard_outlined,
      activeIcon: Icons.dashboard,
      label: 'Dashboard',
    ),
    NavigationItem(
      icon: Icons.restaurant_menu_outlined,
      activeIcon: Icons.restaurant_menu,
      label: 'Diet Plan',
    ),
    NavigationItem(
      icon: Icons.lightbulb_outline,
      activeIcon: Icons.lightbulb,
      label: 'Cheat Tricks',
    ),
    NavigationItem(
      icon: Icons.storage_outlined,
      activeIcon: Icons.storage,
      label: 'Meal DB',
    ),
    NavigationItem(
      icon: Icons.camera_alt_outlined,
      activeIcon: Icons.camera_alt,
      label: 'Scanner',
    ),
    NavigationItem(
      icon: Icons.track_changes_outlined,
      activeIcon: Icons.track_changes,
      label: 'Tracker',
    ),
    NavigationItem(
      icon: Icons.analytics_outlined,
      activeIcon: Icons.analytics,
      label: 'Reports',
    ),
    NavigationItem(
      icon: Icons.person_outline,
      activeIcon: Icons.person,
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          // If not on dashboard, navigate to dashboard
          if (_currentIndex != 0) {
            setState(() {
              _currentIndex = 0;
            });
          }
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        drawer: _buildNavigationDrawer(),
        body: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowLight.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            child: Container(
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _navigationItems.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  final isSelected = _currentIndex == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary.withOpacity(0.1)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isSelected ? item.activeIcon : item.icon,
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.textHint,
                            size: 24,
                          ).animate(target: isSelected ? 1 : 0).scale(
                                duration: 200.ms,
                                curve: Curves.easeInOut,
                              ),
                          const SizedBox(height: 2),
                          Text(
                            item.label,
                            style: AppTextStyles.caption.copyWith(
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.textHint,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ).animate(target: isSelected ? 1 : 0).fadeIn(
                                duration: 200.ms,
                              ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NavigationItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  NavigationItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}
