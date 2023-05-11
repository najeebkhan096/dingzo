import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/screens/cart.dart';
import 'package:dingzo/screens/checkout.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CloseAccount extends StatelessWidget {

  Constants _const=Constants();

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.8,

          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text("Close Account",style: _const.manrope_regular263238(20, FontWeight.w800)),
          leading: IconButton(onPressed: (){
            Navigator.of(context).pop();

          }, icon: Icon(Icons.arrow_back_ios,color: Color(0xff3A4651),)),
          actions: [

            InkWell(
              onTap: (){
                Navigator.of(context).pushNamed(Checkout.routename);
              },
              child: Container(
                child: Image.asset('images/cart.png',color: Color(0xff263238)),
              ),
            ),
          ],
        ),
        body: ListView(
          children: [

            SizedBox(height: height*0.025,),

            Center(child: Text("We are sad to see you go... ",style: _const.raleway_535F5B(20, FontWeight.w600),)),

            SizedBox(height: height*0.025,),

            Container(
                margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
                child: Text("Once an account has been closed, it will be permently deleted and cannot be reopened.Why do you want to close your account?",style: _const.raleway_535F5B(20, FontWeight.w600),textAlign: TextAlign.center,)),


            SizedBox(height: height*0.025,),

            Container(
                margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
                child: Text("Why do you want to close your account?",style: _const.raleway_regular_darkbrown(20, FontWeight.w600),textAlign: TextAlign.center,)),


            SizedBox(height: height*0.05,),

            Container(
              height: height*0.2,
              margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
              padding: EdgeInsets.only(left: width*0.05,top: height*0.025),
              decoration: BoxDecoration(
                color: Color(0xffBCEFE0),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Text("Add Details",style: _const.raleway_1A5A47(16, FontWeight.w600)),
            ),

            SizedBox(height: height*0.025,),

            Container(
              height: height*0.055,
              width: width*1,
              margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

              padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
              decoration: BoxDecoration(
                  color: mycolor,
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Center(child: Text("Close Account",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
            ),

          ],
        ),

      ),
    );
  }
}
