import 'package:mobx/mobx.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';

part 'places_store.g.dart';

class PlacesStore = PlacesStoreBase with _$PlacesStore;

abstract class PlacesStoreBase with Store {
  PlacesStoreBase(this._placeRepository);

  final PlaceRepository _placeRepository;

  @observable
  ObservableFuture<List<Place>> getPlacesFuture;

  @action
  void getPlaces() {
    final future = _placeRepository.fetchPlaces();
    getPlacesFuture = ObservableFuture(future);
  }
}
