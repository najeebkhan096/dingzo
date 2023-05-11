import 'dart:convert';
import 'package:dingzo/Database/SociaMediaDatabase.dart';
import 'package:dingzo/Database/database.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/model/order.dart';
import 'package:dingzo/model/product.dart';
import 'package:dingzo/screens/SellItem.dart';
import 'package:dingzo/screens/buying/BuyingDetail.dart';
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
import 'package:http/http.dart' as http;
class Seller_Sell_item_Detail_Page extends StatefulWidget {

  static const routename = "Seller_Sell_item_Detail_Page";
  Product ? current_product;
  Seller_Sell_item_Detail_Page({this.current_product});

  @override
  _Seller_Sell_item_Detail_PageState createState() => _Seller_Sell_item_Detail_PageState();
}

class _Seller_Sell_item_Detail_PageState extends State<Seller_Sell_item_Detail_Page>  with SingleTickerProviderStateMixin{
  @override
  Color active = Colors.green;
  Color inactive = Color(0xffF9F9F9);
  bool isrecieved = true;

  Constants _const=Constants();
  Future releasefund(String paymentid)async{
    var headers = {
      'Authorization':
      'Bearer sk_test_51IGzrSAWdh8XTc5i5j1vNDw4bbwYRZgAbdVwB4LEouLANRFcerYWv1tKDgOuW6RRm4vdr9N3LrUTlWvkpIQDKEa5005qLPLMOf',

    };
    var request = http.Request('POST', Uri.parse('https://api.stripe.com/v1/payment_intents/${paymentid}/capture'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data=await response.stream.bytesToString();

    }
    else {

      print(response.reasonPhrase);
    }

  }
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

    _controller = TabController(length: 3, vsync: this);
  }
  Order ? current_order;

  bool isloading=false;

  bool fetched=false;
  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    if(fetched==false){
      await    orderdatabase.fetch_in_progress_orders_by_product(widget.current_product!).then((value) async {

        current_order=value;

        if(current_order!.order_status=="rating") {
          bool expred = current_order!.rating_due_date!.isAfter(
              DateTime.now());
          if(expred==false){
            setState(() {
              isloading=true;
            });
            List<double> ratings=await database.fetchrating(DesiredUserID: current_order!.userid);
            ratings.add(5);
            await database.fetch_seller_mini_detail(DesiredUserID:current_order!.userid!).then((sellerend) async{


              await database.update_rating(sellerend!.doc.toString(), ratings, context).then((value) async{
                await     database.updateProductStatus(productid: current_order!.products![0].product_doc_id,status: 'completed').then((value)async {

                  await  releasefund(current_order!.payment_id!).then((value) async{

                    await     database.updateOrder_both_rating(orderid:current_order!.order_id,status: 'completed',

                    ).then((value) async{


                      await socialMediaDatabase.sendPushMessage(title: 'You have new message', body:'Seller rated your order',
                          token: sellerend.deviceid);

                      setState(() {
                        isloading=false;
                      });
Navigator.of(context).pop();


                    });

                  });

                });

              });
            });

          }
          else{

          }
        }
        else{

        }


        setState((){
          fetched=true;
        });

      });


    }
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
              title: Text("Selling",style: _const.manrope_regular263238(20, FontWeight.w800)),
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


                  fetched?
                  Expanded(
                    child: TabBarView(
                      controller: _controller,
                      children: [
                        //pending


                        current_order!.order_status=="in_progress"?
                        Seller_Sell_item_Pickup(current_order: current_order):Center(child: Text("No Item")),

                        current_order!.order_status=="rating"?
                        Seller_Sell_item_Rating(current_order: current_order):Center(child: Text("No Item")),

                        current_order!.order_status=="completed"?
                        Seller_Sell_item_Completed(current_order: current_order):Center(child: Text("No Item")),

                      ],
                    ),
                  ):

                  Center(child: SpinKitRing(color: mycolor))
                  ,
                ],
              ),
            ),

          ),
        ));
  }
}
