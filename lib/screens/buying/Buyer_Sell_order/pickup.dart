import 'package:dingzo/Database/time_request.dart';
import 'package:dingzo/screens/NegotiatePickupTimeChange.dart';
import 'package:intl/intl.dart';
import 'package:dingzo/model/chat_reciver.dart';
import 'package:dingzo/model/product.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as cloud;
import 'package:dingzo/Database/SociaMediaDatabase.dart';
import 'package:dingzo/Database/database.dart';
import 'package:dingzo/RequestTimeChange.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/model/order.dart';
import 'package:dingzo/screens/chat/chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Buyer_Sell_Pickup extends StatefulWidget {
  final Order ? desired_order;
  Buyer_Sell_Pickup({this.desired_order});

  @override
  State<Buyer_Sell_Pickup> createState() => _Buyer_Sell_PickupState();
}

class _Buyer_Sell_PickupState extends State<Buyer_Sell_Pickup> {
  Constants _const=Constants();




  MyUser ? seller;
  bool fetched=false;
  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    if(widget.desired_order!=null && fetched==false)
   await    database.fetch_mini_user(DesiredUserID:widget.desired_order!.sellerid ).then((value) {

        setState(() {
          seller=value;
          fetched=true;
        });
      });


    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return    ListView(
      children: [

        SizedBox(height: height*0.02,),

        Container(
          margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
          child:   Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: width*0.3,
                height: height*0.145,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        fit: BoxFit.values[2],
                        image: NetworkImage(widget.desired_order!.products![0].photos![0])
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
                          Text(widget.desired_order!.products![0].title!,style: _const.raleway_263238(20, FontWeight.w600)),
                          Text("\$${widget.desired_order!.products![0].price!}",style: _const.raleway_263238(15, FontWeight.w600)),

                        ],
                      ),

                      SizedBox(height: height*0.015,),
                      Text("Order ID: ${widget.desired_order!.order_id!}",style: _const.raleway_263238(15, FontWeight.w600)),
                      SizedBox(height: height*0.015,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: height*0.04,
                            width: width*0.25,
                            padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                            decoration: BoxDecoration(
                                color: mycolor,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(child: Text("View Order",style:_const.raleway_SemiBold_white(12, FontWeight.w600),)),
                          ),

                          Container(
                            height: height*0.04,
                            width: width*0.28,
                            padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                            decoration: BoxDecoration(
                                color: mycolor,
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
        SizedBox(height: height*0.025,),
        Center(child: Text("Thank You For Purchasing!",style: _const.raleway_535F5B(20 , FontWeight.w600),)),

        SizedBox(height: height*0.05,),
        Container(
          margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
          child:   Text("Please pick up the order at the time the negotiated at the sellers address.",style: _const.raleway_535F5B(15 , FontWeight.w600),),

        ),


        SizedBox(height: height*0.02,),

        Container(
          margin: EdgeInsets.only(left: width*0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: width*0.4,
                child:   Text("Pickup Time:",style: _const.raleway_535F5B(20 , FontWeight.w600),),

              ),
              SizedBox(height: height*0.01,),
              Container(
                  width: width*0.4,
                  child: Text("${DateFormat('yMMMMEEEEd').format(widget.desired_order!.picktime!.date!)} at ${widget.desired_order!.picktime!.time} ",style: _const.raleway_535F5B(15 , FontWeight.w600),)),


            ],
          ),
        ),
        SizedBox(height: height*0.02,),

        Container(
          margin: EdgeInsets.only(left: width*0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child:   Text("Seller Address:",style: _const.raleway_535F5B(20 , FontWeight.w600),),

              ),
              SizedBox(height: height*0.01,),

              if(seller!=null)

                Container(
                    width: width*0.4,
                    child: Text(seller!.location_details!.address_txt.toString(),style: _const.raleway_535F5B(15 , FontWeight.w600),)),


            ],
          ),
        ),

        SizedBox(height: height*0.035,),

