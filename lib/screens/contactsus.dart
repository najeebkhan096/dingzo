import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContactUs extends StatelessWidget {
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


                    Text(""),
                    Image.asset('images/cart.png',)
                  ],
                ),

                SizedBox(height: height*0.03,),
              ],
            ),

          ),

          SizedBox(height: height*0.025,),
Center(child: Text("Contact Us",style: _const.raleway_extrabold(27, FontWeight.w800),)),
          SizedBox(height: height*0.025,),
          Container(
            width: width*1,
            margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

            decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(15)
            ),
            child: Text("Select a reason to help us better solve your problem.",style: _const.raleway_SemiBold_darkbrown(20, FontWeight.w600),textAlign: TextAlign.center,)
          ),
          SizedBox(height: height*0.025,),

          Column(
            children: List.generate(categ.length, (index) =>  Container(
              margin: EdgeInsets.only(left: width*0.1,right: width*0.1,bottom: height*0.025),
              height: height*0.05,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(233, 219, 171, 0.44),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(child: Text(categ[index].toString(),style: _const.raleway_SemiBold_9E772A(17, FontWeight.w600),)),
            ),),
          ),


        ],
      ),
      bottomNavigationBar: Home_Bottom_Navigation_Bar(),
    );
  }
}
