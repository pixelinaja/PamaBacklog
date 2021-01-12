import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

extension ToStringDate on DateTime {
  String parseDate({@required String dateFormat}) {
    final df = new DateFormat(dateFormat);
    return df.format(this);
  }
}
