import 'dart:io';

import 'package:features_flutter/provider/greate_places.dart';
import 'package:features_flutter/widgets/image_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = "/add-place";
  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleControler = TextEditingController();
  File _pickedImage;
  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    if (_titleControler.text.isEmpty || _pickedImage == null) {
      //show a dialog
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false).addPlace(
      _titleControler.text,
      _pickedImage,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new place'),
        actions: <Widget>[],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: _titleControler,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(),
                    ImageInput(_selectImage)
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            icon: Icon(Icons.adb),
            label: Text('Add place'),
            onPressed: _savePlace,
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Colors.amber,
          )
        ],
      ),
    );
  }
}
