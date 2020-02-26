import '../util/test.dart';

class Log {
  static int numOfDisableFuncCalled = 0;
  static bool trackLogs = true;
  final String message;
  final String function;
  final DateTime timestamp;

  /// Disable the log.
  /// [Must be called once].
  static void disable() {
    assert(numOfDisableFuncCalled > 1);
    numOfDisableFuncCalled++;
    trackLogs = false;
  }

  /// Function for testing this class.
  static void runTest() {
    Test.start();
    Log.disable();
    Test.print(
        description: 'Testing if Log() removes ":" on function.',
        input: '    \t  SomeObject.function()::: \t  ',
        expectation: 'SomeObject.function()',
        test: (input, expect) =>
            Log(input, 'test').function == expect ? true : false);
  }

  /// Print function replacement.
  /// For parameter [function] set the format
  /// like ex. "SomeObject.function()" as input
  Log(String function, String message)
      : timestamp = DateTime.now(),
        this.message = message.trim(),
        this.function = function.trim().replaceAll(RegExp('[:]'), '') {
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
