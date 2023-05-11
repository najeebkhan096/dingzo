import 'dart:convert';
import 'package:dingzo/constants.dart';
import 'package:dingzo/model/order.dart';
import 'package:dingzo/model/product.dart';
import 'package:dingzo/screens/SellItem.dart';
import 'package:dingzo/screens/buying/Buyer_Sell_order/completed.dart';
import 'package:dingzo/screens/buying/Buyer_Sell_order/pickup.dart';
import 'package:dingzo/screens/buying/Buyer_Sell_order/rating.dart';
import 'package:dingzo/screens/cart.dart';
import 'package:dingzo/screens/checkout.dart';
import 'package:dingzo/screens/selling/SellerSell_Item_Detail_Page/completed.dart';
import 'package:dingzo/screens/selling/SellerSell_Item_Detail_Page/pickup.dart';
import 'package:dingzo/screens/selling/SellerSell_Item_Detail_Page/rating.dart';
import 'package:dingzo/screens/selling/Seller_Rent_Item_Detail_Page/completed.dart';
import 'package:dingzo/screens/selling/Seller_Rent_Item_Detail_Page/pickup.dart';
import 'package:dingzo/screens/selling/Seller_Rent_Item_Detail_Page/rating.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Buyer_Sell_Home_Page extends StatefulWidget {

  static const routename = "Buyer_Sell_Home_Page";
  Order ? current_order;
  Buyer_Sell_Home_Page({this.current_order});

  @override
  _Buyer_Sell_Home_PageState createState() => _Buyer_Sell_Home_PageState();
}

class _Buyer_Sell_Home_PageState extends State<Buyer_Sell_Home_Page>  with SingleTickerProviderStateMixin{
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

    _controller = TabController(length: 3, vsync: this);
  }


  bool fetched=false;
  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies

    super.didChangeDependencies();
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
          length: 3,
          child: Scaffold(
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
            backgroundColor: Colors.white,

            body: Container(
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
                            'Rating',
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


                        widget.current_order!.order_status=="in_progress"?
                        Buyer_Sell_Pickup( desired_order: widget.current_order):
                        Center(child: Text("No Item")),

                        widget.current_order!.order_status=="rating"?
                        Buyer_Sell_Rating(widget.current_order!):Center(child: Text("No Item")),

                        widget.current_order!.order_status=="completed"?
                        Buyer_Sell_Complete(desired_order:  widget.current_order):Center(child: Text("No Item")),

                      ],
                    ),
                  )
                ],
              ),
            ),

          ),
        ));
  }
}
