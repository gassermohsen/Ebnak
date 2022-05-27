import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';
import 'package:ebnak1/layout/ebnak/cubit/ebnak_cubit.dart';
import 'package:ebnak1/layout/ebnak/cubit/ebnak_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_marker/marker_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AllReportsOnMapsScreen extends StatefulWidget {
  const AllReportsOnMapsScreen({Key? key}) : super(key: key);

  @override
  State<AllReportsOnMapsScreen> createState() => _AllReportsOnMapsScreenState();

}

class _AllReportsOnMapsScreenState extends State<AllReportsOnMapsScreen> {
  var myMarkers = HashSet<Marker>();
  late BitmapDescriptor mapMarker;
  var currentPos;
  var currentLat = 0.0;
  var currentLong = 0.0;


  @override
  void initState() {
    super.initState();
    setMarkerIcon();
    _determinePosition();
    getCurrentLocation();
  }

  void setMarkerIcon() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/warning.png');
  }

  void getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position pos) async {
      setState(() {
        currentPos = pos;
        currentLat = pos.latitude;
        currentLat = pos.longitude;
      });
    });
  }


  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return position;
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EbnakCubit, EbnakStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: GoogleMap(
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            initialCameraPosition: CameraPosition(
                target: LatLng(currentLat, currentLong),
                zoom: 19
            ),
            onMapCreated: (GoogleMapController googleMapController) async {
              googleMapController.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(target: LatLng(currentLat, currentLong,))));
              setState(() {
                myMarkers.add(
                    Marker(
                      markerId: MarkerId('1'),
                      position: LatLng(30.0367030, 30.9730550),
                      icon: mapMarker,

                    ));
              });
            },
            markers: myMarkers,
          ),


        );
      },
    );
  }
}
