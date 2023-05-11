import 'package:dingzo/widgets/UserInformation.dart';
import 'package:dingzo/Database/SociaMediaDatabase.dart';
import 'package:dingzo/Database/database.dart';
import 'package:dingzo/Database/sellerdatabase.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/model/chat_reciver.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/model/order.dart';
import 'package:dingzo/model/product.dart';
import 'package:dingzo/screens/chat/chat.dart';
import 'package:dingzo/screens/helpcenter.dart';
import 'package:dingzo/screens/helpcenter2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as cloud;
import 'package:intl/intl.dart';
class Seller_Sell_item_Pickup extends StatelessWidget {

  final Order ? current_order;

  Seller_Sell_item_Pickup({this.current_order});

  double calAverage(List<double> ratings){
    double aver=0;
    double sum=0;

    ratings.forEach((element) {
      sum=sum+element;
    });
    aver=sum/ratings.length;
    return aver;
  }
  void _showModalSheet(BuildContext context) {
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

  Constants _const=Constants();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.white,
        body:       ListView(

          children: [

            SizedBox(height: height * 0.02,),

            Container(
              margin: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: width * 0.3,
                    height: height * 0.17,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: NetworkImage(current_order!.products![0].photos![0])
                        )
                    ),
                  ),

                  Expanded(

                    child: Container(
                      margin: EdgeInsets.only(
                          left: width * 0.025, right: width * 0.025),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(current_order!.products![0].title!,
                                style: _const.raleway_263238(20, FontWeight.w600),),
                              Text("\$${current_order!.products![0].price!
                              }",
                                style: _const.raleway_263238(15, FontWeight.w600),),

                            ],
                          ),

                          SizedBox(height: height * 0.015,),
                          Row(
                            children: [

                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text("Order ID: ${current_order!.order_id.toString()}",
                                    style: _const.raleway_263238(15, FontWeight.w600),
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: height * 0.015,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: height * 0.04,
                                width: width * 0.25,
                                padding: EdgeInsets.only(
                                    left: width * 0.02, right: width * 0.02),
                                decoration: BoxDecoration(
                                    color: Color(0xffBCEFE0),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Center(child: Text("View Order",
                                  style: _const.raleway_535F5B(
                                      10, FontWeight.w600),)),
                              ),

                              InkWell(
                                onTap: (){

                                },
                                child: Container(
                                  height: height * 0.04,
                                  width: width * 0.25,
                                  padding: EdgeInsets.only(
                                      left: width * 0.02, right: width * 0.02),
                                  decoration: BoxDecoration(
                                      color: Color(0xffBCEFE0),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Center(child: Text("View Reciept",
                                    style: _const.raleway_535F5B(
                                        10, FontWeight.w600),)),
                                ),
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
            SizedBox(height: height * 0.01,),
            Divider(),
            SizedBox(height: height * 0.01,),

            Container(
              margin: EdgeInsets.only(left: width * 0.1, right: width * 0.1),
              alignment: Alignment.center,
              child: Text.rich(
                  TextSpan(
                      style: _const.raleway_535F5B(14, FontWeight.w500),
                      text: 'The buyer will be arriving shortly to pickup the item.\n\nPlease be ready to hand the the item to the buyer at the agreed upon time.',
                      children: <InlineSpan>[
                        TextSpan(
                          text: '\n\nMake sure the buyer rates you once you give the item to the buyer so you can recieve your funds!',
                          style: _const.raleway_535F5B(14, FontWeight.w700),

                        )
                      ]
                  )
              ),
            ),


            SizedBox(height: height * 0.05,),

            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: width * 0.05,),
              child: Text("Pick Time",  style: _const.raleway_535F5B(20, FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(height: height * 0.01,),

            SizedBox(height: height*0.01,),
            Container(
                width: width*0.6,
                margin: EdgeInsets.only(left: width * 0.05),
                child: Text(
                  DateFormat('yMMMMEEEEd').format(current_order!.picktime!.date!)+"\n"+
                      current_order!.picktime!.time.toString(),
                  style: _const.raleway_535F5B(15 , FontWeight.w500),)),





            SizedBox(height: height * 0.05,),

            SizedBox(height: height*0.02,),
            InkWell(
              onTap: ()async{
                SocialMediaDatabase _social_database=SocialMediaDatabase();
                MyUser ? buyer_detail=await  database.fetch_seller_mini_detail(DesiredUserID: current_order!.userid);
                _social_database
                    .getUserInfogetChats(
                    user2:
                    current_order!.userid,
                    product_id:current_order!.products![0].product_doc_id
                )
                    .then((value) {
                  print(
                      "so final chatroom id is " +
                          value.toString());

                  Navigator.of(context).pushNamed(
                      Chat_Screen.routename,
                      arguments:   ChatReciever(

                          chatid: value.toString(),
                          user:   MyUser(
                              uid:current_order!.userid,
                              username:buyer_detail!.username,
                              imageurl:buyer_detail.imageurl,
                              deviceid: buyer_detail.deviceid,
                              doc: buyer_detail.doc
                          ),
                          product:Product(id: current_order!.products![0].id, price:
                          current_order!.products![0].price
                              , title: current_order!.products![0].title, quantity: 1,
                              photos: current_order!.products![0].photos
                          )
                      )
                  );

                  //
                });
              },
              child: Container(
                height: height*0.055,
                width: width*1,
                margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

                padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                decoration: BoxDecoration(
                    color: blackbutton,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text("Message Seller",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
              ),
            ),



            SizedBox(height: height*0.02,),
            InkWell(
              onTap: (){
                SocialMediaDatabase _social_database=SocialMediaDatabase();
                _social_database
                    .getUserInfogetChats(
                    user2:
                    "admin",
                    product_id: current_order!.products![0].product_doc_id
                )
                    .then((value) {
                  print(
                      "so final chatroom id is " +
                          value.toString());

                  Navigator.of(context).pushNamed(
                      Chat_Screen.routename,
                      arguments:   ChatReciever(

                          chatid: value.toString(),
                          user:    MyUser(
                              uid:"admin",
                              username:"admin",
                              imageurl:"https://d2gg9evh47fn9z.cloudfront.net/1600px_COLOURBOX9896883.jpg"
                          ),
                          product:current_order!.products![0]
                      )
                  );

                  //
                });
              },
              child: Container(
                height: height*0.055,
                width: width*1,
                margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

                padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                decoration: BoxDecoration(
                    color: blackbutton,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text("Help",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
              ),
            ),

            SizedBox(height: height * 0.05,),

            Container(
                margin: EdgeInsets.only(left: width * 0.05),

                child: Text("Buyer Information",
                  style: _const.raleway_535F5B(20, FontWeight.w600),)),
            SizedBox(height: height * 0.02,),
           UserInformation(desired_userid: current_order!.userid),

            SizedBox(height: height * 0.1,),

          ],)
    );
  }
}
