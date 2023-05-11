import 'dart:convert';
import 'package:dingzo/constants.dart';

import 'package:dingzo/screens/selling/Rating.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderProcessed extends StatefulWidget {

  static const routename = "OrderProcessed";
  @override
  _OrderProcessedState createState() => _OrderProcessedState();
}

class _OrderProcessedState extends State<OrderProcessed>  with SingleTickerProviderStateMixin{
  @override
  Color active = Colors.green;
  Color inactive = Color(0xffF9F9F9);
  bool isrecieved = true;

  Constants _const=Constants();

  @override

  late TabController _controller;

  void _showModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          final height = MediaQuery.of(context).size.height;
          final width = MediaQuery.of(context).size.width;
          return new Container(

            color: Color(0xffFFEA9D),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height*0.025,),
                Center(child: Text("Reciept",style: _const.raleway_SemiBold_darkbrown(25, FontWeight.w700),))
                ,

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
                      height: height*0.05,
                      width: width*0.25,
                      padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                      decoration: BoxDecoration(
                          color: Color(0xffEFB546),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(child: Text("Done",style:_const.raleway_SemiBold_white(12, FontWeight.w600),)),
                    ),
                  ),
                ),
              ],

            ),
          );
        }
    );
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    _controller = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
    _controller.dispose();
  }

  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,

          body: ListView(

            children: [
              Container(
                height: height*0.15,
                padding: EdgeInsets.only(left: width*0.025),
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
                        CircleAvatar(
                          backgroundColor:  Colors.white,
                          child: SvgPicture.asset('images/back.svg',height: height*0.025,),
                        ),

                        Container(
                            width: width*0.8,
                            child: Text("Your order has been processed",style: _const.raleway_EFB546(25, FontWeight.w800),textAlign: TextAlign.center,)),

                      Text("")
                      ],
                    ),

                    SizedBox(height: height*0.03,),



                  ],
                ),

              ),
              SizedBox(height: height*0.025,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                                      child: Center(child: Text("View Order",style:_const.raleway_SemiBold_white(12, FontWeight.w600),)),
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
                            child: Text("Your order has been processed!",style: _const.raleway_SemiBold_9E772A(15 , FontWeight.w600),textAlign: TextAlign.center,)),
                      ),

                    ],
                  ),
                  SizedBox(height: height*0.02,),
                  Container(
                    height: height*0.05,
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
                    height: height*0.05,
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
                    height: height*0.05,
                    width: width*1,
                    margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

                    padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                    decoration: BoxDecoration(
                        color: Color(0xffEFB546),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(child: Text("Sell One Like this",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
                  ),

                  SizedBox(height: height*0.03,),
                  Container(
                      margin: EdgeInsets.only(left: width*0.05),

                      child: Text("Seller  Information",style: _const.raleway_SemiBold_9E772A(20 , FontWeight.w600),)),

                  SizedBox(height: height*0.02,),


                  Container(
                    margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
                    width: width * 1,
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
                                    children: [
                                      Row(
                                        children: List.generate(
                                            4,
                                                (index) => Icon(
                                              Icons.star,
                                              color: Colors.yellow,
                                            )),
                                      ),
                                      Text(
                                        "(1.0)",
                                        style: _const.raleway_SemiBold_9E772A(
                                            17, FontWeight.w600),
                                      )

                                    ],
                                  ),

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

                ],
              ),
              SizedBox(height: height*0.03,),
            ],
          ),

        ));
  }
}
