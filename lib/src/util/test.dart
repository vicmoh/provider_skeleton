import 'package:meta/meta.dart';

class Test<I, E> {
  /// Description of what you are testing.
  final String description;

  /// The input test.
  final List<I> inputs;

  /// The test expectation.
  final List<E> expectations;

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

  /// Show the result of the test.
  static void end() {
    String res = '___________________\n';
    res +=
        'FINAL RESULT:  $_totalPassCase/${_totalPassCase + _totalFailCase}\n';
    print(res);
  }

  /// This in batches. It will print and determine if
  /// the test pass of fails.
  Test.batch({
    @required this.description,
    @required this.inputs,
    @required this.expectations,
    @required this.test,
  }) {
    assert(!(this.description == null &&
        this.expectations == null &&
        this.inputs == null &&
        this.test == null));
    if (this.inputs.length != this.expectations.length) assert(false);
    for (int x = 0; x < this.inputs.length; x++)
      Test.single(
          description: 'Batch test: ${this.description}',
          input: this.inputs[x],
          expectation: this.expectations[x],
          test: this.test);
  }

  /// Test object that will determine if the test pass
  /// of fails. Will print the test as this instance is created.
  Test.single({
    @required this.description,
    @required I input,
    @required E expectation,
    @required this.test,
  })  : this.inputs = [input],
        this.expectations = [expectation] {
    assert(!(this.description == null &&
        this.test == null &&
        input == null &&
        expectation == null));
    _run(
        description: this.description,
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
    String str = '';
    str += '_________________________\n';
    str += 'DESCRIPTION: $description\n';
    str += 'INPUT: $input\n';
    str += 'EXPECTATION: $expectation\n';
    // Testing.
    bool outcome = false;
    if (test != null)
      outcome = test(this.inputs.first, this.expectations.first);
    // Show outcome.
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
