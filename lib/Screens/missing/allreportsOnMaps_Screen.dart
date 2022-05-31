import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebnak1/constants/constants.dart';
import 'package:ebnak1/layout/ebnak/cubit/ebnak_cubit.dart';
import 'package:ebnak1/layout/ebnak/cubit/ebnak_states.dart';
import 'package:ebnak1/shared/re_useable_components.dart';
import 'package:ebnak1/styles/icon_broken.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_marker/marker_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../models/reportMissing_model.dart';
import 'ViewAllReports.dart';
import 'markerReportDetails_Screen.dart';

class AllReportsOnMapsScreen extends StatefulWidget {
  const AllReportsOnMapsScreen({Key? key}) : super(key: key);

  @override
  State<AllReportsOnMapsScreen> createState() => _AllReportsOnMapsScreenState();

}

class _AllReportsOnMapsScreenState extends State<AllReportsOnMapsScreen> {
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  late BitmapDescriptor mapMarker;
  var currentPos;
  var currentLat = 0.0;
  var currentLong = 0.0;

 late  GoogleMapController mapController;

  onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.moveCamera(CameraUpdate.newLatLng(LatLng(currentPos.latitude, currentPos.longitude))) ;
  }


  @override
  void initState() {
    super.initState();
    setMarkerIcon();
    _determinePosition();
    getMarkerData();
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((currloc) {
      setState(() {
        currentPos = currloc;
      });
      mapController.moveCamera(CameraUpdate.newLatLng(LatLng(currentPos.latitude, currentPos.longitude))) ;
    });
  }

  void setMarkerIcon() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/warning.png');
  }

  getMarkerData() {
    int index=0;
    FirebaseFirestore.instance.collection('Reports')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        initMarker(doc.data(), doc.id,index);
        index++;
      });
    });
  }

  void initMarker(specify, specifyId, index) async {
    var markerIdVal = specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,

      position:
      LatLng(specify['location'].latitude, specify['location'].longitude),
      infoWindow: InfoWindow(title: "Warning ! ",
        snippet:"${specify['fullName']} is Missing / Tap for more info  ",
        onTap: (){
        navigateTo(context, MarkerDetailsScreen(EbnakCubit.get(context).Reports[index]));
      },),
      icon:mapMarker,
    );
    setState(() {
      markers[markerId] = marker;
      print(markers.length);
      //print(markerId);
    });
  }



  void getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position pos) async {
      setState(() {
        currentPos = pos;
        currentLat = pos.latitude;
        currentLat = pos.longitude;
      });
      mapController.moveCamera(CameraUpdate.newLatLng(LatLng(pos.latitude, pos.longitude))) ;

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
          appBar: AppBar(
            title: Text('Nearby Reports'),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 10,
            toolbarHeight: 50,
          ),
          body: GoogleMap(
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            initialCameraPosition: CameraPosition(
                target: LatLng(currentLat, currentLong),
                zoom: 17
            ),
            onMapCreated: onMapCreated,
            markers: Set<Marker>.of(markers.values),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: FloatingActionButton.extended(
              onPressed: () {
                navigateTo(context, ViewAllReports());
              },
              backgroundColor: Colors.teal.shade100,
              label:Text('Show All ',style: TextStyle(color: Colors.white),),
              icon:  Icon(IconBroken.Document,color: Colors.white,),

            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,


        );
      },
    );
  }
}


