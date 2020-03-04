import 'package:colorize/colorize.dart';
import 'package:meta/meta.dart';
import '../extension/string_extension.dart';

enum _TestType { batch, single }

class Test<I, E> {
  /// Timestamp of the test.
  final DateTime timestamp;

  /// Description of what you are testing.
  final String description;

  /// The input test.
  final List<I> inputs;

  /// The test expectation.
  final List<E> expectations;

  /// Determine if test case pass of failing.
  get isSuccess => _isSuccess;
  bool _isSuccess = false;

  /// Determine if it is batch test.
  final _TestType _type;

  /// Test function call back.
  /// Return [true] if expectation is match with input.
  final bool Function(I input, E expect) test;

  /// Used for determining if the print statement is short format.
  static bool _isShortOutput = true;

  /// Number of total fail case.
  static int _totalFailCase = 0;

  /// Number of total pass case.
  static int _totalPassCase = 0;

  /// The total number of test.
  static int _numberOfTotalTest = 0;

  // A set of all fail test cases.
  static Set<int> _setOfAllFailedTestCases = {};

  /// Green Color string for coloring that bash
  static const GREEN_COLOR = "\033[0;31m";

  /// Red color string for coloring the bash.
  static const RED_COLOR = '\033[1;31m';

  /// Set to no color for coloring tha bash.
  static const NO_COLOR = '\033[1;31m';

  /// Set the count checking to 0.
  /// Call this function to start your batch case.
  static void init({bool isShortOutput = true}) {
    _isShortOutput = isShortOutput;
  }

  /// Show the result of the test.
  static void showFinalResult() {
    print(Colorize('_______________________________________\n')..lightGray());
    String res = '';
    res +=
        'Final result: ${_numberOfTotalTest - _setOfAllFailedTestCases.length}/$_numberOfTotalTest\n';
    if (_setOfAllFailedTestCases.toList().length > 0) {
      res +=
          'Failed test cases: ${_setOfAllFailedTestCases.map((caseId) => '#' + caseId.toString()).toList()}';
      print(Colorize(res)..red());
    } else {
      res += 'Failed test cases: None';
      print(Colorize(res)..green());
    }
    print('');
  }

  /// This in batches. It will print and determine if
  /// the test pass of fails.
  Test.batch({
    @required this.description,
    @required this.test,
    @required this.inputs,
    @required this.expectations,
  })  : this._type = _TestType.batch,
        this.timestamp = DateTime.now() {
    assert(!(this.description == null &&
        this.expectations == null &&
        this.inputs == null &&
        this.test == null));
    if (this.inputs.length != this.expectations.length) assert(false);
    print(Colorize('Batch test: ')
      ..underline()
      ..cyan());
    for (int x = 0; x < this.inputs.length; x++)
      _run(
          description: '$description',
          input: this.inputs[x],
          expectation: this.expectations[x],
          test: this.test);
  }

  /// Test object that will determine if the test pass
  /// of fails. Will print the test as this instance is created.
  Test.single({
    @required this.description,
    @required this.test,
    @required I input,
    @required E expectation,
  })  : this._type = _TestType.single,
        this.timestamp = DateTime.now(),
        this.inputs = [input],
        this.expectations = [expectation] {
    assert(!(this.description == null &&
        this.test == null &&
        input == null &&
        expectation == null));
    _run(
        description: '$description',
        input: input,
        expectation: expectation,
        test: this.test);
  }

  /// Function to run single test.
  void _run({
    @required String description,
    @required I input,
    @required E expectation,
    @required bool Function(I input, E expect) test,
  }) {
    description = description.trim().toSentenceCase(withPeriod: true);
    _numberOfTotalTest++;
    String str = '';
    if (!_isShortOutput) {
      str += '_________________________\n';
      str += 'ID: $_numberOfTotalTest\n';
      str += 'DESCRIPTION: $description\n';
      str += 'INPUT: $input\n';
      str += 'EXPECTATION: $expectation\n';
    } else {
      if (this._type == _TestType.single)
        print(Colorize('Single test: ')
          ..underline()
          ..yellow());
      str +=
          '\t#$_numberOfTotalTest: $description Input with "$input". Expect "$expectation".';
    }

    // Testing outcome.
    if (test != null) _isSuccess = test(input, expectation);
    if (_isSuccess) {
      _isSuccess = true;
      _totalPassCase++;
      if (!_isShortOutput) str += 'RESULT: PASS';
      if (_isShortOutput) str += ' PASS.';
      print(Colorize(str)..green());
    } else {
      _isSuccess = false;
      _totalFailCase++;
      if (!_isShortOutput) str += 'RESULT: FAIL';
      if (_isShortOutput) str += ' FAIL.';
      print(Colorize(str)..red());
      _setOfAllFailedTestCases.add(_numberOfTotalTest);
    }
  }

  /// Create JSON map of this object.
  Map toJson() => {
        'description': this.description,
        'inputs': this.inputs,
        'expectation': this.expectations,
        'timestamp': this.timestamp.toIso8601String(),
        'pass': this._isSuccess,
      };

  @override
  String toString() => super.toString();
}
