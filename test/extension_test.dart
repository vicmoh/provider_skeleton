import 'package:provider_skeleton/src/util/test.dart';

import '../lib/src/extension/string_extension.dart';
import '../lib/src/extension/number_extension.dart';

void main(List<String> args) {
  Test.start();
  Test<String, String>.print(
      description: 'Testing if string has access like list.',
      input: 'test string',
      expectation: 't',
      test: (input, expect) => input[3] == expect);
  Test<String, String>.print(
      description: 'Testing toNumOnlyString().',
      input: 'hello123 world!',
      expectation: '123',
      test: (input, expect) => input.toNumOnlyString() == expect);
  Test<String, bool>.print(
      description: 'Testing isAlphanumeric().',
      input: 'testing123',
      expectation: true,
      test: (input, expect) => input.isAlphanumeric() == expect);
  Test<String, bool>.print(
      description: 'Testing isAlphanumeric().',
      input: 'testing-123',
      expectation: false,
      test: (input, expect) => input.isAlphanumeric() == expect);
  Test<String, bool>.print(
      description: 'Testing isAlphanumeric().',
      input: 'testing 123',
      expectation: false,
      test: (input, expect) => input.isAlphanumeric() == expect);
  Test<String, String>.print(
      description: 'Testing ellipsis.',
      input: 'Some string being tested.',
      expectation: 'Some string...',
      test: (input, expect) => input.ellipsis(14) == expect);
  Test<String, String>.print(
      description: 'Testing func to change the first char as upper case.',
      input: 'hello world!',
      expectation: 'Hello world!',
      test: (input, expect) => input.toSentenceCase() == expect);
  Test<String, String>.print(
      description: 'Testing title case.',
      input: 'The hello world and the money in the bucket',
      expectation: 'The Hello World and the Money in the Bucket',
      test: (input, expect) => input.toTitleCase() == expect);
  Test<int, String>.print(
      description: 'Testing toShortForm().',
      input: 1000,
      expectation: '1k',
      test: (input, expect) => input.toShortForm() == expect);
  Test<num, String>.print(
      description: 'Testing toShortForm().',
      input: 999.9,
      expectation: '999.9',
      test: (input, expect) => input.toShortForm() == expect);
  Test<int, String>.print(
      description: 'Testing toShortForm().',
      input: 1000,
      expectation: '1k',
      test: (input, expect) => input.toShortForm() == expect);
  Test<int, String>.print(
      description: 'Testing toShortForm().',
      input: 999999,
      expectation: '999.9k',
      test: (input, expect) => input.toShortForm() == expect);
  Test<int, String>.print(
      description: 'Testing toShortForm().',
      input: 999500,
      expectation: '999.5k',
      test: (input, expect) => input.toShortForm() == expect);
  Test<int, String>.print(
      description: 'Testing toShortForm().',
      input: 1500000,
      expectation: '1.5m',
      test: (input, expect) => input.toShortForm() == expect);
  Test<String, bool>.print(
      description: 'Check if email is a valid format.',
      input: 'teddy_bear_master@hotmail.com',
      expectation: true,
      test: (input, expect) => input.isValidEmailFormat() == expect);
  Test<String, bool>.print(
      description: 'Check if email is a valid format.',
      input: 'teddy_bear_master_hotmail.com',
      expectation: false,
      test: (input, expect) => input.isValidEmailFormat() == expect);
  Test<String, bool>.print(
      description: 'Check if email is a valid format.',
      input: 'teddy_bear_master@hotmail.',
      expectation: false,
      test: (input, expect) => input.isValidEmailFormat() == expect);
  Test<String, bool>.print(
      description: 'Check if email is a valid format.',
      input: 'teddy-bear-master@hotmail.i',
      expectation: true,
      test: (input, expect) => input.isValidEmailFormat() == expect);
  Test<String, bool>.print(
      description: 'Check if email is a valid format.',
      input: 'hotmail@i.i',
      expectation: true,
      test: (input, expect) => input.isValidEmailFormat() == expect);
  Test<String, bool>.print(
      description: 'Check if email is a valid format.',
      input: '@i.i',
      expectation: false,
      test: (input, expect) => input.isValidEmailFormat() == expect);
  Test.end();
}
