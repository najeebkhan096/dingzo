import 'package:dingzo/constants.dart';
import 'package:dingzo/hometesting.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/screens/checkout.dart';
import 'package:dingzo/screens/home.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FeedbackScreen extends StatelessWidget {
  static const routename="FeedbackScreen";


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
      appBar: AppBar(

        leadingWidth: width*0.3,

        backgroundColor: Colors.white,

        centerTitle: true,

        title: Text("Feedback",style: _const.raleway_263238(20, FontWeight.w700),

          textAlign: TextAlign.center,

        ),

        actions: [
          InkWell(
              onTap: (){
                Navigator.of(context).pushNamed(Checkout.routename);
              },
              child: Icon(Icons.settings,color: Color(0xff263238),size: 30)),
          Container(
            child: Image.asset('images/cart.png',color: Color(0xff263238)),
          ),
        ],
      ),
      body: ListView(
        children: [

          SizedBox(height: height*0.05,),
          Center(child: Text("Thank you!",style: _const.poppin_BlackBold(27, FontWeight.w800),)),
          SizedBox(height: height*0.05,),
          Container(
              width: width*1,
              margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

              decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(15)
              ),
              child: Text("Your feedback has been recieved!",style: _const.poppin_SemiBold(20, FontWeight.w600),textAlign: TextAlign.center,)
          ),
          SizedBox(height: height*0.05,),

          InkWell(
            onTap: (){
              Navigator.of(context).pushNamedAndRemoveUntil(HomeTesting.routename, (route) => false);
            },
            child: Container(
              margin: EdgeInsets.only(left: width*0.1,right: width*0.1,bottom: height*0.025),
              height: height*0.055,
              decoration: BoxDecoration(
                  color: mycolor,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(child: Text("Return to Home",style: TextStyle(color: Colors.white),)),
            ),
          ),

        ],
      ),

    );
  }
}
