import 'package:features_flutter/provider/greate_places.dart';
import 'package:features_flutter/screen/add_place_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlaceListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yor places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          )
        ],
      ),
      body: FutureBuilder(
        future:
            Provider.of<GreatPlaces>(context, listen: false).fechAndSetPlaces(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                child: Center(
                  child: Text('start adding some!'),
                ),
                builder: (ctx, value, ch) => value.items.length <= 0
                    ? ch
                    : ListView.builder(
                        itemCount: value.items.length,
                        itemBuilder: (context, index) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                FileImage(value.items[index].image),
                          ),
                          title: Text(value.items[index].title),
                          subtitle: Text(value.items[index].location.address),
                          onTap: () {},
                        ),
                      ),
              ),
      ),
    );
  }
}
