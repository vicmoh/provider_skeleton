import 'dart:math';

/// Utility class contains static
/// helper functions to help with general task
/// such as manipulating strings, times or numbers.
class Util {
  //-------------------------------------------------
  // String Functions
  //-------------------------------------------------

  /// Remove alphabets in the digit values string.
  static String removeAlpha(String val) {
    var temp = val.replaceAll(RegExp('[^0-9.]'), '');
    return temp;
  }

  /// Function to determine whether string has white space.
  /// This include [newline], [spaces] and [tabs]. As well
  /// as [Symbols].
  static bool isAlphaDigitString(String val) {
    assert(val != null);
    return val?.contains(RegExp(r'[^A-Za-z0-9]'));
  }

  /// Remove duplicate spaces, tabs new lines.
  static String trimString(String val) {
    if (val == null) return val;
    String toReturn = val.trim();
    toReturn = toReturn.replaceAll(RegExp('  +'), ' ');
    toReturn = toReturn.replaceAll(RegExp('\t\t+'), '\t');
    toReturn = toReturn.replaceAll(RegExp('\n\n\n+'), '\n\n');
    return toReturn;
  }

  /// Split the string in to list of lower string word.
  static List<String> indexable(String val) {
    if (val == null) return [];
    return Set.of(val
        .split(RegExp(r'[^A-Za-z0-9]'))
        .map((el) => el.toLowerCase())
        .where((el) => el != '')).toList();
  }

  /// Set string with ellipsis.
  static String stringEllipsis(String toBeShorted, int endIndex) {
    if (toBeShorted == null) return '';
    String temp = toBeShorted;
    if (temp.length >= endIndex) temp = temp.substring(0, endIndex - 3) + '...';
    return temp;
  }

  /// Convert string first letter to uppercase case, for example
  /// if [toBeConverted] value is 'hello' it returns 'Hello'.
  static String stringFirstCharToUpper(String toBeConverted) {
    if (toBeConverted == null) return '';
    var temp = toBeConverted.toLowerCase();
    String firstChar = temp.substring(0, 1).toUpperCase();
    return firstChar + temp.substring(1, temp.length);
  }

  /// Remove leading space for string.
  static String removeWhiteSpace(String toBeTrimmed) {
    if (toBeTrimmed == null) return '';
    String temp = toBeTrimmed;
    // Trim the leading white space
    temp = temp.replaceFirst(new RegExp(r"^\s+"), "");
    // Trim the trailing white space
    temp = temp.replaceFirst(new RegExp(r"\s+$"), "");
    // Return the result
    return temp;
  }

  /// Convert a [number] and represent
  /// it in '1k' instead of '1000' and other
  /// big number up to trillion.
  static String getShortNumRep(int number) {
    if (number == null) return '';
    // To shorten the code
    String theNumberToBeReturn = number.toString();
    var theNewShortNumber = (
      int toBeShorted,
      int shortedBy,
      String theLetterToRepresentTheNumber,
    ) {
      double shortRepresentNum = toBeShorted / shortedBy;
      String stringNum = shortRepresentNum.toString();
      stringNum = stringNum.substring(0, stringNum.indexOf(RegExp('\\.')) + 2);
      stringNum = stringNum + theLetterToRepresentTheNumber;
      return stringNum.replaceAll(".0", "");
    };

    // Conditions for the number of digits.
    if (number >= 1000)
      theNumberToBeReturn = theNewShortNumber(number, 1000, "k");
    if (number >= 1000000)
      theNumberToBeReturn = theNewShortNumber(number, 1000000, "m");
    if (number >= 1000000000)
      theNumberToBeReturn = theNewShortNumber(number, 1000000000, "b");
    if (number >= 1000000000000)
      theNumberToBeReturn = theNewShortNumber(number, 1000000000000, "t");
    return theNumberToBeReturn;
  } //end func

  /// A string validator where the string cannot be empty
  /// if [toBeValidate] is invalid return feedback string else return null,
  /// hence it will [return null if nothing is wrong].
  static String validateStringCannotBeEmpty(String toBeValidate) {
    if (toBeValidate == null || toBeValidate.length == 0)
      return "Field cannot be empty.";
    if (toBeValidate.length > 256) return "Cannot be longer than 256 character";
    return null;
  }

  //-------------------------------------------------
  // Time Functions
  //-------------------------------------------------

  /// Get the month of the year
  /// if [from] param is empty it will get the current time.
  static String getTheMonthOfTheYear({
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
  static String getTheDayOfTheWeek({DateTime from, bool longFormat = false}) {
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
  static String getTheTimeOfTheDay({
    DateTime from,
    bool isTwentyHourClock = true,
  }) {
    var hour = DateTime.now().hour.toString();
    var minute = DateTime.now().minute.toString();
    if (from != null) {
      hour = from.hour.toString();
      minute = from.minute.toString();
    }

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
  static String getDayAndTimeFormat({DateTime from}) {
    return Util.getTheDayOfTheWeek(from: from) +
        " " +
        Util.getTheTimeOfTheDay(from: from);
  }

  /// Function to get time difference,
  /// ex. it will return ["5h"] if time difference 5h,
  /// this is mostly used in social media app to show the time posted.
  static String getTimeDifference({DateTime from, bool longFormat = false}) {
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
  static String dateTimeToString(DateTime dateTime) {
    if (dateTime == null) return '';
    var month = Util.getTheMonthOfTheYear(from: dateTime);
    var time = Util.getTheTimeOfTheDay(from: dateTime);
    return '$month ${dateTime?.day}, ${dateTime?.year} ' + 'at $time';
  }

  //-------------------------------------------------
  // Number function
  //-------------------------------------------------

  /// Generate random integer.
  static int generateRandomNumber({int from, int to}) {
    int min = from ?? 0;
    int max = to ?? min;
    var rnd = new Random();
    int ranNum = min + rnd.nextInt(max - min);
    return ranNum;
  }

  /// Check if the string is valid email format.
  static bool isValidEmailFormat(String email) {
    bool emailValid = RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(email);
    return emailValid;
  }

  //-------------------------------------------------
  // Enum functions
  //-------------------------------------------------

  /// Extracts enum.toString's value.
  static String enumStringValue(String enumeration) {
    if (enumeration == null) return "";
    return enumeration.split(".").last;
  }
}
