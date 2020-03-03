import '../lib/src/util/test.dart';
import '../lib/src/extension/string_extension.dart';
import '../lib/src/extension/number_extension.dart';
import '../lib/src/extension/date_extension.dart';

void extensionTest() {
  Test<String, String>.single(
      description: 'Testing if string has access like list.',
      input: 'test string',
      expectation: 't',
      test: (input, expect) => input[3] == expect);
  Test<String, String>.single(
      description: 'Testing toNumOnlyString().',
      input: 'hello123 world!',
      expectation: '123',
      test: (input, expect) => input.toNumOnlyString() == expect);
  Test<String, bool>.batch(
      description: 'Testing is number alphanumeric.',
      inputs: ['testing123', 'testing-123', 'testing 123'],
      expectations: [true, false, false],
      test: (input, expect) => input.isAlphanumeric() == expect);
  Test<String, String>.single(
      description: 'Testing ellipsis.',
      input: 'Some string being tested.',
      expectation: 'Some string...',
      test: (input, expect) => input.ellipsis(14) == expect);
  Test<String, String>.single(
      description: 'Testing func to change the first char as upper case.',
      input: 'hello world!',
      expectation: 'Hello world!',
      test: (input, expect) => input.toSentenceCase() == expect);
  Test<String, String>.single(
      description: 'Testing title case.',
      input: 'The hello world and the money in the bucket',
      expectation: 'The Hello World and the Money in the Bucket',
      test: (input, expect) => input.toTitleCase() == expect);
  Test<num, String>.batch(
      description: 'Testing short form numbers.',
      inputs: [1000, 999.9, 999999, 999500, 1500000],
      expectations: ['1k', '999.9', '999.9k', '999.5k', '1.5m'],
      test: (input, expect) => input.toShortForm() == expect);
  Test<String, bool>.batch(
      description: 'Check if email is a valid format.',
      inputs: [
        'teddy_bear_master@hotmail.co',
        'teddy_bear_master_hotmail.com',
        'teddy_bear_master@hotmail.',
        'teddy-bear-master@hotmail.i',
        'hotmail@i.i',
        '@i.i'
      ],
      expectations: [true, false, false, true, true, false],
      test: (input, expect) => input.isValidEmailFormat() == expect);
  Test<DateTime, String>.single(
      description: 'Testing get month for date time.',
      input: DateTime(2020, 12, 13),
      expectation: 'Dec',
      test: (input, expect) => input.getMonth() == expect);
  Test<DateTime, String>.single(
      description: 'Testing get month in long format for date time.',
      input: DateTime(2020, 1, 13),
      expectation: 'January',
      test: (input, expect) => input.getMonth(longFormat: true) == expect);
  Test<DateTime, String>.batch(
      description: 'Testing 12 hour clock string.',
      inputs: [
        DateTime(2020, 1, 1, 2, 0, 0),
        DateTime(2020, 1, 1, 20, 0, 0),
        DateTime(2020, 1, 1, 15, 0, 0)
      ],
      expectations: ['2:00 AM', '8:00 PM', '3:00 PM'],
      test: (input, expect) => input.getTime(isTwelveHour: true) == expect);
  Test<String, String>.batch(
      description: 'Test sentence case string',
      inputs: [
        'hello World!',
        'hello World',
        'hello World:',
        'hello World..',
        'hello World?',
        'Test sentence case string'
      ],
      expectations: [
        'Hello World!',
        'Hello World.',
        'Hello World:',
        'Hello World..',
        'Hello World?',
        'Test sentence case string.'
      ],
      test: (input, expect) =>
          input.toSentenceCase(withPeriod: true) == expect);
}
