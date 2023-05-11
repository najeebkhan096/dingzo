import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/screens/cart.dart';
import 'package:dingzo/screens/checkout.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HelpCenter2 extends StatelessWidget {
  static const routename="HelpCenter2";
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

        appBar: AppBar(
          elevation: 0.8,

          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text("Help Center",style: _const.manrope_regular263238(20, FontWeight.w800)),
          leading: IconButton(onPressed: (){
            Navigator.of(context).pop();

          }, icon: Icon(Icons.arrow_back_ios,color: Color(0xff3A4651),)),
          actions: [

            InkWell(
              onTap: (){
                Navigator.of(context).pushNamed(Checkout.routename);
              },
              child: Container(
                child: Image.asset('images/cart.png',color: Color(0xff263238)),
              ),
            ),
          ],
        ),

        body: ListView(

          children: [


            SizedBox(height: height*0.025,),

            Center(
              child: Container(
                  margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
                  child: Text("Contacts Us",style: _const.raleway_263238(27, FontWeight.w800),textAlign: TextAlign.center,)),
            ),


            SizedBox(height: height*0.025,),
        Container(
      margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
      child: Text("Select a reason to help us better solve your problem.",style: _const.raleway_1A5A47( 20, FontWeight.w600),textAlign: TextAlign.center,)),

            SizedBox(height: height*0.025,),

            Container(
              height: height*0.055,
              width: width*1,
              margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

              padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
              decoration: BoxDecoration(
                  color: mycolor,
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Center(child: Text("Select A Reason",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
            ),

            SizedBox(height: height*0.025,),

            Container(
              margin: EdgeInsets.only(left: width*0.05,right: width*0.05),

              height: height*0.2,
              width: width*1,
              decoration: BoxDecoration(
                color: Color(0xffBCEFE0),
                borderRadius: BorderRadius.circular(15)
              ),

            child: TextField(
              decoration: InputDecoration(
                hintText: "Add Details...",
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: width*0.05),
                hintStyle: _const.raleway_1A5A47(16, FontWeight.w600)

              ),
            ),
            ),

            SizedBox(height: height*0.025,),
Container(


      margin: EdgeInsets.only(left: width*0.065),


      child:   Text("Add Photos",style: _const.raleway_263238(16, FontWeight.w600)
      ),



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
              margin: EdgeInsets.only(left: width*0.05,right: width*0.05),

              child: Text("***Please don’t provide sensitive information such as credit card info."
              ,style: _const.raleway_263238(14, FontWeight.w600),
              ),
            ),

            SizedBox(height: height*0.025,),

            Container(

                margin: EdgeInsets.only(left: width*0.05,right: width*0.05),

                child: Text('Estimated Response Time: 5 Minutes',style: _const.raleway_263238(12, FontWeight.w600),))

,


            SizedBox(height: height*0.05,),

            Container(
              height: height*0.055,
              width: width*1,
              margin: EdgeInsets.only(left: width*0.1,right: width*0.1),
              padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
              decoration: BoxDecoration(
                  color: mycolor,
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Center(child: Text("Select A Reason",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
            ),

            SizedBox(height: height*0.05,),


          ],
        ),

      ),
    );
  }
}
