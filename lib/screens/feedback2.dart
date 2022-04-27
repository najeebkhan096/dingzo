import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Feedback2 extends StatelessWidget {
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
                Center(child: Text("Feedback",style: _const.raleway_extrabold(27, FontWeight.w800),)),

                SizedBox(height: height*0.03,),
              ],
            ),

          ),

          SizedBox(height: height*0.05,),
          Center(child: Text("Contact Us",style: _const.raleway_extrabold(27, FontWeight.w800),)),
          SizedBox(height: height*0.05,),
          Container(
              width: width*1,
              margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

              decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(15)
              ),
              child: Text("Please tell us how you think of the app so we can make it better for you!",style: _const.raleway_SemiBold_darkbrown(20, FontWeight.w600),textAlign: TextAlign.center,)
          ),
          SizedBox(height: height*0.05,),

          Container(
            margin: EdgeInsets.only(left: width*0.1,right: width*0.1,bottom: height*0.025),
            height: height*0.055,
            decoration: BoxDecoration(
                color: Color(0xffEFB546),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Center(child: Text("Select A Reason",style: TextStyle(color: Colors.white),)),
          ),
          SizedBox(height: height*0.025,),

          Container(
            margin: EdgeInsets.only(left: width*0.05,right: width*0.05),

            height: height*0.2,
            width: width*1,
            decoration: BoxDecoration(
                color: Color(0xffFFF7D9),
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


            margin: EdgeInsets.only(left: width*0.065),


            child:   Text("Add Photos",style:  TextStyle(



                color: Color(0xffEFB546),



                fontFamily: 'Raleway-SemiBold',



                fontWeight: FontWeight.w600,



                fontSize: 16



            ),),



          ),


          SizedBox(height: height*0.025,),

          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: width*0.05,right: width*0.05),

                height: height*0.15,
                width: width*0.28,
                decoration: BoxDecoration(
                    color: Color(0xffE7E7E7),
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Center(
                  child: CircleAvatar(
                    radius: 23,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.add,color: Color(0xffCCD2E3),size: 24),
                  ),
                ),
              ),
            ],
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
            child: Center(child: Text("Send Message",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
          ),

          SizedBox(height: height*0.05,),

        ],
      ),
      bottomNavigationBar: Home_Bottom_Navigation_Bar(),
    );
  }
}
