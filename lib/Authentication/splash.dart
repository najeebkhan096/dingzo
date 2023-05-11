import 'dart:async';

import 'package:dingzo/constants.dart';
import 'package:dingzo/Authentication/signup_welcome.dart';
import 'package:dingzo/screens/welcome.dart';
import 'package:dingzo/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Splash_Screen extends StatefulWidget {

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  Constants _const=Constants();

@override
  void initState() {
    // TODO: implement initState
  Timer(Duration(seconds: 5), (){
    Navigator.of(context).pushNamedAndRemoveUntil(Wrapper.routename, (route) => false);
  });
  super.initState();
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
          children: [
            Container(
              height: height*0.3,
              width: width*1,
              margin: EdgeInsets.only(top: height*0.2),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/dingzo.png")
                  )
              ),
            ),

            Positioned(
                right: 0,
                top: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(topRight:  Radius.circular(50))
                  ,
                  child: SvgPicture.asset('images/right.svg',
                    height: height*0.2,fit: BoxFit.fill,
                  ),
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
