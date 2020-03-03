import '../lib/src/framework/model/model.dart';

class ModelTest1 extends Model {
  final String data;
  final String name;
  ModelTest1(this.data) : this.name = 'ModelTest1';

  @override
  Map<String, dynamic> toJson() {
    return {'class': this.name, 'data': this.data};
  }

  @override
  String toString() {
    return this.toJson().toString();
  }
}

class ModelTest2 extends Model {
  final String data;
  final String name;
  ModelTest2(this.data) : this.name = 'ModelTest2';

  @override
  Map<String, dynamic> toJson() {
    return {'class': this.name, 'data': this.data};
  }

  @override
  String toString() {
    return this.toJson().toString();
  }
}

void main(List<String> args) {
  /// Testing the model abstraction.
  ModelTest1('bro 1');
  ModelTest1('bro 2');
  ModelTest2('bro 3');

  // print all cache data.
  Model.printAllCachedData();
}
