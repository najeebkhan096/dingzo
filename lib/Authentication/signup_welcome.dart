

import 'package:dingzo/location/geo_location.dart';
import 'package:dingzo/model/work_address.dart';
import 'package:geolocator/geolocator.dart';
import 'package:dingzo/Database/database.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/Authentication/login.dart';
import 'package:dingzo/Authentication/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignupWelcome extends StatelessWidget {
  static const routename="SignupWelcome";
  void _showErrorDialog(BuildContext context ,String msg) {
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
Constants _const=Constants();
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;


    return Scaffold(
backgroundColor: Colors.white,
      body: Container(
        child: ListView(
          children: [
        Container(
          height: height*0.5,
          width: width*1,
          child: Stack(
            children: [
              Container(
                height: height*0.5,
                width: width*1,
                decoration: BoxDecoration(

                  image: DecorationImage(
                    fit: BoxFit.values[2],
                    image: AssetImage("images/welcomecover.png")
                  )
                ),
              ),
              Container(
                height: height*0.5,
                width: width*1,
                color: Colors.white.withOpacity(0.4),
              )
            ],
          ),
        ),
            SizedBox(height: height*0.025,),
            Center(child: Text("Welcome to Zarkit",style: _const.manrope_regular263238(24, FontWeight.w700),)),
            Center(child: Text("Buy or rent anything",style: _const.manrope_regular607D8B(14, FontWeight.w400),)),



            SizedBox(height: height*0.05,),
            InkWell(
              onTap: ()
              async {
                print("pressed");

try{
  MyGeolocation _location=MyGeolocation();
  Position data=await _location
      .determinePosition();
  print(data.toString());
  String _loc = await _location
      .GetAddressFromLatLong(data);


  if(_loc.isNotEmpty){
    Database _database=Database();
    await _database.googleSignIn(
        context:
        context,
        address:
        WorkerAddress(
      longitude: data.longitude,
      latitude: data.latitude,
      address_txt: _loc
    )).then((value) {

    });
  }
}catch(error){
  _showErrorDialog(context, error.toString());
}



              },


              child: Container(
                height: height*0.055,

                margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05,),

                decoration: BoxDecoration(
                    color: Color(0xffECEFF1),
                    borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                children: [
                  SizedBox(width: width*0.15,),
                   Image.asset('images/google.png',height: height*0.05),

                    SizedBox(width: width*0.035,),
                    Text(
                      'Continue with Google',
                      style: _const.manrope_regular263238(16, FontWeight.w500)
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: height*0.025,),
            InkWell(
              onTap: (){
                Navigator.of(context).pushNamed(SignupScreen.routename);

              },
              child: Container(
                height: height*0.055,

                margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05,),

                decoration: BoxDecoration(
                  color: blackbutton,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(

                      'Sign up',
                      style: _const.manrope_regularwhite(16, FontWeight.w700)
                  ),
                ),
              ),
            ),
            SizedBox(height: height*0.025,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Have an account? ",style: _const.manrope_regular263238(12, FontWeight.w400),),
              InkWell(
                  onTap: (){

                    Navigator.of(context).pushNamed(LoginScreen.routename);

                  },
                  child: Text("Sign in",style: TextStyle(
                    fontSize: 12,
                    color: mycolor
                  )))
              ],
            )


        ],
        ),
      ),
    );
  }
}
