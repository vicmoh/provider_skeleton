extension DateExtension on DateTime {
  /// Get the month of the year
  /// if [from] param is empty it will get the current time.
  String getTheMonthOfTheYear({
    DateTime from,
    bool shortFormat = false,
  }) {
    var currentMonth = DateTime.now().month;
    if (from != null) currentMonth = from.month;
    if (currentMonth == 1) return (!shortFormat) ? 'January' : 'Jan';
    if (currentMonth == 2) return (!shortFormat) ? 'February' : 'Feb';
    if (currentMonth == 3) return (!shortFormat) ? 'March' : 'Mar';
    if (currentMonth == 4) return (!shortFormat) ? 'April' : 'Apr';
    if (currentMonth == 5) return (!shortFormat) ? 'May' : 'May';
    if (currentMonth == 6) return (!shortFormat) ? 'June' : 'Jun';
    if (currentMonth == 7) return (!shortFormat) ? 'July' : 'Jul';
    if (currentMonth == 8) return (!shortFormat) ? 'August' : 'Aug';
    if (currentMonth == 9) return (!shortFormat) ? 'September' : 'Sep';
    if (currentMonth == 10) return (!shortFormat) ? 'October' : 'Oct';
    if (currentMonth == 11) return (!shortFormat) ? 'November' : 'Nov';
    return (!shortFormat) ? 'December' : 'Dec';
  }

  /// Get the current day of the week or from an object,
  /// if [from] param is empty it will get current time.
  String getTheDayOfTheWeek({DateTime from, bool longFormat = false}) {
    var currentDay = DateTime.now().weekday;
    if (from != null) currentDay = from.weekday;
    if (currentDay == 1) return (longFormat) ? 'Monday' : 'Mon';
    if (currentDay == 2) return (longFormat) ? 'Tuesday' : 'Tue';
    if (currentDay == 3) return (longFormat) ? 'Wednesday' : 'Wed';
    if (currentDay == 4) return (longFormat) ? 'Thursday' : 'Thu';
    if (currentDay == 5) return (longFormat) ? 'Friday' : 'Fri';
    if (currentDay == 6) return (longFormat) ? 'Saturday' : 'Sat';
    return (longFormat) ? 'Sunday' : 'Sun';
  }

  /// Get the current time of day or from an object,
  /// if [from] param is empty it will get current time.
  String getTheTimeOfTheDay({
    DateTime from,
    bool isTwentyHourClock = true,
  }) {
    var hour = DateTime.now().hour.toString();
    var minute = DateTime.now().minute.toString();
    if (from != null) {
      hour = from.hour.toString();
      minute = from.minute.toString();
    }
    // Check if it is twenty hour clock.
    if (!isTwentyHourClock) {
      String amPmString = 'AM';
      int hour12 = from.hour;
      int min12 = from.minute;
      if (from.hour >= 12) {
        amPmString = 'PM';
        hour12 = (from.hour - 12).abs();
        min12 = from.minute;
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

  /// Get time posted for posts and comments where
  /// format is ["day time"] ex. ["wed 11:11"],
  /// if param is empty it will get current time.
  String getDayAndTimeFormat({DateTime from}) {
    return this.getTheDayOfTheWeek(from: from) +
        " " +
        this.getTheTimeOfTheDay(from: from);
  }

  /// Function to get time difference,
  /// ex. it will return ["5h"] if time difference 5h,
  /// this is mostly used in social media app to show the time posted.
  String getTimeDifference({DateTime from, bool longFormat = false}) {
    int diffByMins = DateTime.now().difference(from).inMinutes;
    final String longMin = (diffByMins == 1) ? ' minute' : ' minutes';
    final String minute = (longFormat) ? longMin : 'm';
    if (diffByMins < 60) return diffByMins.toString() + minute;
    // By hours
    int diffByHours = DateTime.now().difference(from).inHours;
    final String longHour = (diffByHours == 1) ? ' hour' : ' hours';
    final String hour = (longFormat) ? longHour : 'h';
    if (diffByHours < 24) return diffByHours.toString() + hour;
    // By days
    int diffByDays = DateTime.now().difference(from).inDays;
    final String longDay = (diffByDays == 1) ? ' day' : ' days';
    final String day = (longFormat) ? longDay : 'd';
    if (diffByDays < 365) return diffByDays.toString() + day;
    // By years
    int diffByYears = diffByDays / 365 as int;
    final String longYear = (diffByYears == 1) ? ' day' : ' days';
    final String year = (longFormat) ? longYear : 'd';
    return diffByYears.toStringAsFixed(0) + year;
  }

  /// Get a complete readable string of the date time
  /// in format of [MONTH, DAY, YEAR at TIME].
  String dateTimeToString(DateTime dateTime) {
    if (dateTime == null) return '';
    var month = this.getTheMonthOfTheYear(from: dateTime);
    var time = this.getTheTimeOfTheDay(from: dateTime);
    return '$month ${dateTime?.day}, ${dateTime?.year} ' + 'at $time';
  }
}
