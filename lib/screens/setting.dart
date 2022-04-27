import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Setting extends StatelessWidget {
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


                      Text("Setting",style: _const.raleway_extrabold(30, FontWeight.w800)),
                      Image.asset('images/cart.png',)
                    ],
                  ),

                  SizedBox(height: height*0.03,),
                ],
              ),

            ),


            SizedBox(height: height*0.025,),

            Container(
              margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

              height: height*0.07,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(233, 219, 171, 0.44),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(child: Text("Edit Account",style: _const.raleway_SemiBold_9E772A(17, FontWeight.w600),)),
            ),
            SizedBox(height: height*0.025,),

            Container(
              margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

              height: height*0.07,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(233, 219, 171, 0.44),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(child: Text("Edit Profile",style: _const.raleway_SemiBold_9E772A(17, FontWeight.w600),)),
            ),
            SizedBox(height: height*0.025,),

            Container(
              margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

              height: height*0.07,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(233, 219, 171, 0.44),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(child: Text("Edit Address",style: _const.raleway_SemiBold_9E772A(17, FontWeight.w600),)),
            ),
            SizedBox(height: height*0.025,),

            Container(
              margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

              height: height*0.07,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(233, 219, 171, 0.44),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(child: Text("Edit Payment Methods",style: _const.raleway_SemiBold_9E772A(17, FontWeight.w600),)),
            ),
            SizedBox(height: height*0.025,),

            Container(
              margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

              height: height*0.07,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(233, 219, 171, 0.44),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(child: Text("Vacation",style: _const.raleway_SemiBold_9E772A(17, FontWeight.w600),)),
            ),
            SizedBox(height: height*0.025,),
            Container(
              margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

              height: height*0.07,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(233, 219, 171, 0.44),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(child: Text("Onboard With Stripe",style: _const.raleway_SemiBold_9E772A(17, FontWeight.w600),)),
            ),
            SizedBox(height: height*0.025,),Container(
              margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

              height: height*0.07,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(233, 219, 171, 0.44),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(child: Text("Terms of Services",style: _const.raleway_SemiBold_9E772A(17, FontWeight.w600),)),
            ),
            SizedBox(height: height*0.025,),Container(
              margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

              height: height*0.07,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(233, 219, 171, 0.44),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(child: Text("Privacy Policy",style: _const.raleway_SemiBold_9E772A(17, FontWeight.w600),)),
            ),

            SizedBox(height: height*0.025,),Container(
              margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

              height: height*0.07,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(233, 219, 171, 0.44),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(child: Text("Logout",style: _const.raleway_SemiBold_9E772A(17, FontWeight.w600),)),
            ),
            SizedBox(height: height*0.025,),


          ],
        ),
        bottomNavigationBar: Home_Bottom_Navigation_Bar(),
      ),
    );
  }
}
