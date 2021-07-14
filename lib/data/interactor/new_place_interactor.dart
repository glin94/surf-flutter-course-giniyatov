import 'dart:async';

import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';
import 'package:places/mocks.dart';

class NewPlaceInteractor {
  String categoryName = "";

  List<String> get imageList => mocks.first.urls;

  StreamController<List<Place>> _placeListController =
      StreamController<List<Place>>.broadcast();

  StreamController<bool> _isValidateController =
      StreamController<bool>.broadcast();

  StreamController<String> _choicedCategoryController =
      StreamController<String>.broadcast();

  StreamController<List<String>> _imageListController =
      StreamController<List<String>>.broadcast();

  Stream<List<String>> get imageListStream => _imageListController.stream;

  Stream<bool> get isValidateStream => _isValidateController.stream;

  Stream<List<Place>> get placeListStream => _placeListController.stream;

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

  void createNewPlace() {
    mocks.add(Place(
        id: 5,
        name: nameTextController.text,
        description: descTextController.text,
        lat: double.parse(latTextController.text),
        lon: double.parse(lonTextController.text),
        urls: imageList,
        openingHours: [0, 0],
        type: categoryName));
    _placeListController.add(mocks);
  }
}
