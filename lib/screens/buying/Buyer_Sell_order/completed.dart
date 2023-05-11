import 'package:dingzo/Database/product_database.dart';
import 'package:dingzo/hometesting.dart';
import 'package:dingzo/screens/SellItem.dart';
import 'package:dingzo/screens/home.dart';
import 'package:dingzo/widgets/UserInformation.dart';
import 'package:dingzo/Database/SociaMediaDatabase.dart';
import 'package:dingzo/Database/database.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/model/chat_reciver.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/model/order.dart';
import 'package:dingzo/model/product.dart';
import 'package:dingzo/screens/BuyerRating.dart';
import 'package:dingzo/screens/chat/chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as cloud;
class Buyer_Sell_Complete extends StatefulWidget {
  final Order ? desired_order;
  Buyer_Sell_Complete({this.desired_order});
  @override
  State<Buyer_Sell_Complete> createState() => _Buyer_Sell_CompleteState();
}

class _Buyer_Sell_CompleteState extends State<Buyer_Sell_Complete> {
  Constants _const=Constants();

  double calAverage(List<double> ratings){
    double aver=0;
    double sum=0;

    ratings.forEach((element) {
      sum=sum+element;
    });
    aver=sum/ratings.length;
    return aver;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,

      body:
      ListView(

        children: [

          SizedBox(height: height * 0.02,),

          Container(
            margin: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: width*0.35,
                  height: height*0.16,
                  child: Stack(
                    children: [
                      Container(
                        width: width*0.35,
                        height: height*0.16,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(widget.desired_order!.products![0].photos![0].toString())
                                ,fit: BoxFit.cover
                            )
                        ),
                      ),

                      Positioned(
                        left: width*0,
                        top: height*0.0,
                        child: Container(
                          height: height*0.05,
                          width: width*0.15,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromRGBO(32, 201, 151, 0.62)
                          ),

                          child: Center(
                            child: Text("Sold",
                              style: _const.manrope_regularwhite(12, FontWeight.w600),
                            ),
                          ),
                        ),
                      )

                    ],
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
                            Text(widget.desired_order!.products![0].title.toString(),
                                style: _const.raleway_535F5B(
                                    20, FontWeight.w600)),
                            Text("\$${widget.desired_order!.products![0].price.toString()
                            }",
                                style: _const.raleway_535F5B(
                                    15, FontWeight.w600)),

                          ],
                        ),

                        SizedBox(height: height * 0.015,),
                        Text("Order ID: ${widget.desired_order!.order_id.toString()}",
                            style: _const.raleway_535F5B(
                                15, FontWeight.w600)),
                        SizedBox(height: height * 0.015,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: height * 0.04,
                              width: width * 0.24,
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

                            Container(
                              height: height * 0.04,
                              width: width * 0.24,
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

                    child: Text("Congratulations! ",style: _const.raleway_535F5B(20 , FontWeight.w600),)),
              ),

              SizedBox(height: height*0.02,),

              Center(
                child: Container(
                    margin: EdgeInsets.only(left: width*0.05),
                    width: width*0.6,
                    child: Text("Your order has been complete.Continue shopping here.",style: _const.raleway_535F5B(15 , FontWeight.w600),textAlign: TextAlign.center,)),
              ),

            ],
          ),
          SizedBox(height: height*0.05,),

          InkWell(
            onTap: (){
              Navigator.of(context).pushNamedAndRemoveUntil(HomeTesting.routename, (route) => false);
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
              child: Center(child: Text("Continue Shopping",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
            ),
          ),
          SizedBox(height: height*0.02,),
          Divider(),

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
              height: height * 0.055,
              width: width * 1,
              margin: EdgeInsets.only(left: width * 0.1, right: width * 0.1),

              padding: EdgeInsets.only(left: width * 0.02, right: width * 0.02),
              decoration: BoxDecoration(
                  color: blackbutton,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(child: Text("Message Buyer",
                style: _const.raleway_SemiBold_white(16, FontWeight.w600),)),
            ),
          ),


          SizedBox(height: height*0.02,),

          InkWell(
            onTap: ()async{
            Navigator.of(context).pushNamed(SellItem.routename);
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
              child: Center(child: Text("Sell one like this",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
            ),
          ),


          SizedBox(height: height*0.025,),
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
              child: Center(child: Text("Help",style:_const.raleway_SemiBold_white(14, FontWeight.w600),)),
            ),
          ),
          SizedBox(height: height*0.05,),
          Container(
              margin: EdgeInsets.only(left: width*0.05),

              child: Text("Seller Information",style: _const.raleway_535F5B(20 , FontWeight.w600),)),

          SizedBox(height: height*0.02,),

        UserInformation(desired_userid: widget.desired_order!.sellerid),



          SizedBox(height: height*0.1,),
        ],)
    );
  }
}
