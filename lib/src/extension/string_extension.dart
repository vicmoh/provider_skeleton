extension StringExtension on String {
  /// Remove alphabets to become a digit only value string.
  /// Turn into number string, punctuation and white spaces
  /// will be removed. The only accepting value is numbers and periods.
  ///
  /// Example: 192.168.0.0
  String toNumOnlyString() {
    var temp = this.replaceAll(RegExp('[^0-9.]'), '');
    return temp;
  }

  /// Function to to determine if string is alphanumeric.
  /// If the string only contains numbers and alphabets
  /// then it will return [true].
  /// Otherwise if it contains white spaces or punctuation
  /// and other symbol it will return [false].
  bool isAlphanumeric() {
    assert(this != null);
    return this.contains(RegExp(r'[^A-Za-z0-9]')) ? false : true;
  }

  /// Function remove any duplicate white spaces.
  /// If the entity; spaces, tabs, or new lines are adjacent
  /// to each other, it is defined as duplicate.
  /// Remove duplicate spaces to single space.
  /// Remove duplicate tabs to single tabs.
  /// Remove duplicate new lines to single new lines.
  String removeDuplicateWhiteSpaces() {
    if (this == null) return this;
    String toReturn = this.trim();
    toReturn = toReturn.replaceAll(RegExp('  +'), ' ');
    toReturn = toReturn.replaceAll(RegExp('\t\t+'), '\t');
    toReturn = toReturn.replaceAll(RegExp('\n\n\n+'), '\n\n');
    return toReturn;
  }

  /// Turn the string input a list of words
  /// that are used for indexing.
  List<String> toIndexableList() {
    if (this == null) return [];
    return Set.of(this
        .split(RegExp(r'[^A-Za-z0-9]'))
        .map((el) => el.toLowerCase())
        .where((el) => el != '')).toList();
  }

  /// This function cut the string and add
  /// ellipsis. Set string with ellipsis [maxLength]
  /// of the string.
  /// Output example 14 as [maxLength]: Some string...
  String ellipsis(int maxLength) {
    if (this == null) return '';
    String temp = this;
    if (temp.length >= maxLength)
      temp = temp.substring(0, maxLength - 3) + '...';
    return temp;
  }

  /// Convert string first letter to uppercase case, for example
  /// value is 'hello' it returns 'Hello'.
  String toSentenceCase() {
    if (this == null) return '';
    var temp = this.toLowerCase();
    String firstChar = temp.substring(0, 1).toUpperCase();
    return firstChar + temp.substring(1, temp.length);
  }

  /// Reference: https://capitalizemytitle.com/.
  /// Chicago title case:
  ///
  /// Capitalize the first and the last word.
  /// Capitalize nouns, pronouns, adjectives, verbs, adverbs, and subordinate conjunctions.
  /// Lowercase articles (a, an, the), coordinating conjunctions, and prepositions.
  /// Lowercase the ‘to’ in an infinitive (I want to play guitar).
  String toTitleCase({Set<String> uncounted}) {
    const Set<String> _prepositions = {
      'a',
      'an',
      'the',
      'and',
      'but',
      'or',
      'for',
      'nor',
      'as',
      'at',
      'by',
      'from',
      'in',
      'into',
      'near',
      'of',
      'on',
      'onto',
      'to',
      'with'
    };
    String temp = this;
    var words = temp.removeDuplicateWhiteSpaces().split(' ');
    int count = 0;
    return words.reduce((res, word) {
      count++;
      if (_prepositions.contains(word) && count == 1) return res + word;
      if (_prepositions.contains(word) || word.length <= 4)
        return res += ' ' + word;
      return res += ' ' + word.toLowerCase().toSentenceCase();
    });
  }

  /// Check if the string is valid email format.
  bool isValidEmailFormat() {
    bool emailValid = RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(this);
    return emailValid;
  }
}
