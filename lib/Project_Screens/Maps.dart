import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'Menu_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = Firestore.instance;

class MapsScreen extends StatefulWidget {
  // naming this current page to easily route
  static const String id = 'MapsScreen';

  @override
  _mapsState createState() => _mapsState();
}

class _mapsState extends State<MapsScreen> {
  Map dataname = {};
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newGoogleMapController;
  bool showSpinner = false;
  var currentLocation;
  List<Marker> allMarkers = [];
  void initState() {
    super.initState();
    getcurrentuser ();
    Geolocator().getCurrentPosition().then((currloc) {
      setState(() {
        currentLocation = currloc;
        showSpinner = true;
        getmarkers();
      });
    });
  }

  String uid='';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void getcurrentuser () async {
    final FirebaseUser user = await _auth.currentUser();
    uid = user.uid;

  }



  getmarkers() {
    _firestore
        .collection(dataname["cafeName"] + "Location")
        .getDocuments()
        .then((docs) {
      if (docs.documents.isNotEmpty) {
        for (int i = 0; i < docs.documents.length; i++) {
          initMarker(docs.documents[i].data);
        }
      }
    });
  }

  initMarker(branch) {
    setState(() {
      allMarkers.add(Marker(
        position:
        LatLng(branch['location'].latitude, branch['location'].longitude),
        draggable: false,
        markerId: MarkerId(branch['BranchName']),
        infoWindow:
        InfoWindow(title: branch['name'], snippet: branch['BranchName']),
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9.0)),
                    backgroundColor: Colors.white,
                    child: Stack(
                        overflow: Overflow.visible,
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                            height: 245,
                            child: Padding(
                              padding:
                              const EdgeInsets.fromLTRB(10, 70, 10, 10),
                              child: Column(
                                children: [
                                  Text(
                                    branch['name'] + ' Cafe',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    'Your kiosk at ' +
                                        branch['BranchName'] +
                                        ' Street',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      RaisedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        color: Colors.redAccent,
                                        child: Text(
                                          'Back',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      RaisedButton(
                                        onPressed: () {
                                          Navigator.pushReplacementNamed(
                                              context, MenuScreen.id,
                                              arguments: {
                                                'address': branch['name'] +
                                                    ' Cafe at ' +
                                                    branch['BranchName'] +
                                                    ' Street',
                                              });
                                          _firestore.collection('Selectedbranch').document(uid).setData({
                                            'branchname':  branch['BranchName'],

                                          });

                                        },
                                        color: Colors.green,
                                        child: Text(
                                          'Continue',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: -60,
                            child: CircleAvatar(
                              backgroundColor: Colors.white70,
                              radius: 60,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.asset(
                                    'images/' + branch['name'] + '.jpeg'),
                              ),
                            ),
                          ),
                        ]));
              });
        },
      ));
    });
  }

  Position currentPoistion;
  LatLng latlng;

  void locatePosition() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPoistion = position;
    latlng = LatLng(currentPoistion.latitude, currentPoistion.longitude);

    CameraPosition cameraPosition =
    new CameraPosition(target: latlng, zoom: 11);
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  @override
  Widget build(BuildContext context) {
    dataname = ModalRoute.of(context).settings.arguments;
    return Scaffold(

      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 55.0,
            width: double.infinity,
            child: showSpinner
                ? GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(21.582104, 39.185093), zoom: 11),
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              onMapCreated: onMapCreated,
              markers: Set.from(allMarkers),
            )
                : Center(
              child: ModalProgressHUD(
                child: Center(
                  child: Text(
                    '\n\n\n\nLoading Map.... Please Wait!',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                inAsyncCall: !showSpinner,
                opacity: 0.5,
                progressIndicator: CircularProgressIndicator(),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(3.5),
            child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.brown,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Select Another Kiosk",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
          ),


        ],
      ),
    );
  }

  void onMapCreated(controller) {
    setState(() {
      newGoogleMapController = controller;
    });
  }
}