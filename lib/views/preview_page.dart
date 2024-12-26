import 'dart:io';

import 'package:apply_at_supono/constants/app_colors.dart';
import 'package:apply_at_supono/views/settings_page.dart';
import 'package:apply_at_supono/widgets/banner_ad_widget.dart';
import 'package:apply_at_supono/widgets/circular_button.dart';
import 'package:flutter/material.dart';

class PreviewPage extends StatefulWidget {
  final String imagePath;

  const PreviewPage({super.key, required this.imagePath});

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Image preview
          Image.file(
            File(widget.imagePath),
            fit: BoxFit.cover,
          ),
          // Top buttons
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircularButton(
                      icon: Icons.close,
                      onTap: () => Navigator.pop(context),
                    ),
                    CircularButton(
                      icon: Icons.settings_outlined,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsPage(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Banner ad at bottom
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BannerAdWidget(),
          ),
        ],
      ),
    );
  }
}
