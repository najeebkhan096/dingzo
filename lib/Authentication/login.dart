import 'package:dingzo/Database/auth.dart';
import 'package:dingzo/Database/database.dart';
import 'package:dingzo/ForgetPassword/email.dart';
import 'package:dingzo/ForgetPassword/otp.dart';
import 'package:dingzo/constants.dart';

import 'package:dingzo/wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart' as cloudstore;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
class LoginScreen extends StatefulWidget {
  static const routename="LoginScreen";
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Constants _const=Constants();
Database _database=Database();

  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _switch=false;
  String ? name='';
  AuthService _auth = AuthService();

  String ? email='';

  String ? pass='';
bool  isloading=false;
  bool  show=false;


  String ? _showErrorDialog(String msg)
  {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Error Accured'),
          content: Text(msg.toString()),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: (){
                Navigator.of(ctx).pop();
              },
            )
          ],
        )
    );
  }


  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      isloading=true;
    });
    try {
      final  User result =await  _auth.signInWithEmailAndPassword(email!, pass!);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => Wrapper()),
              (route)=>false
      );
    } catch (error) {
      setState(() {
        isloading=false;
      });
      _showErrorDialog(error.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;


    return Scaffold(
      backgroundColor: bgcolor,
      body: Container(

        height: height*1,
        child: Container(

          child: ListView(

            children: [

              SizedBox(height: height*0.1,),
              Center(child: Text("Welcome\nBack",style: _const.poppin_BlackBold(40, FontWeight.w700),
              textAlign: TextAlign.center,
              ))
              ,
              SizedBox(height: height*0.1,),
              Form(

                  key:_formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      //username
                      Container(
                          margin: EdgeInsets.only(left: width*0.07),
                          child: Text('Username/Email Address',style: _const.poppin_Regualr(15, FontWeight.w400),)),
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

                            onChanged: (value){
                              setState(() {
                                email=value;
                              });
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
                          child: Text('Password',style:  _const.poppin_Regualr(15, FontWeight.w400),)),

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

                            onChanged: (value){
                              setState(() {
                                pass=value;
                              });
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






                    ],

                  )),


              SizedBox(height: height*0.05,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Forget password?  ",
                  style: _const.raleway_263238(12, FontWeight.w100),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed(Email_Screen.routename);
                    },
                    child: Text("Click here",
                    style:  _const.poppin_mycolor(14, FontWeight.w700),
                    ),
                  )
                ],
              ),


              SizedBox(height: height*0.02,),
      isloading?
          SpinKitRing(color: mycolor)
          :
              InkWell(
                onTap: (){
                  _submit();
                },
                child: Container(
                  height: height*0.065,

                  margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.25,right: MediaQuery.of(context).size.width*0.25,),

                  decoration: BoxDecoration(
                    color: blackbutton,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                        'Log in',
                        style: _const.poppin_white(18, FontWeight.w600)
                    ),
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
