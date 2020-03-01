extension DateTimeExtension on DateTime {
  /// Get the month of the year string.
  /// For example if the month is 1 it will
  /// return 'Jan'. If [longFormat] is true
  /// it will return 'January'.
  String getMonth({bool longFormat = false}) {
    var currentMonth = DateTime.now().month;
    if (this != null) currentMonth = this.month;
    if (currentMonth == 1) return (longFormat) ? 'January' : 'Jan';
    if (currentMonth == 2) return (longFormat) ? 'February' : 'Feb';
    if (currentMonth == 3) return (longFormat) ? 'March' : 'Mar';
    if (currentMonth == 4) return (longFormat) ? 'April' : 'Apr';
    if (currentMonth == 5) return (longFormat) ? 'May' : 'May';
    if (currentMonth == 6) return (longFormat) ? 'June' : 'Jun';
    if (currentMonth == 7) return (longFormat) ? 'July' : 'Jul';
    if (currentMonth == 8) return (longFormat) ? 'August' : 'Aug';
    if (currentMonth == 9) return (longFormat) ? 'September' : 'Sep';
    if (currentMonth == 10) return (longFormat) ? 'October' : 'Oct';
    if (currentMonth == 11) return (longFormat) ? 'November' : 'Nov';
    return (longFormat) ? 'December' : 'Dec';
  }

  /// Get the current day of the week or from an object,
  /// If the day is 1 then it return 'Mon'. If
  /// [longFormat] is true, it will return 'Monday'.
  String getDay({bool longFormat = false}) {
    var currentDay = DateTime.now().weekday;
    if (this != null) currentDay = this.weekday;
    if (currentDay == 1) return (longFormat) ? 'Monday' : 'Mon';
    if (currentDay == 2) return (longFormat) ? 'Tuesday' : 'Tue';
    if (currentDay == 3) return (longFormat) ? 'Wednesday' : 'Wed';
    if (currentDay == 4) return (longFormat) ? 'Thursday' : 'Thu';
    if (currentDay == 5) return (longFormat) ? 'Friday' : 'Fri';
    if (currentDay == 6) return (longFormat) ? 'Saturday' : 'Sat';
    return (longFormat) ? 'Sunday' : 'Sun';
  }

  /// Get the current time of day or from an object,
  /// By default it will return 24 hour clock string.
  /// For ex. '20:00' if [isTwelveHourClock] is true,
  /// it will return '8:00 PM'.
  String getTime({bool isTwelveHour = false}) {
    var hour = DateTime.now().hour.toString();
    var minute = DateTime.now().minute.toString();
    if (this != null) {
      hour = this.hour.toString();
      minute = this.minute.toString();
    }
    // Check if it is twenty hour clock.
    if (isTwelveHour) {
      String amPmString = 'AM';
      int hour12 = this.hour;
      int min12 = this.minute;
      if (this.hour >= 12) {
        amPmString = 'PM';
        hour12 = (this.hour - 12).abs();
        min12 = this.minute;
      }
      String hour12String = hour12 == 0 ? '12' : '$hour12';
      String min12String =
          min12.toString().length == 1 ? ('0$min12') : min12.toString();
      return '$hour12String:$min12String $amPmString';
    }
    // Add another zero if the time is 0 hour.
    if (hour.length == 1) hour = '0' + hour;
    if (minute.length == 1) minute = '0' + minute;
    if (hour[0] == '0' && hour[1] != '0') hour = hour.substring(1, hour.length);
    return '$hour:$minute';
  }

  /// Function to get time difference,
  /// ex. it will return "5h" if time difference 5 hours.,
  /// If [longFormat] is true. It will show "1 hours" instead of "1h".
  String getTimeDifference({bool longFormat = false}) {
    int diffByMins = DateTime.now().difference(this).inMinutes;
    final String longMin = (diffByMins == 1) ? ' minute' : ' minutes';
    final String minute = (longFormat) ? longMin : 'm';
    if (diffByMins < 60) return diffByMins.toString() + minute;
    // By hours
    int diffByHours = DateTime.now().difference(this).inHours;
    final String longHour = (diffByHours == 1) ? ' hour' : ' hours';
    final String hour = (longFormat) ? longHour : 'h';
    if (diffByHours < 24) return diffByHours.toString() + hour;
    // By days
    int diffByDays = DateTime.now().difference(this).inDays;
    final String longDay = (diffByDays == 1) ? ' day' : ' days';
    final String day = (longFormat) ? longDay : 'd';
    if (diffByDays < 365) return diffByDays.toString() + day;
    // By years
    int diffByYears = diffByDays / 365 as int;
    final String longYear = (diffByYears == 1) ? ' day' : ' days';
    final String year = (longFormat) ? longYear : 'd';
    return diffByYears.toStringAsFixed(0) + year;
  }

  /// Get day and time in the format where
  /// "<day> <time>" for ex. "Wed 11:11".
  String toDayAndTime() => this.getDay() + " " + this.getTime();

  /// Get the full month, date and time, for ex. 'Jan 7 at 12:30 PM'.
  String toMonthDateAtTime() =>
      '${this.getMonth(longFormat: true)} ${this.day} at ${this.getTime(isTwelveHour: true)}';

  /// Get a complete readable string of the date time
  /// in format of "<month> <day>, <year>" for ex.
  /// December 13, 1995. If [asNumber] is true, then
  /// it will return in the format of "<month>/<day>/<year>",
  /// for ex. "11/11/11".
  String toMonthDayAndYear({bool isMonthFullString = false, asNumber = false}) {
    if (asNumber) return '${this.month}/${this.day}/${this.year}';
    return '${this.getMonth(longFormat: isMonthFullString)} ${this.day}, ${this.year} ';
  }
}
