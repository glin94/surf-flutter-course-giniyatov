// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'places_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PlacesStore on PlacesStoreBase, Store {
  final _$getPlacesFutureAtom = Atom(name: 'PlacesStoreBase.getPlacesFuture');

  @override
  ObservableFuture<List<Place>> get getPlacesFuture {
    _$getPlacesFutureAtom.reportRead();
    return super.getPlacesFuture;
  }

  @override
  set getPlacesFuture(ObservableFuture<List<Place>> value) {
    _$getPlacesFutureAtom.reportWrite(value, super.getPlacesFuture, () {
      super.getPlacesFuture = value;
    });
  }

  final _$PlacesStoreBaseActionController =
      ActionController(name: 'PlacesStoreBase');

  @override
  void getPlaces() {
    final _$actionInfo = _$PlacesStoreBaseActionController.startAction(
        name: 'PlacesStoreBase.getPlaces');
    try {
      return super.getPlaces();
    } finally {
      _$PlacesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
getPlacesFuture: ${getPlacesFuture}
    ''';
  }
}
