import 'dart:io';

import 'package:apply_at_supono/constants/app_colors.dart';
import 'package:apply_at_supono/utils/error_handler.dart';
import 'package:apply_at_supono/utils/image_utils.dart';
import 'package:apply_at_supono/views/preview_page.dart';
import 'package:apply_at_supono/widgets/circular_button.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _controller;
  bool _isCameraInitialized = false;
  bool _isFrontCamera = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) return;

      _controller = CameraController(
        cameras[_isFrontCamera ? 1 : 0],
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      await _controller!.initialize();
      if (!mounted) return;

      setState(() {
        _isCameraInitialized = true;
      });
    } catch (e) {
      ErrorHandler.handleError(
        context,
        e,
        fallbackMessage: 'Failed to initialize camera',
      );
    }
  }

  Future<void> _switchCamera() async {
    try {
      setState(() {
        _isFrontCamera = !_isFrontCamera;
        _isCameraInitialized = false;
      });
      await _controller?.dispose();
      await _initCamera();
    } catch (e) {
      ErrorHandler.handleError(
        context,
        e,
        fallbackMessage: 'Failed to switch camera',
      );
    }
  }

  Future<void> _takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    try {
      final image = await _controller!.takePicture();
      if (!mounted) return;

      // Compress image before preview
      final compressedImage = await ImageUtils.compressImage(File(image.path));

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PreviewPage(imagePath: compressedImage.path),
        ),
      );
    } catch (e) {
      ErrorHandler.handleError(
        context,
        e,
        fallbackMessage: 'Failed to take picture',
      );
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isCameraInitialized || _controller == null) {
      return Scaffold(
        backgroundColor: AppColors.black,
        body: const Center(
          child: CircularProgressIndicator(
            color: AppColors.white,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (_controller != null)
            // Camera Preview
            CameraPreview(_controller!),

          // Top Controls
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
                      icon: Icons.arrow_back_ios_new_rounded,
                      onTap: () {
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                    CircularButton(
                      icon: Icons.cameraswitch_rounded,
                      onTap: _switchCamera,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Shutter Button
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: _takePicture,
              child: Center(
                child: Container(
                  width: 84,
                  height: 84,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.4),
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withValues(alpha: 0.2),
                          blurRadius: 15,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
