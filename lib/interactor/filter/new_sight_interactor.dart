import 'dart:async';

import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';

SightInteractor sightInteractor = SightInteractor();

class SightInteractor {
  String categoryName = "";

  List<String> get imageList => mocks.first.imgListUrl;

  StreamController<List<Sight>> _sightListController =
      StreamController<List<Sight>>.broadcast();

  StreamController<bool> _isValidateController =
      StreamController<bool>.broadcast();

  StreamController<String> _choicedCategoryController =
      StreamController<String>.broadcast();

  StreamController<List<String>> _imageListController =
      StreamController<List<String>>.broadcast();

  Stream<List<String>> get imageListStream => _imageListController.stream;

  Stream<bool> get isValidateStream => _isValidateController.stream;

  Stream<List<Sight>> get sightListStream => _sightListController.stream;

  Stream<String> get choicedCategoryControllerStream =>
      _choicedCategoryController.stream;

  TextEditingController nameTextController = TextEditingController();
  TextEditingController lonTextController = TextEditingController();
  TextEditingController latTextController = TextEditingController();
  TextEditingController descTextController = TextEditingController();

  void validate() {
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

  void addImage(String url) {
    imageList.add(url);
    _imageListController.add(imageList);
  }

  void deleteImage(String url) {
    imageList.remove(url);
    _imageListController.add(imageList);
  }

  void createSight() {
    mocks.add(Sight(
        name: nameTextController.text,
        details: descTextController.text,
        lat: double.parse(latTextController.text),
        lon: double.parse(lonTextController.text),
        imgListUrl: imageList,
        openingHours: [0, 0],
        type: categoryName));
    _sightListController.add(mocks);
  }
}
