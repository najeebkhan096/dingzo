import 'package:geolocator/geolocator.dart';
import 'package:dingzo/Database/auth.dart';
import 'package:dingzo/Database/database.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/location/geo_location.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/model/work_address.dart';
import 'package:dingzo/screens/SelectCategory.dart';
import 'package:dingzo/screens/finish.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:dingzo/screens/categories.dart';
import 'package:dingzo/screens/home.dart';
import 'package:dingzo/Authentication/login.dart';
import 'package:dingzo/screens/welcome.dart';
import 'package:dingzo/wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart' as cloudstore;

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
class SignupScreen extends StatefulWidget {
  static const routename="SignupScreen";
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  Constants _const=Constants();

  final GlobalKey<FormState> _formKey = GlobalKey();
bool _switch=false;
  String ? name='';
  String ? email='';
  String username='';

  String ? pass='';

  bool  show=false;
  String currentuserid='';

  AuthService _auth = AuthService();

   WorkerAddress ? useraddress;
  File ? myfile;
  String ? QRImage;

  cloudstore.
  CollectionReference ? imgRef;

  firebase_storage.Reference ? ref;
  Database _database=Database();
bool isloading=false;

  String ? docid='';
  Future<void> _submit() async {

    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();
    setState(() {
      isloading=true;
    });


try{
  final User user = await _auth.registerWithEmailAndPassword(email!, pass!);



  setState(() {
    currentuserid=user.uid;
  });

await  user.updateDisplayName(username);

  final result=await _database.adduser(
  useraddress:
  useraddress,
      userid: currentuserid,name: username,email: email,imageurl: "").then((value) async {

    docid=value.toString();

    Fluttertoast.showToast(
        msg: "Account is Created",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );

    setState(() {
      isloading=false;
    });

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => FinishScreen()),
            (route)=>false
    );

  });

}catch(error){
  setState(() {
    isloading=false;
  });

  _showErrorDialog(error.toString());
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
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;


    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(

        height: height*1,
        child: Container(

          child: ListView(
            children: [
              SizedBox(height: height*0.1,),
              Center(child: Text("Sign up",style: _const.poppin_BlackBold(40, FontWeight.w700),))
              ,
              SizedBox(height: height*0.025,),
              Form(

                  key:_formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      //username

                      Container(
                          margin: EdgeInsets.only(left: width*0.07),
                          child: Text('Username',style: _const.poppin_Regualr(15, FontWeight.w400),)),
                      SizedBox(height: height*0.015,),
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
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: 'Enter Username ',
                                border: InputBorder.none,

                                hintStyle:  _const.poppin_brown_textfield(14, FontWeight.w600)
                            ),
                            keyboardType:
                            TextInputType.emailAddress,

                            onSaved: (value){

                                username=value!;

                            },
                            validator: (value){
                              if(value!.isEmpty){
                                return 'invalid';
                              }
                              return null;

                            },
                          ),
                        ),
                      ),
                      SizedBox(height: height*0.02,),


                      //email

                      Container(
                          margin: EdgeInsets.only(left: width*0.07),
                          child: Text('Email',style: _const.poppin_Regualr(15, FontWeight.w400),)),
                      SizedBox(height: height*0.015,),

                      Container(
                        height: height*0.07,
                        margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Color(0xffE5E5E5)),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: 'Enter Email ',
                                border: InputBorder.none,
                                hintStyle:  _const.poppin_brown_textfield(14, FontWeight.w600)
                            ),
                            keyboardType:
                            TextInputType.emailAddress,

                            onSaved: (value){

                                email=value;
print("value is "+email.toString());
                            },
                            validator: (value){
                              if(value!.isEmpty){
                                return 'invalid';
                              }
                              return null;

                            },
                          ),
                        ),
                      ),



                      SizedBox(height: height*0.02,),



                      //pass

                      Container(
                          margin: EdgeInsets.only(left: width*0.07),
                          child: Text('Password',style: _const.poppin_Regualr(15, FontWeight.w400),)),
                      SizedBox(height: height*0.015,),

                      Container(
                        height: height*0.07,
                        margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Color(0xffE5E5E5)),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: 'Enter Password ',
                                border: InputBorder.none,
                                hintStyle:  _const.poppin_brown_textfield(14, FontWeight.w600)
                            ),
                            keyboardType:
                            TextInputType.emailAddress,

                            onSaved: (value){

                                pass=value;

                            },
                            validator: (value){
                              if(value!.isEmpty){
                                return 'invalid';
                              }
                              return null;

                            },
                          ),
                        ),
                      ),

                      SizedBox(height: height*0.02,),

Container(
  margin: EdgeInsets.only(left: width*0.075,right: width*0.075),
  child:   Row(

    mainAxisAlignment: MainAxisAlignment.start,

    crossAxisAlignment: CrossAxisAlignment.start,

    children: [

      Switch(

          activeColor: mylightcolor,

          activeTrackColor:mycolor,

          value: _switch, onChanged: (val){

  setState(() {

    _switch=val;

  });

      }),


          Expanded(

            child: Container(



        child: Text.rich(

        TextSpan(



            style: _const.poppin_Regualr(12, FontWeight.w400),

              text: 'By signing up or loggin in, you agree to our',
              children: <InlineSpan>[

                TextSpan(
                  text: ' Terms of Service ',

                  style: _const.poppin_mycolor(12, FontWeight.w300),

                ),


                TextSpan(
                  text: 'and ',

                  style: _const.poppin_Regualr(12, FontWeight.w400),

                )
                ,
                TextSpan(
                  text: 'Privacy Policy',

                  style: _const.poppin_mycolor(12, FontWeight.w300),

                )


              ]

        )



      ),

            ),
          ),

    ],

  ),
),


                    ],

                  )),
              SizedBox(height: height*0.025,),
            _switch?
            isloading?SpinKitRotatingCircle(
              color: mycolor,
              size: 50.0,
            ):
              InkWell(
                onTap: ()async{
                  // Navigator.of(context).pushNamed(SelectCategory.routename);
                  try{
                    MyGeolocation _location=MyGeolocation();
                    Position data=await _location
                        .determinePosition();
                    print(data.toString());
                    String _loc = await _location
                        .GetAddressFromLatLong(data);

if(_loc.isNotEmpty){
useraddress=WorkerAddress(
  address_txt:_loc ,
  latitude: data.latitude,
  longitude:data.longitude
);
  _submit();
}
                  }catch(error){
                    _showErrorDialog(error.toString());
                  }

                  },
                child: Container(
                  height: height*0.055,

                  margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.25,right: MediaQuery.of(context).size.width*0.25,),

                  decoration: BoxDecoration(
                    color: blackbutton,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                        'Sign up',
                        style: _const.poppin_white(18, FontWeight.w600)
                    ),
                  ),
                ),
              ):

            Container(
              height: height*0.055,

              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.25,right: MediaQuery.of(context).size.width*0.25,),

              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.7),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                    'Sign up',
                    style: _const.poppin_white(18, FontWeight.w600)
                ),
              ),
            ),
            ],
          ),
        ),

      ),
    );
  }
}
