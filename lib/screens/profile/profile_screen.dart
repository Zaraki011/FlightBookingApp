import 'package:flightbookapp/core/res/styles/app_theme.dart';
import 'package:flightbookapp/core/services/api_service.dart';
import 'package:flightbookapp/screens/auth/login_screen.dart';
import 'package:flightbookapp/screens/auth/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:gap/gap.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoading = true;
  bool _isLoggedIn = false;
  Map<String, dynamic>? _userProfile;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    try {
      final token = await ApiService.getToken();
      if (token != null) {
        final profile = await ApiService.getUserProfile();
        setState(() {
          _isLoggedIn = true;
          _userProfile = profile;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoggedIn = false;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoggedIn = false;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _isLoggedIn
              ? _buildLoggedInView()
              : _buildLoginOptions(),
    );
  }

  Widget _buildLoginOptions() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey.shade200,
                child: Icon(
                  FluentSystemIcons.ic_fluent_person_regular,
                  size: 60,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            const Gap(30),
            Text(
              'Welcome to FlightBook',
              style: AppTheme.headLineStyle1,
              textAlign: TextAlign.center,
            ),
            const Gap(10),
            Text(
              'Sign in or create an account to manage your bookings and access exclusive offers.',
              style: AppTheme.textStyle,
              textAlign: TextAlign.center,
            ),
            const Gap(40),
            // Sign in button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                padding: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Sign In',
                style: AppTheme.textStyle.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Gap(15),
            // Sign up button
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterScreen()),
                );
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(15),
                side: BorderSide(color: AppTheme.primaryColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Create Account',
                style: AppTheme.textStyle.copyWith(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoggedInView() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Profile header
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: AppTheme.primaryColor,
                  child: Text(
                    _userProfile!['username'].substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Gap(15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${_userProfile!['first_name']} ${_userProfile!['last_name']}',
                        style: AppTheme.headLineStyle2,
                      ),
                      Text(
                        _userProfile!['email'],
                        style: AppTheme.headLineStyle4.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(30),

            // Menu items
            _buildMenuItem(
              icon: FluentSystemIcons.ic_fluent_ticket_regular,
              title: 'My Bookings',
              onTap: () {
                // Navigate to bookings
              },
            ),
            _buildMenuItem(
              icon: FluentSystemIcons.ic_fluent_payment_regular,
              title: 'Payment Methods',
              onTap: () {
                // Navigate to payment methods
              },
            ),
            _buildMenuItem(
              icon: FluentSystemIcons.ic_fluent_person_accounts_regular,
              title: 'Account Settings',
              onTap: () {
                // Navigate to account settings
              },
            ),
            _buildMenuItem(
              icon: Icons.help_outline,
              title: 'Help & Support',
              onTap: () {
                // Navigate to help
              },
            ),

            const Gap(20),
            const Divider(),
            const Gap(20),

            // Logout button
            _buildMenuItem(
              icon: Icons.exit_to_app,
              title: 'Log Out',
              isDestructive: true,
              onTap: () async {
                await ApiService.clearToken();
                setState(() {
                  _isLoggedIn = false;
                  _userProfile = null;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? Colors.red : Colors.black87,
      ),
      title: Text(
        title,
        style: AppTheme.textStyle.copyWith(
          color: isDestructive ? Colors.red : Colors.black87,
        ),
      ),
      trailing: isDestructive
          ? null
          : const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.black54,
            ),
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
    );
  }
}
