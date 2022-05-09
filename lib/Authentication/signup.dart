import 'package:dingzo/Database/auth.dart';
import 'package:dingzo/Database/database.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/screens/SelectCategory.dart';
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


print("our email is "+email.toString()+pass.toString());
      final User user = await _auth.registerWithEmailAndPassword(email!, pass!);


      setState(() {
        currentuserid=user.uid;
      });

      user.updateDisplayName(username);

      final result=await _database.adduser(userid: currentuserid,name: username,email: email,imageurl: "").then((value) async {
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
                builder: (BuildContext context) => SelectCategory()),
                (route)=>false
        );

      });

      print("irfan kon i da"+docid.toString());


  }
  void _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An Error Occured'),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
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
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(

              child: ListView(
                children: [
                  Row(
                    children: [
                      IconButton(onPressed: (){
                        Navigator.of(context).pop();
                      },
                        icon: Icon(Icons.arrow_back,
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          size: 18,),
                      ),
                      Container(
                        height: height*0.2,
                        width: width*0.75,
                        decoration: BoxDecoration(

                            image: DecorationImage(
                                image: AssetImage("images/dollaricon.png")
                            )
                        ),
                      ),
                      Text("")
                    ],
                  ),

                  Center(child: Text("Hello",style: _const.poppin_SemiBold(20, FontWeight.w700),))
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
                              child: Text('Username',style: _const.poppin_brown(10, FontWeight.w400),)),
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
                              child: Text('Email',style: _const.poppin_brown(10, FontWeight.w400),)),
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
                              child: Text('Password',style: _const.poppin_brown(10, FontWeight.w400),)),
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
  margin: EdgeInsets.only(left: width*0.02,right: width*0.02),
  child:   Row(

    mainAxisAlignment: MainAxisAlignment.start,

    crossAxisAlignment: CrossAxisAlignment.start,

    children: [

      Switch(

          activeColor: Color(0xffEAD898),

          activeTrackColor:Color(0xffEFB546) ,

          value: _switch, onChanged: (val){

  setState(() {

    _switch=val;

  });

      }),

          Container(

            width: width*0.75,

            child: Text.rich(

            TextSpan(



              style: _const.poppin_brown(12, FontWeight.w100),

                text: 'By signing up or loggin in, you agree to our',
                children: <InlineSpan>[

                  TextSpan(
                    text: ' Terms of Service and Privacy Policy',

                    style: _const.poppin_Regualr(12, FontWeight.w300),

                  )

                ]

            )



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
                  color: Colors.black,
                  size: 50.0,
                ):
                  InkWell(
                    onTap: (){
                      // Navigator.of(context).pushNamed(SelectCategory.routename);
_submit();
                      },
                    child: Container(
                      height: height*0.055,

                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.25,right: MediaQuery.of(context).size.width*0.25,),

                      decoration: BoxDecoration(
                        color: Color(0xffEFB546),
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


            Positioned(
                right: 0,
                top: 0,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset('images/right.svg',
                      height: height*0.2,fit: BoxFit.fill,
                    ),
                    Positioned(
                        right: width*0.028,
                        child: IconButton(onPressed: (){},
                            icon: Icon(Icons.share,
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                              size: 18,),
                        ),
                    ),

                  ]
                  ,
                )),

            Positioned(
                bottom: 0,
                left: 0,
                child: SvgPicture.asset('images/left.svg',height: height*0.2,)),

          ],
        ),

      ),
    );
  }
}
