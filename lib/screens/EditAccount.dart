import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditAccount extends StatelessWidget {
  Constants _const=Constants();
  List categ=[
    {
      'image':"images/icons8-shirt-64 1.png",
      'title':"Shirts"
    },
    {
      'image':"images/hobby icon.png",
      'title':"Hobby"
    },
    {
      'image':"images/beauty care logo.png",
      'title':"Beauty"
    },
    {
      'image':"images/icons8-lamp-96 1.png",
      'title':"Rooms"
    },
    {
      'image':"images/icons8-lamp-96 1.png",
      'title':"Rooms"
    },

  ];
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            Container(
              height: height*0.15,
              width: width*1,
              decoration: BoxDecoration(
                  color:  Color(0xffFFEA9D),
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(40))
              ),
              child: Column(

                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(

                        child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            child:SvgPicture.asset('images/back.svg',height: height*0.025,)
                        ),
                      ),


                      Text("EditAccount",style: _const.raleway_extrabold(30, FontWeight.w800)),
                      Image.asset('images/cart.png',)
                    ],
                  ),

                  SizedBox(height: height*0.03,),
                ],
              ),

            ),
            SizedBox(height: height*0.025,),
Center(child: Text("Email",style:_const.raleway_SemiBold_9E772A(20, FontWeight.w600))),
            SizedBox(height: height*0.025,),

            Container(
              margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

              height: height*0.07,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(233, 219, 171, 0.44),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(child: Text("elleapp@gmail.com",style: _const.raleway_SemiBold_9E772A(17, FontWeight.w600),)),
            ),
            SizedBox(height: height*0.025,),


            Center(child: Text("Password",style:_const.raleway_SemiBold_9E772A(20, FontWeight.w600))),
            SizedBox(height: height*0.025,),


            Container(
              margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

              height: height*0.07,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(233, 219, 171, 0.44),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(child: Text("Current Password",style: _const.raleway_SemiBold_9E772A(17, FontWeight.w600),)),
            ),
            SizedBox(height: height*0.025,),

            Container(
              margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

              height: height*0.07,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(233, 219, 171, 0.44),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(child: Text("New Password",style: _const.raleway_SemiBold_9E772A(17, FontWeight.w600),)),
            ),
            SizedBox(height: height*0.025,),

            Container(
              margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

              height: height*0.07,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(233, 219, 171, 0.44),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(child: Text("Confirm Password",style: _const.raleway_SemiBold_9E772A(17, FontWeight.w600),)),
            ),
            SizedBox(height: height*0.025,),
            Container(
              height: height*0.055,
              width: width*1,
              margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

              padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
              decoration: BoxDecoration(
                  color: Color(0xffEFB546),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(child: Text("Update",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
            ),
            SizedBox(height: height*0.025,),
            Container(
              margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

              height: height*0.07,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(233, 219, 171, 0.44),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(child: Text("Close Account",style: _const.raleway_SemiBold_9E772A(17, FontWeight.w600),)),
            ),
            SizedBox(height: height*0.025,),
          ],
        ),
        bottomNavigationBar: Home_Bottom_Navigation_Bar(),
      ),
    );
  }
}