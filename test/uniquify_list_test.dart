import 'package:dart_util/dart_util.dart';

import '../lib/src/model/model.dart';

class Foo extends Model {
  final String data;
  Foo(String id, this.data) : super(id: id);

  @override
  Map toJson() => {'id': this.id, "data": this.data};
}

class SomeList with UniquifyListModel<Foo> {}

uniquifyListModelTest(List<String> args) {
  var testList = SomeList();
  Test<SomeList, SomeList>.single(
      description: 'Testing the uniquify list model',
      test: (i, e) {
        i.addItems([Foo('2', '3')]);
        for (var x = 0; x < testList.items.length; x++) {
          if (!(i.items[x].id == e.items[x].id &&
              i.items[x].data == e.items[x].data)) {
            return false;
          }
        }
        return true;
      },
      input: SomeList()
        ..addItems([Foo('1', '1'), Foo('2', '2'), Foo('3', '3')]),
      expectation: SomeList()
        ..addItems([Foo('1', '1'), Foo('2', '3'), Foo('3', '3')]));
}
