import 'package:flutter/material.dart';

/// This class contains utilities that uses
/// [Material] libraries. Some ex. of utilities [Widget]
/// in this library are popups, dialogs, and snack bar.
/// [ableToPickUntil] is the number of year you can choose
/// from to todays date to [ableToPickUntil].
class MaterialUtil {
  /// Popups up a date time picker.
  /// If successful it will return [DateTime]
  /// else fails, it will return null.
  static Future<DateTime> selectDateOnPopup(
    BuildContext context, {
    int ableToPickUntil = 10,
  }) async {
    var now = DateTime.now();
    var current = DateTime(now.year, now.month, now.day);
    var next = DateTime(now.year + ableToPickUntil);
    DateTime date;
    TimeOfDay time;

    // Try selecting
    try {
      // Get the date
      date = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: current,
        lastDate: next,
      );
      // Get the time
      time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
    } catch (err) {
      print('selectDateOnPopup(): Catch: err');
    }

    if (date == null || time == null) return null;
    print('Date is $date');
    print('Time is $time');
    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }
}
