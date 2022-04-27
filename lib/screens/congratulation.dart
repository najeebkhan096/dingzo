import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Congratulation extends StatelessWidget {
  Constants _const=Constants();

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return Scaffold(
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
                Center(child: Text("Congratulation",style: _const.raleway_extrabold(27, FontWeight.w800),)),

                SizedBox(height: height*0.03,),
              ],
            ),

          ),




          SizedBox(height: height*0.025,),
Image.asset('images/congrates.png'),

Container(
  width: width*0.1,
  margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
child: Text('You have just listed your first item!',style: _const.raleway_SemiBold_9E772A(25, FontWeight.w600),textAlign: TextAlign.center),
),
          SizedBox(height: height*0.025,),
    Container(
    width: width*0.1,
    margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
    child: Text('Sit tight and get ready to your first sale!',style: _const.raleway_SemiBold_9E772A(25, FontWeight.w600),textAlign: TextAlign.center),),
          SizedBox(height: height*0.025,),

          Container(
            width: width*0.1,
            margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
            child: Text(' In the meantime you can...!',style: _const.raleway_SemiBold_9E772A(25, FontWeight.w600),textAlign: TextAlign.center),
          ),
          SizedBox(height: height*0.05,),

          Container(
            height: height*0.055,
            width: width*1,
            margin: EdgeInsets.only(left: width*0.1,right: width*0.1),
            decoration: BoxDecoration(
                color: Color(0xffEFB546),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Center(child: Text("List a New Item",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
          ),

          SizedBox(height: height*0.025,),


          Container(
            height: height*0.055,
            width: width*1,
            margin: EdgeInsets.only(left: width*0.1,right: width*0.1),
            decoration: BoxDecoration(
                color: Color(0xffEFB546),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Center(child: Text("View my listing",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
          ),
          SizedBox(height: height*0.025,),

          Container(
            height: height*0.055,
            width: width*1,
            margin: EdgeInsets.only(left: width*0.1,right: width*0.1),
            decoration: BoxDecoration(
                color: Color(0xffEFB546),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Center(child: Text("Browse products",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
          ),
          SizedBox(height: height*0.025,),

          Container(
            height: height*0.055,
            width: width*1,
            margin: EdgeInsets.only(left: width*0.1,right: width*0.1),
            decoration: BoxDecoration(
                color: Color(0xffEFB546),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Center(child: Text("Return to Home",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
          ),
          SizedBox(height: height*0.025,),

        ],
      ),
      bottomNavigationBar: Home_Bottom_Navigation_Bar(),
    );
  }
}
