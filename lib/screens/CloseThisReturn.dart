import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CloseThisReturn extends StatelessWidget {
  Constants _const=Constants();
  List<String> categ=[
    'How Buying Works',
    'Return Item',
    'Item has Not Arrived',
    'Paying for him',
    'Check status of chase',
    'Shipping/Delivery',
    'How to cancel an Order',
    'Other'


  ];
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
                Center(child: Text("Continue To Case",style: _const.raleway_extrabold(27, FontWeight.w800),)),

                SizedBox(height: height*0.03,),
              ],
            ),

          ),

          SizedBox(height: height*0.025,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Container(
                  width: width*0.8,

                  child: Text("Once this return is closed, a refund will not be processed.",style: _const.raleway_SemiBold_9E772A(20, FontWeight.w600),textAlign: TextAlign.center,)),


            ],
          ),

          SizedBox(height: height*0.025,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Container(
                  width: width*0.8,

                  child: Text("he return cannot be opened again and the sale is final.",style: _const.raleway_SemiBold_9E772A(20, FontWeight.w600),textAlign: TextAlign.center,)),


            ],
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
            child: Center(child: Text("Select a Reason",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
          ),

          SizedBox(height: height*0.025,),

          Container(
            margin: EdgeInsets.only(left: width*0.05,right: width*0.05),

            height: height*0.2,
            width: width*1,
            decoration: BoxDecoration(
                color: Color(0xffF6F6F6),
                borderRadius: BorderRadius.circular(15)
            ),

            child: TextField(
              decoration: InputDecoration(
                  hintText: "Add Details...",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: width*0.05),
                  hintStyle: TextStyle(
                      color: Color(0xffEFB546),
                      fontFamily: 'Raleway-SemiBold',
                      fontWeight: FontWeight.w600,
                      fontSize: 16
                  )
              ),
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

                Container(
                  margin: EdgeInsets.only(left: width*0.025,right: width*0.025),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Chargers",style: _const.raleway_SemiBold_darkbrown(20, FontWeight.w600)),
                      SizedBox(height: height*0.015,),
                      Text("\$4.99",style: _const.raleway_SemiBold_darkbrown(15, FontWeight.w600)),


                    ],
                  ),
                ),





              ],
            ),
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
            child: Center(child: Text("Back to Chase",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
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
            child: Center(child: Text("Close Return",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
          ),

          SizedBox(height: height*0.025,),

        ],
      ),
      bottomNavigationBar: Home_Bottom_Navigation_Bar(),
    );
  }
}
