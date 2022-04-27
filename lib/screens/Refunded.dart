import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Refunded extends StatelessWidget {
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
                Center(child: Text("You have Been Refunded",style: _const.raleway_extrabold(27, FontWeight.w800),)),

                SizedBox(height: height*0.03,),
              ],
            ),

          ),

          SizedBox(height: height*0.025,),
          Center(child: Text("Items",style: _const.raleway_SemiBold_9E772A(20, FontWeight.w600),textAlign: TextAlign.center,)),


          SizedBox(height: height*0.025,),
          Divider(),
          SizedBox(height: height*0.025,),

          Container(
            margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
            child:   Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
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
                    Positioned(child: Container(
                        margin: EdgeInsets.only(left: width*0.025),
                        decoration: BoxDecoration(
                            color: Color(0xffEFB546),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Text("SOLD",style: TextStyle(color: Colors.white),)),left: 0,top: 0,),

                  ],
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              SizedBox(height: height*0.045,),
              Container(
                margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("SubTotal",style: _const.raleway_SemiBold_darkbrown(15, FontWeight.w600),),
                        Text("\$4.0",style: _const.raleway_SemiBold_darkbrown(15, FontWeight.w600),),


                      ],
                    ),
                    SizedBox(height: height*0.015,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Shipping",style: _const.raleway_SemiBold_darkbrown(15, FontWeight.w600),)
                        ,Text("\$4.0",style: _const.raleway_SemiBold_darkbrown(15, FontWeight.w600),),


                      ],
                    ),
                    SizedBox(height: height*0.015,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Shipping",style: _const.raleway_SemiBold_darkbrown(15, FontWeight.w600),)
                        , Text("\$4.0",style: _const.raleway_SemiBold_darkbrown(15, FontWeight.w600),),


                      ],
                    ),
                    SizedBox(height: height*0.015,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tax",style: _const.raleway_SemiBold_darkbrown(15, FontWeight.w600),)
                        ,Text("\$4.0",style: _const.raleway_SemiBold_darkbrown(15, FontWeight.w600),),


                      ],
                    ),
                    SizedBox(height: height*0.015,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Fee",style: _const.raleway_SemiBold_darkbrown(15, FontWeight.w600),)
                        ,Text("\$4.0",style: _const.raleway_SemiBold_darkbrown(15, FontWeight.w600),),


                      ],
                    ),
                    SizedBox(height: height*0.025,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Estimated Refund",style: _const.raleway_SemiBold_darkbrown(15, FontWeight.w600),)
                        ,Text("\$4.0",style: _const.raleway_SemiBold_darkbrown(15, FontWeight.w600),),


                      ],
                    ),


                  ],
                ),
              ),
              SizedBox(height: height*0.045,),
              InkWell(
                onTap: (){

                  Navigator.of(context).pop();
                },
                child: Center(
                  child: Container(
                    height: height*0.055,
                    width: width*1,
                    margin: EdgeInsets.only(left: width*0.1,right: width*0.1),
                    padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                    decoration: BoxDecoration(
                        color: Color(0xffEFB546),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(child: Text("Go Back To Home",style:_const.raleway_SemiBold_white(12, FontWeight.w600),)),
                  ),
                ),
              ),
            ],

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
            child: Center(child: Text("Back to Homes",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
          ),

          SizedBox(height: height*0.025,),

        ],
      ),
      bottomNavigationBar: Home_Bottom_Navigation_Bar(),
    );
  }
}
