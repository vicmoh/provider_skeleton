import 'package:colorize/colorize.dart';
import 'package:flutter/material.dart';

enum ErrorTypes { other, none, server, ui, system, validation }

class Result<T> implements Exception {
  static const WENT_WRONG_MESSAGE = 'Sorry, something went wrong.';
  // For disabling the print and the checking number of calls
  static int _numOfDisableFuncCalled = 0;
  static bool _trackErrors = true;

  /// Any data to be hold.
  final T value;

  /// The message for the client user.
  final String clientMessage;

  /// The message for developer.
  final String devMessage;

  /// Determine if this return has error.
  final bool hasError;

  /// If there is error in the result.
  final ErrorTypes errorType;

  /// Timestamp of when this object created.
  final DateTime timestamp;

  /// Determine if it has data.
  bool get hasData => value == null ? false : true;

  /// Disable the error result log.
  /// [must be called once].
  static void disable() {
    assert(_numOfDisableFuncCalled > 1);
    _numOfDisableFuncCalled++;
    _trackErrors = false;
  }

  /// The client message error.
  String get message => clientMessage ?? WENT_WRONG_MESSAGE;

  /// Class for returning data with message.
  Result(
    this.value, {
    this.devMessage = '',
    this.clientMessage = '',
  })  : this.timestamp = DateTime.now(),
        this.errorType = ErrorTypes.none,
        this.hasError = false;

  /// Class for determining the error type for the client
  /// and developer. Used in [ServerAuth] class. This class
  /// is used when you [throw] an error.
  Result.hasError(
    this.value, {
    @required this.clientMessage,
    @required this.devMessage,
    @required this.errorType,
  })  : this.timestamp = DateTime.now(),
        this.hasError = true {
    // Keep track error if needed
    if (_trackErrors) {
      if (_stackErrors.length < 256 * 2) {
        _stackErrors.add(this);
        print(Colorize(
            '___________________________________________________________')
          ..red());
        print(Colorize(
            'throw ErrorResult(): Caught exception -> ${this.toJson()}\n')
          ..red());
      } else {
        _stackErrors.removeLast();
        _stackErrors.add(this);
      }
      _stackErrors
          .sort((a, b) => a.timestamp.compareTo(b.timestamp) >= 1 ? -1 : 1);
    }
  }

  /// Create JSON map of this object.
  Map<String, dynamic> toJson() => {
        'data': this.value,
        'hasError': this.hasError,
        'clientMessage': this.clientMessage,
        'devMessage': this.devMessage,
        'errorType': this.errorType.toString(),
        'timestamp': this.timestamp.toIso8601String(),
      };

  /// The list of errors collected in the past
  static List<Result> _stackErrors = [];
  static List<Result> get list => List<Result>.of(_stackErrors ?? []).toList();

  /// Run a test by calling the error test 9999 times
  /// in a loop. This function is only for test purpose only.
  static void test() {
    for (int x = 0; x < 9999; x++) {
      Result.hasError(null,
          errorType: ErrorTypes.other,
          devMessage: 'Result.test(): tempError = $x',
          clientMessage: 'This is error number $x.');
    }
    Result.list.forEach((el) => print(el.toString()));
  }

  @override
  String toString() => this.message?.toString() ?? '';
}
