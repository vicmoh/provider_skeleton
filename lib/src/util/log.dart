import '../util/test.dart';
import '../extension/string_extension.dart';

class Log {
  static int _numOfDisableFuncCalled = 0;
  static bool trackLogs = true;
  final String tag;
  final String message;
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
    var logTest = Log('this', 'Hello World!');
    Log.disable();
    Test.single(
        description:
            'Testing if Log() removes ":", "()" and duplicate white spaces on function.',
        input: logTest.toString(),
        expectation: 'Log(): Hello World!',
        test: (input, expect) =>
            Log(logTest, 'Hello World!').toString() == expect);
  }

  /// Print function replacement. This function will
  /// track the log and create a timestamp history.
  /// When calling this log in a class pass the [object]
  /// with [this]. It will print associated with
  /// the object name.
  ///
  /// For example:
  /// ```
  /// Log(this, 'Hello World!');
  /// ```
  Log(dynamic object, String message)
      : timestamp = DateTime.now(),
        this.message = message.trim(),
        this.tag = object is String
            ? object
            : object?.runtimeType
                ?.toString()
                ?.trim()
                ?.removeDuplicateWhiteSpaces()
                ?.replaceAll(RegExp('[)(:\n ]+'), '') {
    // Keep track error if needed.
    if (trackLogs) {
      if (_stackLogs.length < 256 * 2) {
        _stackLogs.add(this);
        print(this.toString());
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
        'tag': this.tag,
        'timestamp': this.timestamp.toIso8601String(),
      };

  @override
  String toString() =>
      this.tag == null ? '[NULL]: ' : this.tag + '(): ' + this.message;
}
