import 'package:dart_util/dart_util.dart';
import '../lib/src/model/model.dart';

class ModelWithCache extends Model with CacheSystem {
  ModelWithCache({String id}) : super(id) {
    addToCache(this);
  }

  @override
  Map<String, dynamic> toJson() => {id: this.id};
}

class ModelTest1 extends ModelWithCache {
  final String data;
  final String name;

  ModelTest1(this.data)
      : this.name = 'ModelTest1',
        super(id: Model.uniqueId);

  @override
  Map<String, dynamic> toJson() {
    return {'class': this.name, 'data': this.data};
  }

  @override
  int get hashCode => super.hashCode;

  @override
  bool operator ==(object) {
    if (this.data == object?.data &&
        this.name == object?.name &&
        this.hashCode != object?.hashCode &&
        this.getFromCache<ModelTest1>(this) != null) return true;
    return false;
  }

  @override
  String toString() {
    return this.toJson().toString();
  }
}

class ModelTest2 extends ModelWithCache {
  final String data;
  final String name;
  ModelTest2(this.data)
      : this.name = 'ModelTest2',
        super(id: Model.uniqueId);

  @override
  Map<String, dynamic> toJson() {
    return {'class': this.name, 'data': this.data};
  }

  @override
  int get hashCode => super.hashCode;

  @override
  bool operator ==(object) {
    if (this.data == object?.data &&
        this.name == object?.name &&
        this.hashCode != object?.hashCode &&
        this.getFromCache<ModelTest2>(this) != null) return true;
    return false;
  }

  @override
  String toString() {
    return this.toJson().toString();
  }
}

void cacheTest() {
  Test<Model, Model>.batch(
      description: 'Testing caching system.',
      inputs: [
        ModelTest1('bro 1'),
        ModelTest1('bro 2'),
        ModelTest2('bro 3'),
      ],
      expectations: [
        ModelTest1('bro 1'),
        ModelTest1('bro 2'),
        ModelTest2('bro 3'),
      ],
      test: (input, expect) => input == expect);
}
