
import 'cache_test.dart';
import 'extension_test.dart';
import '../lib/src/util/test.dart';
import '../lib/src/util/log.dart';

void main(List<String> args) {
  extensionTest();
  cacheTest();
  Log.runTest();
  Test.showFinalResult();
}
