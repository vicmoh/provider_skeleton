class Log {
  static int numOfDisableFuncCalled = 0;
  static bool trackLogs = true;
  final String message;
  final String function;
  final DateTime timestamp;

  /// Disable the log.
  /// [Must be called once].
  void disable() {
    assert(numOfDisableFuncCalled > 1);
    numOfDisableFuncCalled++;
    trackLogs = false;
  }

  /// Print function replacement.
  /// For parameter [function] set the format
  /// like ex. "SomeObject.function()" as input
  Log(this.function, this.message) : timestamp = DateTime.now() {
    // Keep track error if needed.
    if (trackLogs) {
      if (_stackErrors.length < 256 * 2) {
        _stackErrors.add(this);
        print(this.function + ': ' + this.message);
      } else {
        _stackErrors.removeLast();
        _stackErrors.add(this);
      }
      _stackErrors
          .sort((a, b) => a.timestamp.compareTo(b.timestamp) >= 1 ? -1 : 1);
    }
  }

  /// The list of errors collected in the past.
  static List<Log> _stackErrors = [];
  static List<Log> get list => List<Log>.of(_stackErrors ?? []).toList();

  /// To json object.
  Map<String, dynamic> toJson() => {
        'message': this.message,
        'function': this.function,
        'timestamp': this.timestamp.toIso8601String(),
      };

  @override
  String toString() => this.function + ': ' + this.message;
}
