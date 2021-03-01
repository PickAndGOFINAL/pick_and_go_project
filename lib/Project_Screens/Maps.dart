import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsScreen extends StatefulWidget {
  static String id ='MapsSreen';
  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newGoogleMapController;
  @override

  Position currentPoistion;
  LatLng latlng;

  void locatePosition () async {

    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPoistion = position;
    latlng = LatLng(currentPoistion.latitude, currentPoistion.longitude);

    CameraPosition cameraPosition = new CameraPosition(target: latlng , zoom: 15);
    newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

  }


  LatLng inital = LatLng(21.582104, 39.185093);

  Widget build(BuildContext context) {
    return Scaffold(
      body:

      GoogleMap(initialCameraPosition: CameraPosition(target: inital,zoom: 10),

        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,

        onMapCreated: (GoogleMapController controller){
          _controllerGoogleMap.complete(controller);
          newGoogleMapController =controller;
          locatePosition();

        },




      ),





    );
  }
}
