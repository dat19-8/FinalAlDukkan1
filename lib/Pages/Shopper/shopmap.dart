import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'shopsignup.dart';
import 'package:finaldukkan1/globals.dart';

class GoogleMapp extends StatefulWidget {
  @override
  State<GoogleMapp> createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMapp> {
  Completer<GoogleMapController> _controller = Completer();
  Position position;

  MapType type;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.8933, 35.4760),
    zoom: 14.4746,
  );

  final Map<String, Marker> _markers = {};
  String _locationMessage = "";

  void _getLocation() async {
    currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    final coordinates =
        new Coordinates(currentLocation.latitude, currentLocation.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    _locationMessage =
        "${first.locality} : ${first.adminArea}:${first.subLocality}:${first.subAdminArea}:${first.addressLine},${first.featureName},${first.thoroughfare},${first.subThoroughfare}";

    setState(() {
      _markers.clear();
      final marker = Marker(
        markerId: MarkerId("curr_loc"),
        position: LatLng(currentLocation.latitude, currentLocation.longitude),
        infoWindow: InfoWindow(title: 'Your Location'),
      );
      _markers["Current Location"] = marker;
    });

    print(currentLocation);

    print(_locationMessage);
    //  Navigator.pop(context,MaterialPageRoute(builder: (context) => SignUpVendor()));
  }

  @override
  void initState() {
    _getLocation();

    super.initState();
    type = MapType.normal;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            markers: _markers.values.toSet(),
            mapType: type,
            myLocationEnabled: true,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              children: <Widget>[
                FloatingActionButton(
                  child: Icon(Icons.location_on),
                  tooltip: 'Get Location',
                  onPressed: (){
                    
                    _getLocation();
                     Navigator.pop(context,MaterialPageRoute(builder: (context) => SignUpShopper())); 
                    },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
