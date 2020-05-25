import 'package:features_flutter/provider/greate_places.dart';
import 'package:features_flutter/screen/add_place_screen.dart';
import 'package:features_flutter/screen/place_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        title: 'Features Flutter',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        home: PlaceListScreen(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
        },
      ),
    );
  }
}
