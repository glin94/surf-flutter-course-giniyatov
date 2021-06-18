import 'package:flutter/material.dart';
import 'package:places/app.dart';
import 'package:places/data/interactor/api_client.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/data/repository/filter_repository.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:provider/provider.dart';

class AppDependecies extends StatelessWidget {
  const AppDependecies({
    Key key,
    this.app,
  }) : super(key: key);

  final App app;

  @override
  Widget build(BuildContext context) {
    final _apiClient = ApiClient();

    final _placeRepository = PlaceRepository(_apiClient);
    final _filterRepository = FilterRepository(_apiClient);

    final _placeInteractor = PlaceInteractor(_placeRepository);
    final _searchInteractor = SearchInteractor(_filterRepository);
    final _settingsInteractor = SettingsInteractor();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _settingsInteractor),
        Provider.value(value: _placeInteractor),
        Provider.value(value: _searchInteractor),
      ],
      child: app,
    );
  }
}
