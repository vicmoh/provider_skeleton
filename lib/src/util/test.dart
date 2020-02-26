import 'package:meta/meta.dart';

class Test<T> {
  /// Description of what you are testing.
  final String description;

  /// The input test.
  final T input;

  /// The test expectation.
  final T expectation;

  /// Test function call back.
  /// Return [true] if expectation is match with input.
  final bool Function(T input, T expect) test;

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
    str += 'EXPECTATION $expectation\n';
    bool outcome = test(this.input, this.expectation);
    if (outcome) {
      _totalPassCase++;
      str += 'RESULT: PASS\n';
    } else {
      _totalFailCase++;
      str += 'RESULT: FAIL\n';
    }
    str += '$_totalPassCase/${_totalPassCase + _totalFailCase}\n';
    print(str);
  }

  @override
  String toString() => super.toString();
}
