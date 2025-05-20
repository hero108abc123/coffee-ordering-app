import 'package:flutter/material.dart';
import 'package:flutter_application/config/theme/app_pallate.dart';
import 'package:flutter_application/core/common/entities/user_profile.dart';
import 'package:flutter_application/features/home/presentation/screens/edit_profile_screen.dart';
import 'package:flutter_application/features/home/presentation/screens/purchase_history_screen.dart';
import 'package:flutter_application/features/home/presentation/screens/settings_screen.dart';
import 'package:flutter_application/features/home/presentation/widgets/common_button.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final Profile user = Profile(
    id: 1,
    username: 'Nguyen Van A',
    mobileNumber: '0123456789',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallate.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppPallate.backgroundColor,
        title: Text(user.username),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CommonButton(
              title: 'Edit Profile',
              onTab: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const EditProfileScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            CommonButton(
              title: 'View Purchase History',
              onTab: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PurchaseHistoryScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            CommonButton(
              title: 'Settings',
              onTab: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SettingsScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            CommonButton(
              title: 'Logout',
              onTab: () {
                // Handle logout
              },
            ),
          ],
        ),
      ),
    );
  }
}
