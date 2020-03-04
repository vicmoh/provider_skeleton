import '../util/test.dart';
import '../extension/string_extension.dart';

class Log {
  static int _numOfDisableFuncCalled = 0;
  static bool trackLogs = true;
  final String message;
  final String function;
  final DateTime timestamp;

  /// Disable the log.
  /// [Must be called once].
  static void disable() {
    _numOfDisableFuncCalled++;
    assert(_numOfDisableFuncCalled == 1 || _numOfDisableFuncCalled == 0);
    trackLogs = false;
  }

  /// Function for testing this class.
  static void runTest() {
    Log.disable();
    Test.single(
        description:
            'Testing if Log() removes ":" and duplicate white spaces on function.',
        input: '    \t  SomeObject.function()::: \t  ',
        expectation: 'SomeObject.function()',
        test: (input, expect) => Log(input, 'test').function == expect);
  }

  /// Print function replacement.
  /// For parameter [function] set the format
  /// like ex. "SomeObject.function()" as input
  Log(String function, String message)
      : timestamp = DateTime.now(),
        this.message = message.trim(),
        this.function = function
            .trim()
            .removeDuplicateWhiteSpaces()
            .replaceAll(RegExp('[:\n]+'), '') {
    // Keep track error if needed.
    if (trackLogs) {
      if (_stackLogs.length < 256 * 2) {
        _stackLogs.add(this);
        print(this.function + ': ' + this.message);
      } else {
        _stackLogs.removeLast();
        _stackLogs.add(this);
      }
      _stackLogs
          .sort((a, b) => a.timestamp.compareTo(b.timestamp) >= 1 ? -1 : 1);
    }
  }

  /// The list of errors collected in the past.
  static List<Log> _stackLogs = [];
  static List<Log> get list => List<Log>.of(_stackLogs ?? []).toList();

  /// To json object.
  Map<String, dynamic> toJson() => {
        'message': this.message,
        'function': this.function,
        'timestamp': this.timestamp.toIso8601String(),
      };

  @override
  String toString() => this.function + ': ' + this.message;
}