        InkWell(
          onTap: ()async{
    await database.fetch_seller_mini_detail (DesiredUserID:widget.desired_order!.sellerid!).then((sellerend) async{
      await  database.updateOrder(status: 'rating',orderid: widget.desired_order!.order_id!).then((value) async{
        await  database.updateOrder_rating_due_date(orderid: widget.desired_order!.order_id!).then((value) async{
          await socialMediaDatabase.sendPushMessage(title: 'You have new message', body:'Buyer has Picked up the item',
              token: sellerend!.deviceid);

          Navigator.of(context).pop();
        });
      });

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
            child: Center(child: Text("I've picked up the item",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
          ),
        ),
        SizedBox(height: height*0.02,),
        InkWell(
          onTap: ()async{
            String ? chatid=await database.fetch_conversation_id_by_productid(widget.desired_order!.products![0].product_doc_id!);
            MyUser ? seller=await database.fetch_seller_mini_detail(DesiredUserID:widget.desired_order!.sellerid!);

            Navigator.of(context).pushNamed(NegotiatePickupTmeChange.routename,arguments: widget.desired_order).then((value)async {
              if(value!=null){
                SchedulePickupTime pickuptime=value as SchedulePickupTime;
               await  time_request_database.negotiatetime(context: context,
                    pickuptime: pickuptime, chatid: chatid, seller: seller, product: widget.desired_order!.products![0]).then((value) async{
                 await socialMediaDatabase.sendPushMessage(title: 'You have new message', body:'Buyer has requested for time extension',
                     token: seller!.deviceid);
               });




              }
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
            child: Center(child: Text("Request Time Change",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
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
                product_id: widget.desired_order!.products![0].product_doc_id
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
                      product:widget.desired_order!.products![0]
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
            child: Center(child: Text("I Didn’t Recieve The Item",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
          ),
        ),


        SizedBox(height: height*0.02,),
        InkWell(
          onTap: ()async{
            SocialMediaDatabase _social_database=SocialMediaDatabase();
            MyUser ? seller_detail=await  database.fetch_seller_mini_detail(DesiredUserID: widget.desired_order!.sellerid);
            _social_database
                .getUserInfogetChats(
                user2:
                widget.desired_order!.sellerid!,
                product_id: widget.desired_order!.products![0].product_doc_id
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
                          uid:widget.desired_order!.sellerid.toString(),
                          username:seller_detail!.username,
                          imageurl:seller_detail.imageurl,
                          deviceid: seller_detail.deviceid,
                          doc: seller_detail.doc
                      ),
                      product:Product(id: widget.desired_order!.products![0].id, price:
                      widget.desired_order!.products![0].price
                          , title: widget.desired_order!.products![0].title, quantity: 1,
                          photos: widget.desired_order!.products![0].photos
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
                product_id: widget.desired_order!.products![0].product_doc_id
            )
                .then((value) {
              print(
                  "so final chatroom id is " +
                      value.toString());

              Navigator.of(context).pushNamed(
                  Chat_Screen.routename,
                  arguments: ChatReciever(

                      chatid: value.toString(),
                      user:       MyUser(
                          uid:"admin",
                          username:"admin",
                          imageurl:"https://d2gg9evh47fn9z.cloudfront.net/1600px_COLOURBOX9896883.jpg"
                      ),
                      product:widget.desired_order!.products![0]
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
            child: Center(child: Text("I Need Other Help With The Order",style:_const.raleway_SemiBold_white(14, FontWeight.w600),)),
          ),
        ),





        SizedBox(height: height*0.05,),

        Container(
            margin: EdgeInsets.only(left: width*0.05),

            child: Text("Seller Information",style: _const.raleway_535F5B(20 , FontWeight.w600),)),
        SizedBox(height: height*0.02,),

        if(seller!=null)
          Container(
            margin: EdgeInsets.only(left: width * 0.025,right: width * 0.025),
            width: width * 0.6,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(seller!.imageurl.toString()),
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
                            child: Text(seller!.username!,
                                style: _const.raleway_535F5B(
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
                            style: _const.raleway_535F5B(
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
                        child:   Text("Follow",style: _const.raleway_535F5B(15, FontWeight.w600)),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),

        SizedBox(height: height*0.1,),

      ],
    );
  }
}
