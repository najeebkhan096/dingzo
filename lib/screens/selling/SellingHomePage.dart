import 'dart:convert';
import 'package:dingzo/constants.dart';
import 'package:dingzo/screens/selling/NewShipped.dart';
import 'package:dingzo/screens/selling/completed.dart';
import 'package:dingzo/screens/selling/Rating.dart';
import 'package:dingzo/screens/selling/shipped.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SellingHomePage extends StatefulWidget {

  static const routename = "SellingHomePage";
  @override
  _SellingHomePageState createState() => _SellingHomePageState();
}

class _SellingHomePageState extends State<SellingHomePage>  with SingleTickerProviderStateMixin{
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
height: height*0.5,
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
        child: DefaultTabController(
          length: 4,
          child: Scaffold(
            backgroundColor: Colors.white,

            body: SingleChildScrollView(
              child: Container(
                height: height*1,
                child: Column(

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
                              CircleAvatar(
                                backgroundColor:  Colors.white,
                                child: SvgPicture.asset('images/back.svg',height: height*0.025,),
                              ),

                              Text("Selling",style: _const.raleway_extrabold(30, FontWeight.w800),),

                              InkWell(
                                  onTap: (){
                                    _showModalSheet();
                                  },
                                  child: Image.asset('images/cart.png',))
                            ],
                          ),

                          SizedBox(height: height*0.03,),



                        ],
                      ),

                    ),
                    SizedBox(height: height*0.025,),

                    Container(
                      alignment: Alignment.center,
                      width: width * 1,
                      margin: EdgeInsets.only(left: width*0.05),

                      child: TabBar(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        indicator: BoxDecoration(
                            color: Color(0xffEFB546),
                            borderRadius: BorderRadius.circular(10)),
                        labelColor: Colors.white,
                        unselectedLabelColor: Color(0xffEFB546),
                        indicatorColor: Color(0xff722BFF),
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelStyle: _const.raleway_SemiBold_brown(12, FontWeight.w600),
                        isScrollable: true,
                        indicatorWeight: height * 0.002,
                        unselectedLabelStyle: _const.raleway_SemiBold_brown(12, FontWeight.w600),
                        controller: _controller,
                        tabs: [

                          Tab(
                            child: // Adobe XD layer: 'Emergency (6)' (text)
                            Text(
                              'NewShipped',
                            ),
                          ),

                          Tab(
                            child: // Adobe XD layer: 'Second Opinion' (text)
                            Text(
                              'Shipped',
                            ),
                          ),
                          Tab(
                            child: // Adobe XD layer: 'Second Opinion' (text)
                            Text(
                              'Ratting',
                            ),
                          ),
                          Tab(
                            child: // Adobe XD layer: 'Second Opinion' (text)
                            Text(
                              'Completed',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _controller,
                        children: [
                          //pending

                          NewShipped(),

                          Shipped(),
                          Rating(),

                          Completed()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ),
        ));
  }
}
