
import 'package:geolocator/geolocator.dart';

import 'package:path/path.dart' as Path;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dingzo/Database/database.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/location/geo_location.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/model/work_address.dart';

import 'package:flutter/cupertino.dart';
import 'dart:convert';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class Set_up_Address extends StatefulWidget {
  static const routename="Set_up_Address";

  @override
  State<Set_up_Address> createState() => _Set_up_AddressState();
}

class _Set_up_AddressState extends State<Set_up_Address> {
  Constants _const = Constants();
  bool isloading=false;
  bool edit=false;
  bool verified=false;

  Future<WorkerAddress> getlocation() async {
    print("step10");
    WorkerAddress? myadd;
    MyGeolocation location = MyGeolocation();
    Position data = await location.determinePosition();
    String addresstxt = await location.GetAddressFromLatLong(data);

    myadd = WorkerAddress(
        address_txt: addresstxt,
        longitude: data.longitude,
        latitude: data.latitude);
    return myadd;
  }
  Future<String?>  access_token()async{
    String ? _token;
    var headers = {
      'Authorization': 'Basic R3NmSHFVeFJNY3M1ZFBBYmZtSTh2ZzBCUEc4MWhyMk46eFpQVnIwYTBXMFpoSVpKaA==',
      'Content-Type': 'application/x-www-form-urlencoded'
    };



    final request=await  http.post(Uri.parse('https://shipping-api-sandbox.pitneybowes.com/oauth/token'),
        headers: headers,
        body: {
          'grant_type': 'client_credentials'
        }
    );
    final  response =jsonDecode(request.body);
    if (request.statusCode == 200) {
      _token=response['access_token'];

    }
    else {

    }
    return _token;
  }

