import 'package:apply_at_supono/constants/app_colors.dart';
import 'package:apply_at_supono/constants/text_styles.dart';
import 'package:apply_at_supono/utils/date_formatter.dart';
import 'package:apply_at_supono/widgets/circular_button.dart';
import 'package:apply_at_supono/widgets/settings_group.dart';
import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isAdRemoved = false;
  String _nickname = '';
  String _birthDate = '';
  String _gender = '';

  final RateMyApp _rateMyApp = RateMyApp(
    minDays: 0,
    minLaunches: 0,
    remindDays: 7,
    remindLaunches: 10,
  );

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _initRateMyApp();
  }

  Future<void> _initRateMyApp() async {
    await _rateMyApp.init();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isAdRemoved = prefs.getBool('adRemoved') ?? false;
      _nickname = prefs.getString('nickname') ?? '';
      _birthDate = prefs.getString('birthDate') ?? '';
      _gender = prefs.getString('gender') ?? '';
    });
  }

  Future<void> _showUnlockDialog() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Unlock App'),
        content: Text(
          !_isAdRemoved
              ? 'Do you want to unlock the app and remove ads?'
              : 'Do you want to lock the app and include ads?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes'),
          ),
        ],
      ),
    );

    if (result == true) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('adRemoved', !_isAdRemoved);
      setState(() {
        _isAdRemoved = !_isAdRemoved;
      });
    }
  }

  Widget _buildSettingItem({
    required String title,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
        child: Text(
          title,
          style: AppTextStyles.settingItem,
        ),
      ),
    );
  }

  Widget _buildAccountItem({
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyles.accountItemTitle),
          Text(value, style: AppTextStyles.accountItemValue),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        leadingWidth: 60,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: CircularButton(
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: () => Navigator.pop(context),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Settings', style: AppTextStyles.settingsTitle),
              const SizedBox(height: 12),
              SettingsGroup(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildSettingItem(
                      title: !_isAdRemoved ? 'Unlock App' : 'Lock App',
                      onTap: _showUnlockDialog,
                    ),
                    Divider(color: AppColors.dividerColor, height: 1),
                    _buildSettingItem(
                      title: 'Rate Us',
                      onTap: () {
                        _rateMyApp.showRateDialog(
                          context,
                          title: 'Rate this app',
                          message:
                              'If you like this app, please take a little bit of your time to review it!',
                          rateButton: 'RATE',
                          noButton: 'NO THANKS',
                          laterButton: 'MAYBE LATER',
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Text('My Account', style: AppTextStyles.settingsTitle),
              const SizedBox(height: 12),
              SettingsGroup(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildAccountItem(
                      title: 'Username',
                      value: _nickname,
                    ),
                    Divider(color: AppColors.dividerColor, height: 1),
                    _buildAccountItem(
                      title: 'Birthday',
                      value: DateFormatter.formatDate(_birthDate),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
