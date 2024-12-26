import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDate(String isoDate) {
    if (isoDate.isEmpty) return '';
    final date = DateTime.parse(isoDate);
    final formatter = DateFormat('d MMM y');
    return formatter.format(date);
  }
}
