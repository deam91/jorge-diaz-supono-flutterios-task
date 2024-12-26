import 'dart:math';

import 'package:apply_at_supono/views/onboarding/add_photo_page.dart';
import 'package:apply_at_supono/views/onboarding/birthday_page.dart';
import 'package:apply_at_supono/views/onboarding/gender_page.dart';
import 'package:apply_at_supono/views/onboarding/nickname_page.dart';
import 'package:flutter/material.dart';

class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({super.key});

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  final PageController _pageController = PageController();
  double _backgroundOffset = 0;
  double _currentPage = 0;

  // Store user data
  DateTime? _birthDate;
  String? _nickname;
  String? _gender;

  double get _progress {
    if (_pageController.hasClients) {
      return ((_pageController.page ?? 0) + 1) / 4 * 100;
    }
    return 25;
  }

  void _goBack() {
    if (_pageController.page! > 0) {
      _pageController
          .previousPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          )
          .then((_) => setState(() {
                _currentPage = _pageController.page ?? 0;
              }));
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_onScroll);
  }

  void _onScroll() {
    setState(() {
      // Calculate background offset based on page position
      _backgroundOffset = _pageController.page! * 0.6;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Animated background
          AnimatedPositioned(
            duration: const Duration(milliseconds: 0),
            left: -_backgroundOffset * 500,
            top: 0,
            bottom: 0,
            child: Image.asset(
              'assets/background.jpg',
              fit: BoxFit.fitHeight,
            ),
          ),
          // PageView with onboarding pages
          PageView(
            controller: _pageController,
            pageSnapping: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _OnboardingPage(
                child: BirthdayPage(
                  onNext: (date) {
                    setState(() => _birthDate = date);
                    _pageController
                        .nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        )
                        .then((_) => setState(() {
                              _currentPage = _pageController.page ?? 0;
                            }));
                  },
                ),
              ),
              _OnboardingPage(
                child: NicknamePage(
                  onNext: (nickname) {
                    setState(() => _nickname = nickname);
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
              _OnboardingPage(
                child: GenderPage(
                  onNext: (gender) {
                    setState(() => _gender = gender);
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
              if (_birthDate != null && _nickname != null && _gender != null)
                _OnboardingPage(
                  child: AddPhotoPage(
                    birthDate: _birthDate!,
                    nickname: _nickname!,
                    gender: _gender!,
                  ),
                ),
            ],
          ),
          // Top navigation bar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back button
                  GestureDetector(
                    onTap: _goBack,
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: const Color(0xff959595), width: .5),
                      ),
                      child: Icon(
                        _currentPage > 0
                            ? Icons.arrow_back_ios_new_rounded
                            : Icons.close,
                        color: const Color(0xff959595),
                      ),
                    ),
                  ),
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CustomPaint(
                          size: const Size(32, 32),
                          painter: CircularProgressPainter(_progress),
                        ),
                        Text(
                          '${_progress.toInt()}%',
                          style: const TextStyle(
                            color: Color(0xff959595),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  final Widget child;

  const _OnboardingPage({required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: 49 + kToolbarHeight),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  final double progress;

  CircularProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    // Background circle
    final bgPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Progress arc
    final progressPaint = Paint()
      ..color = const Color(0xff959595)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw background circle
    canvas.drawCircle(center, radius, bgPaint);

    // Draw progress arc
    final progressAngle = 2 * pi * (progress / 100);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2, // Start from top
      progressAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CircularProgressPainter oldDelegate) =>
      progress != oldDelegate.progress;
}
