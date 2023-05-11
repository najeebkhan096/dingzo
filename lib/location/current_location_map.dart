import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLocationScreen extends StatefulWidget {
final LatLng ? my_location;
CurrentLocationScreen({this.my_location});

  @override
  _CurrentLocationScreenState createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<CurrentLocationScreen> {

  String address = '' ;
  final Completer<GoogleMapController> _controller = Completer();


  Future<Position> _getUserCurrentLocation() async {


    await Geolocator.requestPermission().then((value) {

    }).onError((error, stackTrace){
      print(error.toString());
    });

    return await Geolocator.getCurrentPosition();

  }


  final List<Marker> _markers =  <Marker>[];





  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _markers.addAll([
      Marker(
          markerId: MarkerId('1'),
          position: widget.my_location!,
          infoWindow: InfoWindow(
              title: 'some Info '
          )
      )
    ]);

  }

  loadData(){
    _getUserCurrentLocation().then((value) async {
      _markers.add(
          Marker(
              markerId: const MarkerId('SomeId'),
              position: LatLng(value.latitude ,value.longitude),
              infoWindow:  InfoWindow(
                  title: address
              )
          )
      );

      final GoogleMapController controller = await _controller.future;
      CameraPosition _kGooglePlex =  CameraPosition(
        target: LatLng(value.latitude ,value.longitude),
        zoom: 14,
      );
      controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
    height: MediaQuery.of(context).size.height*0.3,
      width: MediaQuery.of(context).size.width*1,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [

          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: widget.my_location!,
              zoom: 14,
            ),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            markers: Set<Marker>.of(_markers),
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
            },
          ),

        ],
      ),
    );
  }


}