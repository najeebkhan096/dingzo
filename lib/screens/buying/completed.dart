import 'package:dingzo/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Completed extends StatelessWidget {

  Constants _const=Constants();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [

          SizedBox(height: height*0.02,),

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

                Expanded(

                  child: Container(
                    margin: EdgeInsets.only(left: width*0.025,right: width*0.025),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Chargers",style: _const.raleway_SemiBold_darkbrown(20, FontWeight.w600)),
                            Text("\$4.99",style: _const.raleway_SemiBold_darkbrown(15, FontWeight.w600)),

                          ],
                        ),

                        SizedBox(height: height*0.015,),
                        Text("Order ID: EL3834",style: _const.raleway_SemiBold_darkbrown(15, FontWeight.w600)),
                        SizedBox(height: height*0.015,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: height*0.04,
                              width: width*0.25,
                              padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                              decoration: BoxDecoration(
                                  color: Color(0xffEFB546),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Center(child: Text("View Sale",style:_const.raleway_SemiBold_white(12, FontWeight.w600),)),
                            ),

                            Container(
                              height: height*0.04,
                              width: width*0.25,
                              padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                              decoration: BoxDecoration(
                                  color: Color(0xffEFB546),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Center(child: Text("View Reciept",style:_const.raleway_SemiBold_white(12, FontWeight.w600),)),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),





              ],
            ),
          ),
          SizedBox(height: height*0.01,),
          Divider(),
          SizedBox(height: height*0.01,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                    margin: EdgeInsets.only(left: width*0.05),

                    child: Text("Congratulations! ",style: _const.raleway_SemiBold_9E772A(20 , FontWeight.w600),)),
              ),

              SizedBox(height: height*0.02,),

              Center(
                child: Container(
                    margin: EdgeInsets.only(left: width*0.05),
width: width*0.45,
                    child: Text("Your order has been completed. Continue shopping here.",style: _const.raleway_SemiBold_9E772A(15 , FontWeight.w600),textAlign: TextAlign.center,)),
              ),

            ],
          ),
          SizedBox(height: height*0.02,),
          Container(
            height: height*0.055,
            width: width*1,
            margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

            padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
            decoration: BoxDecoration(
                color: Color(0xffEFB546),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Center(child: Text("Continue Shopping",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
          ),
          SizedBox(height: height*0.02,),
          Divider(),

          SizedBox(height: height*0.02,),
          Container(
            height: height*0.055,
            width: width*1,
            margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

            padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
            decoration: BoxDecoration(
                color: Color(0xffEFB546),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Center(child: Text("Message Seller",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
          ),


          SizedBox(height: height*0.02,),
          Container(
            height: height*0.055,
            width: width*1,
            margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

            padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
            decoration: BoxDecoration(
                color: Color(0xffEFB546),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Center(child: Text("Sell One Like This",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
          ),
          SizedBox(height: height*0.02,),

          Container(
              margin: EdgeInsets.only(left: width*0.05),

              child: Text("Seller Information",style: _const.raleway_SemiBold_9E772A(20 , FontWeight.w600),)),

          SizedBox(height: height*0.02,),


          Container(
            margin: EdgeInsets.only(left: width * 0.025,right: width * 0.025),
            width: width * 0.6,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage("images/radiant.png"),
                ),
                Container(
                  width: width*0.7,
                  margin: EdgeInsets.only(left: width * 0.025),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Text("Melissa So",
                                style: _const.raleway_SemiBold_9E772A(
                                    15, FontWeight.w600)),
                          ),

                          Row(
                            children: List.generate(
                                5,
                                    (index) => Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                )),
                          ),
                          Text(
                            "5.0",
                            style: _const.poppin_orange(
                                17, FontWeight.w600),
                          )
                        ],
                      ),

                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const  Color(0xff8B6824))
                        ),
                        padding: EdgeInsets.only(left: width*0.025,right: width*0.025,bottom: height*0.01,top: height*0.01),
                        child:   Text("Follow",style: _const.raleway_regular_brown(15, FontWeight.w600)),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),

          SizedBox(height: height*0.03,),

        ],
      ),
    );
  }
}
