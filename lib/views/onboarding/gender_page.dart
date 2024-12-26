import 'package:apply_at_supono/constants/app_colors.dart';
import 'package:apply_at_supono/constants/text_styles.dart';
import 'package:flutter/material.dart';

class GenderPage extends StatefulWidget {
  final Function(String) onNext;

  const GenderPage({
    super.key,
    required this.onNext,
  });

  @override
  State<GenderPage> createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  String? selectedGender;

  Widget _buildGenderButton(String gender) {
    final isSelected = selectedGender == gender;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGender = gender;
        });
        widget.onNext(gender);
      },
      child: Container(
        width: double.infinity,
        height: 60,
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: AppColors.blackTransparent,
          border: Border.all(
            color: isSelected ? AppColors.white : AppColors.gray,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            gender,
            style: TextStyle(
              color: isSelected ? AppColors.white : AppColors.gray,
              fontSize: 20,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Which gender do \nyou identify as?",
                style: AppTextStyles.titleLarge,
              ),
              const SizedBox(height: 14),
              Text(
                "Your gender helps us find the right \nmatches for you.",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.subtitleGray,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildGenderButton('Male'),
                  _buildGenderButton('Female'),
                  _buildGenderButton('Other'),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ],
    );
  }
}
