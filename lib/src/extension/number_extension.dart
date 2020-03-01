import 'dart:math';

extension NumExtension on num {
  /// Convert a the number and represent
  /// it in '1k' instead of '1000' and other
  /// big number up to trillion.
  String toShortForm() {
    if (this == null) return '';
    // To shorten the code.
    String theNumberToBeReturn = this.toString();
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
    if (this >= 1000) theNumberToBeReturn = theNewShortNumber(this, 1000, "k");
    if (this >= 1000000)
      theNumberToBeReturn = theNewShortNumber(this, 1000000, "m");
    if (this >= 1000000000)
      theNumberToBeReturn = theNewShortNumber(this, 1000000000, "b");
    if (this >= 1000000000000)
      theNumberToBeReturn = theNewShortNumber(this, 1000000000000, "t");
    return theNumberToBeReturn;
  }

  /// Generate random integer [from] an int [to] another int.
  static int generateRandomNumber({int from, int to}) {
    int min = from ?? 0;
    int max = to ?? min;
    var rnd = new Random();
    int ranNum = min + rnd.nextInt(max - min);
    return ranNum;
  }
}
