import 'dart:io';

import 'package:features_flutter/models/place.dart';
import 'package:flutter/foundation.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _item = [];
  List<Place> get items => [..._item];

  void addPlace(
    String title,
    File image,
  ) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: image,
      title: title,
      location: null,
    );
    _item.add(newPlace);
    notifyListeners();
  }
}
