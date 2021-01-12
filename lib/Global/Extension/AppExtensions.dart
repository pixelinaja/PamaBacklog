import 'package:intl/intl.dart';

extension ToStringDate on DateTime {
  String parseDate({String dateFormat}) {
    final df = new DateFormat(dateFormat);
    return df.format(this);
  }
}
