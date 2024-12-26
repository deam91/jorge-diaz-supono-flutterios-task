import 'package:apply_at_supono/constants/app_colors.dart';
import 'package:apply_at_supono/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BirthdayPage extends StatefulWidget {
  final Function(DateTime) onNext;

  const BirthdayPage({
    super.key,
    required this.onNext,
  });

  @override
  State<BirthdayPage> createState() => _BirthdayPageState();
}

class _BirthdayPageState extends State<BirthdayPage> {
  final _dayController = TextEditingController();
  final _monthController = TextEditingController();
  final _yearController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final FocusNode _dayFocus = FocusNode();
  final FocusNode _monthFocus = FocusNode();
  final FocusNode _yearFocus = FocusNode();

  bool _isDateValid() {
    if (_dayController.text.isEmpty ||
        _monthController.text.isEmpty ||
        _yearController.text.isEmpty) {
      return false;
    }

    try {
      final day = int.parse(_dayController.text);
      final month = int.parse(_monthController.text);
      final year = int.parse(_yearController.text);

      final birthDate = DateTime(year, month, day);
      final today = DateTime.now();

      // Check if it's a valid date
      if (birthDate.year != year ||
          birthDate.month != month ||
          birthDate.day != day) {
        return false;
      }

      // Calculate age
      final age = today.year -
          birthDate.year -
          (today.month < birthDate.month ||
                  (today.month == birthDate.month && today.day < birthDate.day)
              ? 1
              : 0);

      return age >= 18;
    } catch (e) {
      return false;
    }
  }

  String? _validateDay(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }
    final day = int.tryParse(value);
    if (day == null || day < 1 || day > 31) {
      return 'Invalid day';
    }
    // Validate day based on month
    final month = int.tryParse(_monthController.text);
    if (month != null) {
      final daysInMonth = DateTime(
        int.tryParse(_yearController.text) ?? DateTime.now().year,
        month + 1,
        0,
      ).day;
      if (day > daysInMonth) {
        return 'Invalid for month';
      }
    }
    return _isDateValid() ? null : 'Must be 18+';
  }

  String? _validateMonth(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }
    final month = int.tryParse(value);
    if (month == null || month < 1 || month > 12) {
      return 'Invalid month';
    }
    return _isDateValid() ? null : 'Must be 18+';
  }

  String? _validateYear(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }
    final year = int.tryParse(value);
    final currentYear = DateTime.now().year;
    if (year == null || year < 1900 || year > currentYear) {
      return 'Invalid year';
    }
    return _isDateValid() ? null : 'Must be 18+';
  }

  bool get _isValid {
    if (!(_formKey.currentState?.validate() ?? false)) return false;
    final day = int.tryParse(_dayController.text) ?? 0;
    final month = int.tryParse(_monthController.text) ?? 0;
    final year = int.tryParse(_yearController.text) ?? 0;

    // Check for valid date (e.g., February 31st)
    try {
      DateTime(year, month, day);
      return true;
    } catch (_) {
      return false;
    }
  }

  DateTime? get selectedDate {
    if (!_isValid) return null;
    return DateTime(
      int.parse(_yearController.text),
      int.parse(_monthController.text),
      int.parse(_dayController.text),
    );
  }

  Widget _buildDateField(
    String hint,
    TextEditingController controller,
    int maxLength,
    String? label, {
    required FocusNode focusNode,
    FocusNode? nextFocus,
    String? Function(String?)? validator,
  }) {
    return Column(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: maxLength > 2 ? 120 : 80,
            maxHeight: 60,
          ),
          child: TextFormField(
            controller: controller,
            focusNode: focusNode,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(maxLength),
            ],
            style: AppTextStyles.titleXLarge,
            validator: validator,
            autovalidateMode: AutovalidateMode.onUnfocus,
            onTapOutside: (_) => FocusScope.of(context).unfocus(),
            onChanged: (value) {
              setState(() {});
              if (value.length == maxLength) {
                if (validator?.call(value) == null && nextFocus != null) {
                  focusNode.unfocus();
                  FocusScope.of(context).requestFocus(nextFocus);
                }
              }
            },
            decoration: InputDecoration(
              filled: true,
              errorStyle: const TextStyle(fontSize: 0),
              fillColor: AppColors.blackTransparent,
              hintText: hint,
              hintStyle: AppTextStyles.titleXLarge.copyWith(
                color: AppColors.gray,
                fontWeight: FontWeight.w800,
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
                borderSide: BorderSide(color: AppColors.white),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.red),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            ),
          ),
        ),
        if (label != null) ...[
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: AppColors.white.withValues(alpha: 0.5),
              fontSize: 14,
            ),
          ),
        ],
      ],
    );
  }

  @override
  void dispose() {
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    _dayFocus.dispose();
    _monthFocus.dispose();
    _yearFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final insets = MediaQuery.viewInsetsOf(context);
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "When's your\nbirthday?",
                  style: AppTextStyles.titleLarge,
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildDateField(
                      '21',
                      _dayController,
                      2,
                      'Day',
                      focusNode: _dayFocus,
                      nextFocus: _monthFocus,
                      validator: _validateDay,
                    ),
                    const SizedBox(width: 14),
                    _buildDateField(
                      '11',
                      _monthController,
                      2,
                      'Month',
                      focusNode: _monthFocus,
                      nextFocus: _yearFocus,
                      validator: _validateMonth,
                    ),
                    const SizedBox(width: 14),
                    _buildDateField(
                      '2023',
                      _yearController,
                      4,
                      'Year',
                      focusNode: _yearFocus,
                      validator: _validateYear,
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
        if (_isValid)
          Positioned(
            bottom: 30 + insets.bottom,
            right: 25,
            child: GestureDetector(
              onTap: () => widget.onNext(selectedDate!),
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
