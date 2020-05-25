import 'package:features_flutter/helpers/location_help.dart';
import 'package:features_flutter/screen/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;

  const LocationInput(this.onSelectPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _prevImg;
  void _showPreview(double lat, double lng) {
    final staticImg = LocationHelper.generateLocationPreviewImage(
      lon: lng,
      lat: lat,
    );
    setState(() {
      _prevImg = staticImg;
    });
  }

  Future<void> _getCurrentUserLocation() async {
    try {
      final locData = await Location().getLocation();
      _showPreview(locData.latitude, locData.longitude);
      // final staticImg = LocationHelper.generateLocationPreviewImage(
      //   lon: locData.longitude,
      //   lat: locData.latitude,
      // );
      // setState(() {
      //   _prevImg = staticImg;
      // });

      widget.onSelectPlace(locData.latitude, locData.longitude);
    } catch (e) {}
  }

  Future<void> _selectOnMap() async {
    final selectLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(
          isSelecting: true,
        ),
      ),
    );

    if (selectLocation == null) return null;

    _showPreview(selectLocation.latitude, selectLocation.longitude);

    widget.onSelectPlace(selectLocation.latitude, selectLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _prevImg == null
              ? Text(
                  'no location',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _prevImg,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: Icon(Icons.location_on),
              label: Text('current location'),
              textColor: Theme.of(context).primaryColor,
            ),
            FlatButton.icon(
              onPressed: _selectOnMap,
              icon: Icon(Icons.map),
              label: Text('select on map'),
              textColor: Theme.of(context).primaryColor,
            ),
          ],
        )
      ],
    );
  }
}
