import 'package:intl/intl.dart';

extension ToStringDate on DateTime {
  String parseDate() {
    final df = new DateFormat('dd-MM-yyyy');
    return df.format(this);
  }
}
