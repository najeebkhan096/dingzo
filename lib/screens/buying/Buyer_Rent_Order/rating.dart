import 'package:cloud_firestore/cloud_firestore.dart' as cloud;
import 'package:dingzo/Database/SociaMediaDatabase.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:intl/intl.dart';
import 'package:dingzo/model/product.dart';

import 'package:dingzo/Database/database.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:dingzo/model/order.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class Buyer_Rent_Rating extends StatefulWidget {
  final String desired_order_docid;
  Buyer_Rent_Rating(this.desired_order_docid);
  @override
  State<Buyer_Rent_Rating> createState() => _Buyer_Rent_RatingState();
}

class _Buyer_Rent_RatingState extends State<Buyer_Rent_Rating> {
  Constants _const=Constants();

  Order ? desired_order;
  DateTime ? returndate;
  double rating =1;
  bool isloading=false;

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
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder(
            stream: cloud.FirebaseFirestore.instance.collection('Orders').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<cloud.QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return SpinKitCircle(
                  color: Colors.black,
                );
              if (!snapshot.hasData) return const Text('No Order');

              try{
                cloud.QueryDocumentSnapshot fetcheddata = snapshot.data!.docs
                    .firstWhere((element) => (
                    element.id==widget.desired_order_docid
                        &&  (
                        element['order_status'] == "rating"
                    )

                )

                );
                cloud.Timestamp stamp = fetcheddata['date'];
                List<Product> fetched_prod=[];
                List<dynamic>  myproducts = fetcheddata['products'];

                if(myproducts.length>0){
                  myproducts.forEach((e) {
                    List<dynamic> my=e['imageurl'];
                    List<String> photos=[];
                    my.forEach((element) {
                      photos.add(element.toString());
                    });
                    fetched_prod.add(
                        Product(
                            price: double.parse(e['price'].toString()),
                            quantity: e['quantity'],
                            title: e['title'].toString(),
                            rent_fare: double.parse(e['rent_fare'].toString()),
                            rent_duration: e['rent_duration'],
                            product_doc_id: e['prodoct_id'],
                            sellername: e['sellername'],
                            rent: e['rent'],
                            id: e['prodoct_id'],
                            indiviusal_totalprice: fetcheddata['total_price'],
                            photos: photos
                        ));
                  });
                }

                cloud.Timestamp pickupstamp = fetcheddata['pickup']['date'];

                cloud.Timestamp ?rating_due_date_stamp;
                try{
                  rating_due_date_stamp=fetcheddata['rating_due_date'];
                } catch(error){

                }


                DateTime date = stamp.toDate();
                DateTime pickupdate = pickupstamp.toDate();
                desired_order= Order(
                    buyer_rate: fetcheddata['buyer_rate'],
                    seller_rate: fetcheddata['seller_rate'],
                    drop_of_item_image: fetcheddata['drop_of_item_image'],
                    order_id: widget.desired_order_docid,
                    picktime: SchedulePickupTime(date: pickupdate, time: fetcheddata['pickup']['time'],comment: fetcheddata['pickup']['comment'].toString()),
                    sellerid: fetcheddata['sellerid'],
                    location: fetcheddata['location'].toString(),
                    customer_name: fetcheddata['customer_name'].toString(),
                    notes: fetcheddata['notes'].toString(),
                    total_price: double.parse(fetcheddata['total_price'].toString()),
                    userid: fetcheddata['userid'],
                    order_status: fetcheddata['order_status'].toString(),
                    customer_latitude: fetcheddata['customer_latitude'],
                    customer_longitude: fetcheddata['customer_longitude'],
                    date:
                    date,
                    products: fetched_prod,
                  rating_due_date: rating_due_date_stamp!.toDate()
                );
              }catch(error){
                desired_order=null;
                print("No order");
              }




              return
                desired_order==null?

                Column(
                  children: [
                    Container(
                        height: height*0.65,
                        width: width*1,

                        child: Center(child: Text("No Data",style: _const.manrope_regular78909C(15, FontWeight.w700),))),
                  ],
                ):
                desired_order!.buyer_rate!?
                Column(
                  children: [
                    Container(
                        height: height*0.65,
                        width: width*1,

                        child: Center(child: Text("You have Rated Seller",style: _const.manrope_regular78909C(15, FontWeight.w700),))),
                  ],
                )


                    :
                Container(
                  height: height*0.8,
                  child: ListView(
                    children: [

                      SizedBox(height: height*0.025,),



                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: width*0.4,

                              child: Text("How would you rate the seller?",style: _const.raleway_535F5B(20, FontWeight.w600),textAlign: TextAlign.center,)),
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

                        child: Text("All sales are final after you rate.\nYou must rate in order for the transaction to be completed.\nTransactions will we auto rated in 3 days on ${DateFormat('yMMMMEEEEd').format(desired_order!.rating_due_date!)}\nIf there are any issues with the order, click Help!",style: _const.raleway_535F5B(13, FontWeight.w600),
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
                          MyUser ? seller=await database.fetch_seller_mini_detail(DesiredUserID:desired_order!.sellerid!);

                          List<double> ratings=await database.fetchrating(DesiredUserID: desired_order!.sellerid!);
                          ratings.add(rating);

                          await database.fetch_docid(DesiredUserID:desired_order!.sellerid!).then((mydoc) async{
                            await database.update_rating(mydoc.toString(), ratings, context).then((value) async{

                              if( desired_order!.seller_rate!){
                                await     database.updateProductStatus(productid: desired_order!.products![0].product_doc_id,status: 'completed').then((value)async {

                                  await  releasefund(desired_order!.payment_id!).then((value)async {
                                    await     database.updateOrder(orderid:desired_order!.order_id,status: 'completed'
                                        ,
                                        buyer_rate: true
                                    ).then((value) async{
                                      await socialMediaDatabase.sendPushMessage(title: 'You have new message', body:'Buyer has rated your order',
                                          token: seller!.deviceid);
                                      setState((){
                                        isloading=false;
                                      });

                                    });
                                  });

                                });

                              }
                              else{
                                await     database.updateOrder(orderid:desired_order!.order_id,status: 'rating'
                                    ,
                                    buyer_rate: true
                                ).then((value) async{
                                  await socialMediaDatabase.sendPushMessage(title: 'You have new message', body:'Buyer has rated your order',
                                      token: seller!.deviceid);
                                  setState((){
                                    isloading=false;
                                  });

                                });
                              }


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
                          child: Center(child: Text("Rate Seller",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
                        ),
                      ),
                      SizedBox(height: height*0.1,),

                    ],
                  ),
                );
            })



    );
  }
}
