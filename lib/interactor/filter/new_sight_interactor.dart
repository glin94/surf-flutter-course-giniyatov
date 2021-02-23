import 'dart:async';

import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';

SightInteractor sightInteractor = SightInteractor();

class SightInteractor {
  String categoryName = "";

  StreamController<List> _sightListController =
      StreamController<List>.broadcast();

  StreamController<bool> _isValidateController =
      StreamController<bool>.broadcast();

  StreamController<String> _choicedCategoryController =
      StreamController<String>.broadcast();
  Stream<bool> get isValidateStream => _isValidateController.stream;
  Stream<List> get sightListStream => _sightListController.stream;
  Stream<String> get choicedCategoryControllerStream =>
      _choicedCategoryController.stream;

  TextEditingController nameTextController = TextEditingController();
  TextEditingController lonTextController = TextEditingController();
  TextEditingController latTextController = TextEditingController();
  TextEditingController descTextController = TextEditingController();

  validate() {
    _isValidateController.add(
      nameTextController.text.isNotEmpty &&
          lonTextController.text.isNotEmpty &&
          latTextController.text.isNotEmpty &&
          descTextController.text.isNotEmpty &&
          categoryName.isNotEmpty,
    );
  }

  set category(String name) {
    categoryName = name;
    _choicedCategoryController.add(categoryName);
  }

  void createSight() {
    mocks.add(Sight(
        name: nameTextController.text,
        details: descTextController.text,
        lat: double.parse(latTextController.text),
        lon: double.parse(lonTextController.text),
        url: "",
        openingHours: [0, 0],
        type: categoryName));
    _sightListController.add(mocks);
  }
}
