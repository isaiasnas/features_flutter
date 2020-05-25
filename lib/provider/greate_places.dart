import 'dart:io';

import 'package:features_flutter/helpers/db_helper.dart';
import 'package:features_flutter/helpers/location_help.dart';
import 'package:features_flutter/models/place.dart';
import 'package:flutter/foundation.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _item = [];
  List<Place> get items => [..._item];

  Future<void> addPlace(
    String title,
    File image,
    PlaceLocation pikdedLocation,
  ) async {
    final address = await LocationHelper.getPlaceAddress(
        pikdedLocation.latitude, pikdedLocation.longitude);
    final updateLocation = PlaceLocation(
        latitude: pikdedLocation.latitude,
        longitude: pikdedLocation.longitude,
        address: address);

    final newPlace = Place(
      id: DateTime.now().toString(),
      image: image,
      title: title,
      location: updateLocation,
    );

    _item.add(newPlace);

    notifyListeners();
    print(newPlace);

    DbHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'address': newPlace.location.address,
    });
  }

  Future<void> fechAndSetPlaces() async {
    final dataList = await DbHelper.getData('user_places');
    _item = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: PlaceLocation(
              latitude: item['loc_lat'],
              longitude: item['loc_lng'],
              address: item['address'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
}
