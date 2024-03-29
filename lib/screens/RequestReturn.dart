import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RequestReturn extends StatelessWidget {
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
                Center(child: Text("Request Return",style: _const.raleway_extrabold(27, FontWeight.w800),)),

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

                  child: Text("Why do you want to return this item?",style: _const.raleway_SemiBold_9E772A(20, FontWeight.w600),textAlign: TextAlign.center,)),


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
            children: List.generate(3, (index) =>  Container(
              margin: EdgeInsets.only(left: width*0.05,),

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
            ),)
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

            ],

          ),



          Container(
            height: height*0.055,
            width: width*1,
            margin: EdgeInsets.only(left: width*0.1,right: width*0.1),
            decoration: BoxDecoration(
                color: Color(0xffEFB546),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Center(child: Text("Request a Return",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
          ),

          SizedBox(height: height*0.025,),

        ],
      ),

    );
  }
}
