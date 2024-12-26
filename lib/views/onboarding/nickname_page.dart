import 'package:apply_at_supono/constants/app_colors.dart';
import 'package:apply_at_supono/constants/text_styles.dart';
import 'package:flutter/material.dart';

class NicknamePage extends StatefulWidget {
  final Function(String) onNext;

  const NicknamePage({
    super.key,
    required this.onNext,
  });

  @override
  State<NicknamePage> createState() => _NicknamePageState();
}

class _NicknamePageState extends State<NicknamePage> {
  final TextEditingController _nicknameController = TextEditingController();

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  Widget _buildNicknameField() {
    return TextField(
      controller: _nicknameController,
      style: AppTextStyles.titleLarge,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.blackTransparent,
        hintText: 'John Smith',
        hintStyle: TextStyle(
          color: AppColors.gray,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.gray),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.gray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.gray),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
      ),
      onChanged: (_) => setState(() {}),
    );
  }

  @override
  Widget build(BuildContext context) {
    final insets = MediaQuery.viewInsetsOf(context);
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Choose your\nnickname",
                style: AppTextStyles.titleXLarge,
              ),
              const SizedBox(height: 40),
              _buildNicknameField(),
              const SizedBox(height: 40),
            ],
          ),
        ),
        if (_nicknameController.text.isNotEmpty)
          Positioned(
            bottom: 30 + insets.bottom,
            right: 25,
            child: GestureDetector(
              onTap: () => widget.onNext(_nicknameController.text),
              child: Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white,
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  color: AppColors.black,
                  size: 30,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
