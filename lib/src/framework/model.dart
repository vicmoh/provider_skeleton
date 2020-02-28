/// This class is the foundation used to extends
/// and the generic model where data is being used
/// for the [ListViewLogic].
///
/// [DO NOT TOUCH THIS FILE!!!].

import 'package:meta/meta.dart';

/// The Model Interface for the json serialize.
abstract class ModelInterface {
  ModelInterface.fromJson(Map<String, dynamic> json, {@required String id});
  Map toJson();
  @override
  String toString() => toJson().toString();
}

abstract class Model implements ModelInterface {
  /// Get unique id for dummy model.
  /// For each call, id will increment.
  get uniqueIdForDummy => ++_uniqueIdForDummy;
  static int _uniqueIdForDummy = 0;

  /// Global static cache for tracking the
  /// all the data cache.
  static Map<int, dynamic> _cache = {};

  /// Model consisting cache tracker and Json interface.
  Model() {
    this.addToCache(this);
  }

  /// Gat data from cache.
  /// For example to get the cache data:
  /// ```dart
  /// Post data = getFromCache<Post>();
  /// ```
  /// [Important]: The [id] must be set or exist
  /// before calling this function.
  Model getFromCache<T>(T model) {
    if (_cache[model.hashCode].containsKey(this.id))
      return _cache[model.hashCode];
    else
      return null;
  }

  /// Add and track to cache. You
  /// can retrieve the cache back from
  /// from by using [getFromCache] function.
  /// You can add tot cache while setting the model
  /// an ID with [setId] parameter, this will
  /// call [setId] function.
  void addToCache<T>(T model) {
    if (model == null) return;
    if (setId != null) this.setId(id);
    _cache[model.hashCode] = model;
  }

  /// Print all the cached data.
  static void printAllCachedData() {
    print('_____ Cache data _____');
    _cache.forEach((id, model) => print('ID: $id, Model: $model'));
  }

  /// Get the ID of this model.
  String get id => _id;
  String _id;

  /// This id can only be set once, if id already exist
  /// it will not overwrite. You can do [super.id] or [setId]
  /// which is the exact same thing.
  set id(String val) {
    assert(_id == null);
    if (_id != null) return;
    _id = val;
  }

  /// This id can only be set once, if id already exist
  /// it will not overwrite. You can do [super.id] or [setId]
  /// which is the exact same thing.
  void setId(String val) => this.id = val;
}
