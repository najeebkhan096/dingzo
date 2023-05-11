import 'package:dingzo/widgets/UserInformation.dart';
import 'package:dingzo/Database/product_database.dart';
import 'package:dingzo/hometesting.dart';
import 'package:dingzo/model/chat_reciver.dart';
import 'package:dingzo/screens/SellItem.dart';
import 'package:dingzo/screens/home.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as cloud;
import 'package:dingzo/Database/SociaMediaDatabase.dart';
import 'package:dingzo/RequestTimeChange.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/model/product.dart';
import 'package:dingzo/screens/chat/chat.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:dingzo/Database/database.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/model/order.dart';
import 'package:dingzo/screens/buying/Buyer_Rent_Order/completed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Seller_Rent_item_Completed extends StatefulWidget {
  final String?  desired_order_docid;

  Seller_Rent_item_Completed(this.desired_order_docid);

  @override
  State<Seller_Rent_item_Completed> createState() => _Seller_Rent_item_CompletedState();
}

class _Seller_Rent_item_CompletedState extends State<Seller_Rent_item_Completed> {
  Constants _const=Constants();

  void _showModalSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          final height = MediaQuery.of(context).size.height;
          final width = MediaQuery.of(context).size.width;
          return new Container(
            height: height*0.44,
            color: Color(0xffBCEFE0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height*0.025,),
                Center(child: Text("Reciept",style: _const.raleway_1A5A47(25, FontWeight.w800),))
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
                          Text("SubTotal",style: _const.raleway_1A5A47(15, FontWeight.w600),),
                          Text("\$${desired_order!.total_price.toString()}",style: _const.raleway_1A5A47(15, FontWeight.w600),),


                        ],
                      ),
                      SizedBox(height: height*0.02,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Shipping",style: _const.raleway_1A5A47(15, FontWeight.w600),)
                          ,Text("Free",style: _const.raleway_1A5A47(15, FontWeight.w600),),


                        ],
                      ),

                      SizedBox(height: height*0.02,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Tax",style: _const.raleway_1A5A47(15, FontWeight.w600),)
                          ,Text("\$4.0",style: _const.raleway_1A5A47(15, FontWeight.w600),),


                        ],
                      ),
                      SizedBox(height: height*0.02,),


                    ],
                  ),
                ),
                SizedBox(height: height*0.1,),
                InkWell(
                  onTap: (){

                    Navigator.of(context).pop();
                  },
                  child: Center(child: Text("Done",style:_const.raleway_050509(12, FontWeight.w800),)),
                ),
              ],

            ),
          );
        }
    );
  }

  Order ? desired_order;

  MyUser ? seller;

  bool fetched=false;

  bool isloading=false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return StreamBuilder(
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
                    element['order_status'] == "completed"
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
            DateTime date = stamp.toDate();
            DateTime pickupdate = pickupstamp.toDate();
            desired_order= Order(
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
                products: fetched_prod
            );
          }catch(error){
            desired_order=null;
            print("No order");
          }


          if(desired_order!=null && fetched==false)
            database.fetch_mini_user(DesiredUserID:desired_order!.sellerid ).then((value) {

              setState(() {
                seller=value;
                fetched=true;
              });
            });



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
            ListView(
              children: [

                SizedBox(height: height*0.02,),

                //product detail
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
                                image: NetworkImage(desired_order!.products![0].photos![0])
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
                                  Text(desired_order!.products![0].title!,style: _const.raleway_263238(20, FontWeight.w600)),
                                  Text("\$${desired_order!.products![0].price!}",style: _const.raleway_263238(15, FontWeight.w600)),

                                ],
                              ),

                              SizedBox(height: height*0.015,),
                              Row(
                                children: [
                                  Expanded(

                                      child  : SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Text("Order ID: ${desired_order!.order_id!}",style: _const.raleway_263238(15, FontWeight.w600)))),
                                ],
                              ),
                              SizedBox(height: height*0.015,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  InkWell(
                                    onTap: (){
                                      _showModalSheet(context);
                                    },
                                    child: Container(
                                      height: height*0.04,
                                      width: width*0.25,
                                      padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                                      decoration: BoxDecoration(
                                          color: Color(0xffBCEFE0),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Center(child: Text("View Order",style:_const.raleway_535F5B(10, FontWeight.w600),)),
                                    ),
                                  ),

                                  InkWell(
                                    onTap: (){
                                      _showModalSheet(context);
                                    },
                                    child: Container(
                                      height: height*0.04,
                                      width: width*0.25,
                                      padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                                      decoration: BoxDecoration(
                                          color: Color(0xffBCEFE0),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Center(child: Text("View Reciept",style:_const.raleway_535F5B(10, FontWeight.w600),)),
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
                          width: width*0.45,
                          child: Text("Your order has been completed. Continue shopping here.",style: _const.raleway_535F5B(15 , FontWeight.w600),textAlign: TextAlign.center,)),
                    ),

                  ],
                ),
                SizedBox(height: height*0.05,),
                InkWell(
                  onTap: ()async{
                    await productdatabase.uploadProduct(product:desired_order!.products![0]).then((value) {

                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Product is relisted",style: TextStyle(color: Colors.white)),
                            backgroundColor: Colors.black,)
                      );
                    });
                  },
                  child: Container(
                    height: height*0.055,
                    width: width*1,
                    margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

                    padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                    decoration: BoxDecoration(
                        color: Color(0xff1B654F),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(child: Text("Sell Another Item",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
                  ),
                ),
                SizedBox(height: height*0.025,),
                Divider(),

                Container(
                  margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

                  child: Text("Buyer Address",
                  style: _const.raleway_535F5B(20, FontWeight.w600),
                  ),
                ),
                SizedBox(height: height*0.025,),
                if(seller!=null)

                  Container(
                      margin: EdgeInsets.only(left: width*0.1,right: width*0.1),
                      width: width*0.4,
                      child: Text(seller!.location_details!.address_txt.toString(),style: _const.raleway_535F5B(15 , FontWeight.w600),)),

                SizedBox(height: height*0.05,),
                InkWell(
                  onTap: ()async{
                    SocialMediaDatabase _social_database=SocialMediaDatabase();
                    MyUser ? seller_detail=await  database.fetch_seller_mini_detail(DesiredUserID: desired_order!.sellerid);
                    _social_database
                        .getUserInfogetChats(
                        user2:
                        desired_order!.sellerid!,
                        product_id: desired_order!.products![0].product_doc_id
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
                                  uid:desired_order!.sellerid.toString(),
                                  username:seller_detail!.username,
                                  imageurl:seller_detail.imageurl,
                                  deviceid: seller_detail.deviceid,
                                  doc: seller_detail.doc
                              ),
                              product:Product(id: desired_order!.products![0].id, price:
                              desired_order!.products![0].price
                                  , title: desired_order!.products![0].title, quantity: 1,
                                  photos: desired_order!.products![0].photos
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
                InkWell(
                  onTap: (){
                    SocialMediaDatabase _social_database=SocialMediaDatabase();
                    _social_database
                        .getUserInfogetChats(
                        user2:
                        "admin",
                        product_id: desired_order!.products![0].product_doc_id
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
                              product:desired_order!.products![0]
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
                    child: Center(child: Text("Help",style:_const.raleway_SemiBold_white(13, FontWeight.w600),)),
                  ),
                ),
                SizedBox(height: height*0.02,),

                Container(
                    margin: EdgeInsets.only(left: width*0.05),

                    child: Text("Buyer Information",style: _const.raleway_535F5B(20 , FontWeight.w600),)),
                SizedBox(height: height*0.02,),
              UserInformation(desired_userid: desired_order!.userid),


                SizedBox(height: height*0.25,),


              ],
            );
        });

  }
}
