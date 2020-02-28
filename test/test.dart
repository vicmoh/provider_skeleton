import '../lib/src/util/log.dart';
import '../lib/src/framework/model.dart';

class ModelTest1 extends Model {
  final String data;
  ModelTest1(this.data);

  @override
  Map<String, dynamic> toJson() {
    return {'class': 'ModelTest1', 'data': this.data};
  }

  @override
  String toString() {
    return this.toJson().toString();
  }
}

class ModelTest2 extends Model {
  final String data;
  ModelTest2(this.data);

  @override
  Map<String, dynamic> toJson() {
    return {'class': 'ModelTest2', 'data': this.data};
  }

  @override
  String toString() {
    return this.toJson().toString();
  }
}

void main(List<String> args) {
  Log.runTest();

  /// Testing the model abstraction.
  ModelTest1('bro 1');
  ModelTest1('bro 2');
  ModelTest2('bro 3');

  // print all cache data.
  Model.printAllCachedData();
}
