import 'package:intl/intl.dart';

var formatter = new DateFormat('dd-MMMM-yyyy H:m');

String getStringFromDateTime(DateTime time) {
  return formatter.format(time);
}

DateTime getDateTimeFromString(String dateString) {
  return formatter.parse(dateString);
}
