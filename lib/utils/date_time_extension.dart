import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  static final DateFormat apiFormat = DateFormat('yyyy-MM-dd');

  String toApiFormat() => apiFormat.format(this);
}
