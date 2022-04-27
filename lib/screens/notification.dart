import 'dart:convert';
import 'package:dingzo/constants.dart';
import 'package:dingzo/screens/selling/NewShipped.dart';
import 'package:dingzo/screens/selling/completed.dart';
import 'package:dingzo/screens/selling/Rating.dart';
import 'package:dingzo/screens/selling/shipped.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationScreen extends StatefulWidget {

  static const routename = "NotificationScreen";
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>  with SingleTickerProviderStateMixin{
  @override
  Color active = Colors.green;
  Color inactive = Color(0xffF9F9F9);
  bool isrecieved = true;

  Constants _const=Constants();

  @override


  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,

          body: SingleChildScrollView(
            child: Container(
              height: height*1,
              child: Column(

                children: [
                  Container(
                    height: height*0.15,
                    width: width*1,
                    decoration: BoxDecoration(
                        color:  Color(0xffFFEA9D),
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(40))
                    ),
                    child: Center(child: Text("Notification",style: _const.raleway_extrabold(30, FontWeight.w800),)),

                  ),
                  SizedBox(height: height*0.025,),
                  Container(

                    margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
                    child:   Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        Container(
                          width: width*0.3,
                          height: height*0.17,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: AssetImage("images/categ.png")
                              )
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: height*0.03,
                              width: width*0.6,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [

                                  Text('03-08-2021',style: TextStyle(color: Color(0xffC4C4C4),fontFamily: 'Raleway-SemiBold',fontSize: height*0.02,fontWeight: FontWeight.w600)),
                                  Text("")

                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: width*0.025),
                              width: width*0.565,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Text("You just got a sale!",style: _const.raleway_regular_darkbrown(18, FontWeight.w700)),

                                      SizedBox(height: height*0.03,),

                                      Container(
                                        height: height*0.04,
                                        width: width*0.25,
                                        padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                                        decoration: BoxDecoration(
                                            color: Color(0xff9E772A),
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Center(child: Text("View Sale",style:_const.raleway_SemiBold_white(12, FontWeight.w600),)),
                                      ),

                                    ],
                                  ),
                                  Image.asset('images/icons8-shopping-bag-90 1.png')
                                ],
                              ),
                            ),
                          ],
                        ),






                      ],
                    ),
                  ),


                  SizedBox(height: height*0.025,),
                  Container(

                    margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
                    child:   Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        Container(
                          width: width*0.3,
                          height: height*0.17,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: AssetImage("images/categ.png")
                              )
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: height*0.03,
                              width: width*0.6,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [

                                  Text('03-08-2021',style: TextStyle(color: Color(0xffC4C4C4),fontFamily: 'Raleway-SemiBold',fontSize: height*0.02,fontWeight: FontWeight.w600)),
                                  Text("")

                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: width*0.025),
                              width: width*0.565,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Text("Your item shipped!",style: _const.raleway_regular_darkbrown(18, FontWeight.w700)),

                                      SizedBox(height: height*0.03,),

                                      Container(
                                        height: height*0.04,
                                        width: width*0.25,
                                        padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                                        decoration: BoxDecoration(
                                            color: Color(0xff9E772A),
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Center(child: Text("View Sale",style:_const.raleway_SemiBold_white(12, FontWeight.w600),)),
                                      ),

                                    ],
                                  ),
                                  Image.asset('images/icons8-truck-96 1.png')
                                ],
                              ),
                            ),
                          ],
                        ),






                      ],
                    ),
                  ),


                  SizedBox(height: height*0.025,),
                  Container(

                    margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
                    child:   Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        Container(
                          width: width*0.3,
                          height: height*0.17,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: AssetImage("images/categ.png")
                              )
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: height*0.03,
                              width: width*0.6,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [

                                  Text('03-08-2021',style: TextStyle(color: Color(0xffC4C4C4),fontFamily: 'Raleway-SemiBold',fontSize: height*0.02,fontWeight: FontWeight.w600)),
                                  Text("")

                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: width*0.025),
                              width: width*0.565,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Text("You just got a follow!",style: _const.raleway_regular_darkbrown(18, FontWeight.w700)),

                                      SizedBox(height: height*0.03,),

                                      Container(
                                        height: height*0.04,
                                        width: width*0.25,
                                        padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                                        decoration: BoxDecoration(
                                            color: Color(0xff9E772A),
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Center(child: Text("View Sale",style:_const.raleway_SemiBold_white(12, FontWeight.w600),)),
                                      ),

                                    ],
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),






                      ],
                    ),
                  ),



                ],
              ),
            ),
          ),
bottomNavigationBar: Home_Bottom_Navigation_Bar(),
        ));
  }
}
