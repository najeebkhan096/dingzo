import 'dart:convert';
import 'package:dingzo/constants.dart';
import 'package:dingzo/screens/BuyerOrder/InProgress.dart';
import 'package:dingzo/screens/BuyerOrder/completed.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class User_Order_Screen extends StatefulWidget {
  static const routename = "User_Order_Screen";
  @override
  _User_Order_ScreenState createState() => _User_Order_ScreenState();
}

class _User_Order_ScreenState extends State<User_Order_Screen>  with SingleTickerProviderStateMixin{
  @override
  Color active = Colors.green;
  Color inactive = Color(0xffF9F9F9);
  bool isrecieved = true;

  Constants _const=Constants();

  @override

  late TabController _controller;


  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    _controller = TabController(length: 2, vsync: this);
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
          length: 2,
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

                              Text(""),

                              Image.asset('images/cart.png',)
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
                            Padding(
                              padding: const EdgeInsets.only(left: 35, right: 35),
                              child: Text(
                                'InProgress',
                              ),
                            ),
                          ),
                          Tab(
                            child: // Adobe XD layer: 'Second Opinion' (text)
                            Padding(
                              padding: const EdgeInsets.only(left: 30.0, right: 30),
                              child: Text(
                                'Completed',
                              ),
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

                        BuyerInProgress(),

                          BuyerCompleted()

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
