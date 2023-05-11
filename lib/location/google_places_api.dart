import 'dart:convert';
import 'package:dingzo/location/current_location_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:dingzo/constants.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
class GoogleMapsScreenApi extends StatefulWidget {
 static const routename="GoogleMapsScreenApi";

  @override
  State<GoogleMapsScreenApi> createState() => _GoogleMapsScreenApiState();
}

class _GoogleMapsScreenApiState extends State<GoogleMapsScreenApi> {

  Constants _const=Constants();
  TextEditingController searchcontroller=TextEditingController();
  var uuid = Uuid();
  String _sessiontoken='1234';
  List<dynamic> placeslist=[];
  @override
  void initState() {
    // TODO: implement initState
    searchcontroller.addListener(() {
onChange();
    });
    super.initState();
  }
  void onChange(){

      setState(() {
        _sessiontoken=uuid.v4();
      });
      getSuggestion(searchcontroller.text);

  }

  void getSuggestion(String input)async{
    String mapkey="AIzaSyCtwFDZU6Y2AOGhuhzJUFenPSKhxOIRUyI";
    String baseURL ='https://maps.googleapis.com/maps/api/place/autocomplete/json';

    String request = '$baseURL?input=$input&key=$mapkey&sessiontoken=$_sessiontoken';

            var response= await   http.get(Uri.parse(request));
  if(response.statusCode==200){

setState(() {
  placeslist=jsonDecode(response.body.toString())['predictions'];
});



  }
  else{
    throw Exception("failed to load data");
  }
  }



  @override
  Widget build(BuildContext context) {
  final height=MediaQuery.of(context).size.height;
  final width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.8,
        leadingWidth: width*0.3
        ,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Address",style: _const.manrope_regular263238(20, FontWeight.w800)),
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();

        }, icon: Icon(Icons.arrow_back_ios,color: Color(0xff3A4651),)),
        actions: [


        ],
      ),
      body: ListView(
        children: [


          SizedBox(height: height*0.025,),
          Container(
            height: height*0.07,
            width: width*1,
            margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xffE5E5E5)),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: TextField(
                controller: searchcontroller,
                decoration: InputDecoration(
                    hintText: 'Enter Place ',
                    border: InputBorder.none,

                    hintStyle:  _const.poppin_brown_textfield(14, FontWeight.w600)
                ),
                keyboardType:
                TextInputType.emailAddress,


              ),
            ),
          ),
          SizedBox(height: height*0.025,),
          Container(
            height: height*0.5,
            width: width*1,
            child: ListView.builder(
                itemCount: placeslist.length,
                itemBuilder: (context,index){
              return ListTile(
                onTap: ()async{
                  List<Location> locations = await locationFromAddress(placeslist[index]['description']);
print("lat long is "+locations.first.latitude.toString());

                  // Navigator.push(context, MaterialPageRoute(builder: (context){
                  //   return CurrentLocationScreen(my_location: LatLng(locations.first.latitude,locations.first.longitude),);
                  // }));

                },
                leading:   Image.asset("images/location.png",width: width*0.1,height: height*0.025,),

                title: Text(placeslist[index]['description']),
              );
            }),
          )


        ],
      ),
    );
  }
}
