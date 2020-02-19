/// This class is the foundation used to extends
/// and the generic model where data is being used
/// for the [ListViewLogic].
///
/// [DO NOT TOUCH THIS FILE!!!].

import 'package:flutter/material.dart';

/// The Model Interface for the json serialize.
abstract class ModelInterface {
  ModelInterface.fromJson(Map<String, dynamic> json, {@required String id});
  Map<String, dynamic> toJson();
  @override
  String toString() => toJson().toString();
}

abstract class Model implements ModelInterface {
  /// Get unique id for dummy model.
  /// For each call, id will increment.
  get uniqueIdForDummy => ++_uniqueIdForDummy;
  static int _uniqueIdForDummy = 0;

  /// Get the ID of this model.
  String get id => _id;
  String _id;

  /// This id can only be set once, if id already exist
  /// it will not overwrite.
  set id(String val) {
    assert(_id == null);
    if (_id != null) return;
    _id = val;
  }
}
