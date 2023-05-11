import 'package:dingzo/Database/database.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/screens/home.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:dingzo/Database/SociaMediaDatabase.dart';
import 'package:dingzo/Database/database.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/model/order.dart';
import 'package:dingzo/screens/BuyerRating.dart';
import 'package:dingzo/screens/chat/chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as cloud;
import 'package:http/http.dart' as http;

class Seller_Sell_item_Rating extends StatefulWidget {
  final Order ? current_order;
  Seller_Sell_item_Rating({this.current_order});
  @override
  State<Seller_Sell_item_Rating> createState() => _Seller_Sell_item_RatingState();
}

class _Seller_Sell_item_RatingState extends State<Seller_Sell_item_Rating> {
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

  double rating =1;
  bool isloading=false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: height*0.8,
        child:

        widget.current_order!.seller_rate!?
        Column(
          children: [
            Container(
                height: height*0.65,
                width: width*1,

                child: Center(child: Text("You have Rated Buyer",style: _const.manrope_regular78909C(15, FontWeight.w700),))),
          ],
        )
:
        ListView(
          children: [

            SizedBox(height: height*0.025,),



            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: width*0.4,

                    child: Text("How would you rate the buyer?",style: _const.raleway_535F5B(20, FontWeight.w600),textAlign: TextAlign.center,)),
              ],
            ),


            SizedBox(height: height*0.025,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: width*0.3,
                  height: height*0.12,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("images/radiant.png")
                      )
                  ),
                ),
              ],
            ),

            SizedBox(height: height*0.025,),

            Center(
              child: RatingBar.builder(
                initialRating: 3,
                itemSize: 50,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: mycolor,
                ),
                onRatingUpdate: (rate) {
                  print(rate);
                  rating=rate;
                },
              ),
            ),



            SizedBox(height: height*0.05,),
            Container(
              margin: EdgeInsets.only(left: width*0.1,right: width*0.1),
              padding:  EdgeInsets.only(left: width*0.025,right: width*0.1),
              height: height*0.2,
              decoration: BoxDecoration(
                  color: Color(0xffF4F4F4),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: TextFormField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Option",
                    hintStyle: _const.raleway_rgb_textfield(16, FontWeight.w600)
                ),
              ),
            ),



            SizedBox(height: height*0.05,),
            Container(
              margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

              child: Text("All sales are final after you rate.\nYou must rate in order for the transaction to be completed.\n\nIf there are any issues with the order, click Help!",style: _const.raleway_535F5B(13, FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(height: height*0.05,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: height*0.055,
                  width: width*0.3,
                  decoration: BoxDecoration(
                      color: blackbutton,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(child: Text("Help",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
                ),
              ],
            ),


            SizedBox(height: height*0.05,),

            isloading?
            SpinKitRing(color: mycolor)
                :
            InkWell(
              onTap: ()async{

                setState((){
                  isloading=true;
                });

                List<double> ratings=await database.fetchrating(DesiredUserID: widget.current_order!.userid!);
                ratings.add(rating);

           await  releasefund(widget.current_order!.payment_id!).then((value) async{
             await database.fetch_seller_mini_detail (DesiredUserID:widget.current_order!.userid!).then((sellerend) async{

               await database.update_rating(sellerend!.doc.toString(), ratings, context).then((value) async {

                 if( widget.current_order!.buyer_rate!){
                   await     database.updateProductStatus(productid: widget.current_order!.products![0].product_doc_id,status: 'completed').then((value)async {

                     await     database.updateOrder(orderid:widget.current_order!.order_id,status: 'completed'
                         ,
                         sellerrate: true
                     ).then((value) async{

                       SocialMediaDatabase _socila_database=SocialMediaDatabase();
                       await _socila_database.sendPushMessage(title: 'You have new message', body:'Seller rated your order',
                           token: sellerend.deviceid);


                       setState((){
                         widget.current_order!.seller_rate=true;
                         isloading=true;
                       });
                       Navigator.of(context).pop();
                     });
                   });

                 }
                 else{
                   await     database.updateOrder(orderid:widget.current_order!.order_id,status: 'rating',
                       sellerrate: true
                   ).then((value) async{
                     await socialMediaDatabase.sendPushMessage(title: 'You have new message', body:'Seller rated your order',
                         token: sellerend.deviceid);

                     setState((){
                       widget.current_order!.seller_rate=true;
                       isloading=false;
                     });

                   });
                 }

               });
             });

           });



              },
              child: Container(
                height: height*0.055,
                width: width*1,
                margin: EdgeInsets.only(left: width*0.1,right: width*0.1),
                decoration: BoxDecoration(
                    color:blackbutton,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text("Rate Buyer",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
              ),
            ),
            SizedBox(height: height*0.1,),

          ],
        ),
      ),

    );
  }
}
