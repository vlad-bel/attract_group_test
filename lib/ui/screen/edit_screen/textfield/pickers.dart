import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<DateTime> showAndroidPickers(BuildContext context) async {
  var date = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2020),
    lastDate: DateTime(2025),
  );

  if (date == null) {
    return null;
  }

  var time = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );

  var selectedDateTime = DateTime.utc(
    date.year,
    date.month,
    date.day,
    time.hour,
    time.minute,
  );

  return selectedDateTime;
}

Future<DateTime> showIosPickeres(BuildContext context) async {
  DateTime date;

  await _showBottomSheet(
    context,
    Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: CupertinoButton(
            child: Text('pick'),
            onPressed: () {
              if (date == null) {
                date = DateTime.now();
              }
              Navigator.of(context).pop(date);
            },
          ),
        ),
        Container(
          height: 200,
          child: CupertinoDatePicker(
            initialDateTime: DateTime.now(),
            onDateTimeChanged: (DateTime newDate) {
              date = newDate;
            },
            use24hFormat: true,
            minimumYear: 2020,
            maximumYear: 2025,
            minuteInterval: 1,
            mode: CupertinoDatePickerMode.date,
          ),
        ),
      ],
    ),
  );

  if (date == null) {
    return null;
  }

  DateTime time;
  await _showBottomSheet(
    context,
    Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: CupertinoButton(
            child: Text('pick'),
            onPressed: () {
              if (time == null) {
                time = DateTime.now();
              }
              Navigator.of(context).pop(time);
            },
          ),
        ),
        Container(
          height: 200,
          child: CupertinoDatePicker(
            initialDateTime: DateTime.now(),
            onDateTimeChanged: (DateTime newTime) {
              time = newTime;
            },
            use24hFormat: true,
            minuteInterval: 1,
            mode: CupertinoDatePickerMode.time,
          ),
        ),
      ],
    ),
  );

  var selectedDateTime = DateTime.utc(
    date.year,
    date.month,
    date.day,
    time.hour,
    time.minute,
  );

  return selectedDateTime;
}

Future _showBottomSheet(
  BuildContext context,
  Widget child,
) {
  return showModalBottomSheet(
    context: context,
    builder: (BuildContext builder) {
      return Container(
        height: MediaQuery.of(context).copyWith().size.height / 2.7,
        child: child,
      );
    },
  );
}
