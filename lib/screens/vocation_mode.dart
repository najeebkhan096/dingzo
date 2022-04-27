import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VocationMode extends StatelessWidget {
  Constants _const=Constants();

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


                      Text("VocationMode",style: _const.raleway_extrabold(27, FontWeight.w800)),
                      Image.asset('images/cart.png',)
                    ],
                  ),

                  SizedBox(height: height*0.03,),
                ],
              ),

            ),
            SizedBox(height: height*0.025,),

            Center(child: Text("Vacation Mode ",style: _const.raleway_regular_darkbrown(20, FontWeight.w600),)),

            SizedBox(height: height*0.025,),

            Container(
                margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
                child: Text("Vacation Mode hides your listings while you are away so you won’t get new orders.",style: _const.raleway_regular_darkbrown(20, FontWeight.w600),textAlign: TextAlign.center,)),

            SizedBox(height: height*0.05,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: height*0.055,
                  width: width*0.3,

                  decoration: BoxDecoration(
                      color: Color(0xffEFB546),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(child: Text("OFF",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
                ),

                SizedBox(width: width*0.05,),

                Container(
                  height: height*0.055,
                  width: width*0.3,

                  decoration: BoxDecoration(
                      color: Color.fromRGBO(233, 219, 171, 0.44),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(child: Text("ON",style: _const.raleway_SemiBold_9E772A(17, FontWeight.w600),textAlign: TextAlign.center,)),
                ),
              ],
            ),

          ],
        ),
        bottomNavigationBar: Home_Bottom_Navigation_Bar(),
      ),
    );
  }
}