  Future<void>  verify_address(String token)async{
    var headers = {
      'Authorization': 'Bearer ${token}',
      'Content-Type': 'application/json',
      'X-PB-UnifiedErrorStructure': 'true'
    };



    final request=await  http.post(Uri.parse('https://shipping-api-sandbox.pitneybowes.com/shippingservices/v1/addresses/verify'),
        headers: headers,
        body:
        json.encode({
          "addressLines": [
            newaddress!.address1,
            "",
            ""
          ],
          "cityTown":  newaddress!.city,
          "stateProvince":  newaddress!.state,
          "postalCode":  newaddress!.zipcode,
          "countryCode":  "US",
          "name":  newaddress!.firstname
        })

    );
    final  response =jsonDecode(request.body);
    if (request.statusCode == 200) {
      print("verified "+request.body.toString());
      currentuser!.home_address!.add(newaddress!);
      await  database.updateUserHomeAddress(updateduser: currentuser).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Added Successfully"),
          backgroundColor: Colors.green,
        ));
        Navigator.of(context).pop();
      });

    }
    else {
      setState(() {
        isloading=false;
      });
      print("failed  "+request.body.toString());
      _showErrorDialog("Address is Invalid");

    }

  }
  void _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An Error Occured'),
          content: Text(msg),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ));
  }
  final GlobalKey<FormState> _formKey = GlobalKey();

  Future<void> _submit() async {

    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    setState(() {
      isloading=true;
    });


    try {

      String ? token=await  access_token();
      await verify_address(token!);
    } catch(error){
      setState(() {
        isloading=false;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Address failed. Please try again"),
        backgroundColor: Colors.red,
      ));

    }

  }

  Address ? newaddress=Address(
      address1: '',
      address2: '',
      city: '',
      firstname: '',
      lastlast: '',
      state: '',
      vocation: false,
      zipcode: '',
      ExpiyDate: ''
  );


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(

      backgroundColor: Colors.white,
      body: ListView(
        children: [
          SizedBox(
            height: height * 0.05,
          ),

          Center(
            child: Container(
               width: width*0.8,
                child: Text("Please Enter Your Address",style: _const.poppin_BlackBold(25, FontWeight.w600),
                textAlign: TextAlign.center,
                )
            ),
          ),
          SizedBox(
            height: height * 0.025,
          ),
          Center(
            child: Container(
                width: width*0.8,
                child: Text("This enables us to help you find the items nearest to you.",
                    style: _const.manrope_regular263238(14, FontWeight.w400),
                textAlign: TextAlign.center,
                )),
          ),
          SizedBox(
            height: height * 0.025,
          ),



            Form(
              key: _formKey,
              child: Container(
                width: width * 1,
                padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
                child: Column(
                  children: [


                    SizedBox(height: height*0.025,),


                    Row(
                      children: [
                        Container(
                          width: width * 0.3,
                          child: Text("Full Name:",
                              style: _const.raleway_535F5B(
                                  17, FontWeight.w700)),
                        ),
                        Container(
                          width: width * 0.285,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: rgbcolor,
                          ),
                          alignment: Alignment.center,
                          child:TextFormField(
                            onSaved: (val){
                              newaddress!.firstname=val;
                            },
                            onChanged: (val){

                              newaddress!.firstname=val;

                            },
                            textAlign: TextAlign.center,

                            decoration: InputDecoration(
                                border: InputBorder.none,
                              hintText: "First",
                              hintStyle: _const.raleway_535F5B(15, FontWeight.w600)
                            ),
                            style: _const.raleway_rgb_textfield(17, FontWeight.w600),),
                          height: height * 0.055,
                        ),
                        SizedBox(width: width*0.025,),
                        Container(
                          width: width * 0.285,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: rgbcolor,
                          ),
                          alignment: Alignment.center,
                          child: TextFormField(
                            onSaved: (val){
                              newaddress!.lastlast=val;
                            },
                            onChanged: (val){

                              newaddress!.lastlast=val;

                            },
                            textAlign: TextAlign.center,

                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Last",
                                hintStyle: _const.raleway_535F5B(15, FontWeight.w600)
                            ),
                            style: _const.raleway_rgb_textfield(17, FontWeight.w600),),
                          height: height * 0.055,
                        )
                      ],
                    ),

                    SizedBox(height: height*0.025,),
                    Row(
                      children: [
                        Container(
                          width: width * 0.3,
                          child: Text("Address 1:",
                              style: _const.raleway_535F5B(
                                  17, FontWeight.w700)),
                        ),
                        Container(
                          width: width * 0.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: rgbcolor,
                          ),
                          alignment: Alignment.center,
                          child: TextFormField(
                            onSaved: (val){
                              newaddress!.address1=val;
                            },
                            onChanged: (val){

                              newaddress!.address1=val;

                            },
                            textAlign: TextAlign.center,

                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Address 1",
                                hintStyle: _const.raleway_535F5B(15, FontWeight.w600)
                            ),
                            style: _const.raleway_rgb_textfield(17, FontWeight.w600),),
                          height: height * 0.055,
                        )
                      ],
                    ),

                    SizedBox(height: height*0.025,),
                    Row(
                      children: [
                        Container(
                          width: width * 0.3,
                          child: Text("Address 2:",
                              style: _const.raleway_535F5B(
                                  17, FontWeight.w700)),
                        ),
                        Container(
                          width: width * 0.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: rgbcolor,
                          ),
                          alignment: Alignment.center,
                          child: TextFormField(
                            onSaved: (val){
                              newaddress!.address2=val;
                            },
                            onChanged: (val){

                              newaddress!.address2=val;

                            },
                            textAlign: TextAlign.center,

                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Address 2",
                                hintStyle: _const.raleway_535F5B(15, FontWeight.w600)
                            ),
                            style: _const.raleway_rgb_textfield(17, FontWeight.w600),),
                          height: height * 0.055,
                        )
                      ],
                    ),

                    SizedBox(height: height*0.025,),
                    Row(
                      children: [
                        Container(
                          width: width * 0.3,
                          child: Text("City:",
                              style: _const.raleway_535F5B(
                                  17, FontWeight.w700)),
                        ),
                        Container(
                          width: width * 0.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: rgbcolor,
                          ),
                          alignment: Alignment.center,
                          child: TextFormField(
                            onSaved: (val){
                              newaddress!.city=val;
                            },
                            onChanged: (val){

                              newaddress!.city=val;

                            },
                            textAlign: TextAlign.center,

                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "City",
                                hintStyle: _const.raleway_535F5B(15, FontWeight.w600)
                            ),
                            style: _const.raleway_rgb_textfield(17, FontWeight.w600),),
                          height: height * 0.055,
                        )
                      ],
                    ),

                    SizedBox(height: height*0.025,),
                    Row(
                      children: [
                        Container(
                          width: width * 0.3,
                          child: Text("State :",
                              style: _const.raleway_535F5B(
                                  17, FontWeight.w700)),
                        ),
                        Container(
                          width: width * 0.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: rgbcolor,
                          ),
                          alignment: Alignment.center,
                          child: TextFormField(
                            onSaved: (val){
                              newaddress!.state=val;
                            },
                            onChanged: (val){

                              newaddress!.state=val;

                            },
                            textAlign: TextAlign.center,

                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "State",
                                hintStyle: _const.raleway_535F5B(15, FontWeight.w600)
                            ),
                            style: _const.raleway_rgb_textfield(17, FontWeight.w600),),
                          height: height * 0.055,
                        )
                      ],
                    ),

                    SizedBox(height: height*0.025,),
                    Row(
                      children: [
                        Container(
                          width: width * 0.3,
                          child: Text("Zip Code :",
                              style: _const.raleway_535F5B(
                                  17, FontWeight.w700)),
                        ),
                        Container(
                          width: width * 0.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: rgbcolor,
                          ),
                          alignment: Alignment.center,
                          child: TextFormField(
                            onSaved: (val){
                              newaddress!.zipcode=val;
                            },
                            onChanged: (val){

                              newaddress!.zipcode=val;

                            },
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,

                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Zipcode",
                                hintStyle: _const.raleway_535F5B(15, FontWeight.w600)
                            ),
                            style: _const.raleway_rgb_textfield(17, FontWeight.w600),),
                          height: height * 0.055,
                        )
                      ],
                    ),

                    SizedBox(height: height*0.05,),

                    isloading? SpinKitRotatingCircle(
                      color: mycolor,
                      size: 50.0,
                    ) :

                    InkWell(

                      onTap: () async {
                        setState(() {
                          isloading=true;
                        });
                        try{
                          bool exist=await database.check_location_details(DesiredUserID: currentuser!.uid);

                          if(exist==false){

                            WorkerAddress loc = await  getlocation();

                            if( loc.address_txt!.isNotEmpty ) {
                              await  database.updateUserLocationDetails(loc: loc).then((value) {
                                _submit();
                              });



                            }

                          }
                          else{
                            _submit();

                          }

                        }catch(error){
setState(() {
  isloading=false;
});
                          _showErrorDialog(error.toString());
                        }


                      },

                      child: Container(
                        height: height*0.055,
                        width: width*1,
                        margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

                        padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                        decoration: BoxDecoration(
                            color: blackbutton,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(child: Text("Continue",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
                      ),
                    ),
                    SizedBox(height: height*0.05,),

                  ],
                ),
              ),
            ),
        ],
      ),

    );
  }
}