import 'dart:convert';
import 'package:dingzo/constants.dart';
import 'package:dingzo/model/order.dart';
import 'package:dingzo/screens/buying/Buyer_Rent_Order/pickup.dart';
import 'package:dingzo/screens/buying/Buyer_Rent_Order/completed.dart';
import 'package:dingzo/screens/buying/Buyer_Rent_Order/rating.dart';
import 'package:dingzo/screens/buying/Buyer_Rent_Order/in_use.dart';
import 'package:dingzo/screens/buying/Buyer_Rent_Order/return_item.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BuyingDetail extends StatefulWidget {
  static const routename = "BuyingDetail";


  @override
  _BuyingDetailState createState() => _BuyingDetailState();
}

class _BuyingDetailState extends State<BuyingDetail>  with SingleTickerProviderStateMixin{
  @override
  Color active = Colors.green;
  Color inactive = Color(0xffF9F9F9);
  bool isrecieved = true;

  Constants _const=Constants();

  @override

  late TabController _controller;
  Order ? current_order;
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

    _controller = TabController(length: 5, vsync: this);
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
current_order=ModalRoute.of(context)!.settings.arguments as Order;
    return SafeArea(
        child: DefaultTabController(
          length: 5,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0.8,
              leadingWidth: width*0.3
              ,
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Text("Buying",style: _const.manrope_regular263238(20, FontWeight.w800)),
              leading: IconButton(onPressed: (){
                Navigator.of(context).pop();

              }, icon: Icon(Icons.arrow_back_ios,color: Color(0xff3A4651),)),

            ),
            body: SingleChildScrollView(
              child: Container(
                height: height*1,
                child: Column(

                  children: [

                    SizedBox(height: height*0.025,),

                    Container(
                      alignment: Alignment.center,
                      width: width * 1,
                      margin: EdgeInsets.only(left: width*0.05),

                      child: TabBar(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        indicator: BoxDecoration(
                            color: mycolor,
                            borderRadius: BorderRadius.circular(10)),
                        labelColor: Colors.white,
                        unselectedLabelColor: Color(0xff333333),
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
                              'Pickup',
                            ),
                          ),

                          Tab(
                            child: // Adobe XD layer: 'Second Opinion' (text)
                            Text(
                              'In Use',
                            ),
                          ),
                          Tab(
                            child: // Adobe XD layer: 'Second Opinion' (text)
                            Text(
                              'Return Item',
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

                          Buyer_Rent_Pickup(current_order!.order_id!),
                          Buyer_Rent_In_Use(current_order!.order_id!),
                          Buyer_Rent_Return_Item(current_order!.order_id!),
                          Buyer_Rent_Rating(current_order!.order_id!),
                          Buyer_Rent_Complete(current_order!.order_id!)


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
