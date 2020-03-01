import 'package:meta/meta.dart';

class Test<I, E> {
  /// Description of what you are testing.
  final String description;

  /// The input test.
  final I input;

  /// The test expectation.
  final E expectation;

  /// Test function call back.
  /// Return [true] if expectation is match with input.
  final bool Function(I input, E expect) test;

  /// Number of total fail case.
  static int _totalFailCase = 0;

  /// Number of total pass case.
  static int _totalPassCase = 0;

  /// Set the count checking to 0.
  /// Call this function to start your batch case.
  static void start() {
    _totalFailCase = 0;
    _totalPassCase = 0;
  }

  static void end() {
    String res = '___________________\n';
    res +=
        'FINAL RESULT:  $_totalPassCase/${_totalPassCase + _totalFailCase}\n';
    print(res);
  }

  /// Test object that will determine if the test pass
  /// of fails. Will print the test as this instance is created.
  Test.print({
    @required this.description,
    @required this.input,
    @required this.expectation,
    @required this.test,
  }) {
    assert(!(this.description == null &&
        this.input == null &&
        this.expectation == null &&
        this.test == null));
    String str = '___________________\n';
    str += 'DESCRIPTION: $description\n';
    str += 'INPUT: $input\n';
    str += 'EXPECTATION: $expectation\n';
    // Testing
    bool outcome = false;
    if (test != null) outcome = test(this.input, this.expectation);
    // Show outcome
    if (outcome) {
      _totalPassCase++;
      str += 'RESULT: PASS\n';
    } else {
      _totalFailCase++;
      str += 'RESULT: FAIL\n';
    }
    print(str);
  }

  @override
  String toString() => super.toString();
}
