import 'package:apply_at_supono/constants/app_colors.dart';
import 'package:apply_at_supono/constants/text_styles.dart';
import 'package:apply_at_supono/views/camera_page.dart';
import 'package:apply_at_supono/widgets/guideline_container.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddPhotoPage extends StatelessWidget {
  final DateTime birthDate;
  final String nickname;
  final String gender;

  const AddPhotoPage({
    super.key,
    required this.birthDate,
    required this.nickname,
    required this.gender,
  });

  Future<void> _completeOnboarding(BuildContext context) async {
    // Mark first run as complete
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstRun', false);

    // Store user data
    await prefs.setString('nickname', nickname);
    await prefs.setString('birthDate', birthDate.toIso8601String());
    await prefs.setString('gender', gender);

    // Navigate to camera page and remove all previous routes
    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const CameraPage()),
        (route) => false,
      );
    }
  }

  Widget _buildCheckItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            Icons.check,
            color: AppColors.gray,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.guidelineItem,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Add a nice photo\nof yourself',
            style: AppTextStyles.titleLarge,
          ),
          const SizedBox(height: 58),
          ElevatedButton(
            onPressed: () => _completeOnboarding(context),
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(double.infinity, 50),
              backgroundColor: AppColors.white,
              foregroundColor: AppColors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Text(
              'Take your first photo',
              style: AppTextStyles.buttonText,
            ),
          ),
          const SizedBox(height: 50),
          GuidelineContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Make sure that your image',
                  style: AppTextStyles.guidelineTitle,
                ),
                const SizedBox(height: 16),
                _buildCheckItem('Shows your face clearly'),
                _buildCheckItem('Yourself only, no group pic'),
                _buildCheckItem('No fake pic, object or someone else'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
