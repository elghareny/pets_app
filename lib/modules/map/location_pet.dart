import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPet extends StatelessWidget {
   LocationPet({super.key});

  Completer<GoogleMapController> _controller = Completer();

  Position? currentPosition;
  var getLocator = Geolocator();
  GoogleMapController? newGoogleMapController;  
  
  void getCurrentLocation () async {
    var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition=position;
    LatLng latlngPosition = LatLng(position.latitude, position.latitude);
    CameraPosition cameraPosition = new CameraPosition(target: latlngPosition,zoom: 11.5);
    newGoogleMapController!.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

  }


  final LatLng _center = const LatLng(45.521563, -122.677433);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: 
                ()
                {
                 Navigator.pop(context);
                }, 
                icon: const Icon(Icons.arrow_back_ios_new,)),
      ),
      body: GoogleMap(
              mapType: MapType.hybrid,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                newGoogleMapController = controller;
                getCurrentLocation();
              },
            ),);
    //   GoogleMap(
        
    //     buildingsEnabled: true,
    //     mapType: MapType.normal,
    //     onMapCreated: (GoogleMapController controller) {
    //       _controller.complete(controller);
    //     },
    //     initialCameraPosition: CameraPosition(
    //         target: _center,
    //         zoom: 11.0,
    //       ),
    //     ),
    // );
  }
}