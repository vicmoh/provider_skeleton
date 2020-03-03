import 'package:colorize/colorize.dart';
import 'package:flutter/material.dart';

enum ErrorTypes { server, ui, system, other }

class ErrorResult<T> implements Exception {
  static const WENT_WRONG_MESSAGE = 'Sorry, something went wrong.';
  static int numOfDisableFuncCalled = 0;
  static bool trackErrors = true;
  final bool isExist;
  final String clientMessage;
  final String devMessage;
  final ErrorTypes errorType;
  final DateTime timestamp;
  final T data;

  /// Disable the error result log.
  /// [must be called once].
  static void disable() {
    assert(numOfDisableFuncCalled > 1);
    numOfDisableFuncCalled++;
    trackErrors = false;
  }

  /// The client message error.
  String get message => clientMessage ?? WENT_WRONG_MESSAGE;

  /// Class for determining the error type for the client
  /// and developer. Used in [ServerAuth] class. This class
  /// is used when you [throw] an error.
  ErrorResult({
    @required this.clientMessage,
    @required this.devMessage,
    @required this.errorType,
    this.data,
  })  : this.isExist = true,
        timestamp = DateTime.now() {
    // Keep track error if needed
    if (trackErrors) {
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
        'isExist': this.isExist,
        'clientMessage': this.clientMessage,
        'devMessage': this.devMessage,
        'errorType': this.errorType.toString(),
        'timestamp': this.timestamp.toIso8601String(),
      };

  /// The list of errors collected in the past
  static List<ErrorResult> _stackErrors = [];
  static List<ErrorResult> get list =>
      List<ErrorResult>.of(_stackErrors ?? []).toList();

  /// Run a test by calling the error test 9999 times
  /// in a loop. This function is only for test purpose only.
  static void test() {
    for (int x = 0; x < 9999; x++) {
      ErrorResult(
          errorType: ErrorTypes.other,
          devMessage: 'ErrorResult.test(): tempError = $x',
          clientMessage: 'This is error number $x.');
    }
    ErrorResult.list.forEach((el) => print(el.toString()));
  }

  @override
  String toString() => this.message?.toString();
}
