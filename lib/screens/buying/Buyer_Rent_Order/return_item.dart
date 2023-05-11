import 'package:dingzo/widgets/UserInformation.dart';
import 'dart:io';
import 'package:dingzo/Database/SociaMediaDatabase.dart';
import 'package:dingzo/Database/time_request.dart';
import 'package:dingzo/model/chat_reciver.dart';
import 'package:dingzo/screens/NegotiatePickupTimeChange.dart';
import 'package:dingzo/screens/chat/chat.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as cloud;
import 'package:dingzo/Database/database.dart';
import 'package:dingzo/RequestTimeChange.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/model/order.dart';
import 'package:dingzo/model/product.dart';
import 'package:dingzo/screens/cart.dart';
import 'package:dingzo/screens/editaddress.dart';
import 'package:dingzo/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart' as Path;

import 'package:http/http.dart' as http;
class Buyer_Rent_Return_Item extends StatefulWidget {
  final String desired_order_docid;
  Buyer_Rent_Return_Item(this.desired_order_docid);

  @override
  State<Buyer_Rent_Return_Item> createState() => _Buyer_Rent_Return_ItemState();
}

class _Buyer_Rent_Return_ItemState extends State<Buyer_Rent_Return_Item> {
  Constants _const=Constants();

  Order ? desired_order;
  final picker = ImagePicker();
  Future getfile({int? choice}) async {
    if (choice == 1) {
      final image =
      await ImagePicker.platform.getImage(source: ImageSource.camera);
      setState(() {

          image_file1 = File(image!.path);

      });
    } else {
      final image =
      await ImagePicker.platform.getImage(source: ImageSource.gallery);
      setState(() {
        image_file1 = File(image!.path);

      });
    }
  }
  cloud.CollectionReference? imgRef;
  firebase_storage.Reference? ref;
bool isloading=false;
  MyUser ? seller;
  Future uploadFile() async {


    try {
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('${"drop_off_item"}/${Path.basename(image_file1!.path)}');
      await ref!.putFile(image_file1!).whenComplete(() async {
        await ref!.getDownloadURL().then((value) async{
         await database.update_drop_off_item_image(img: value,orderid:  desired_order!.order_id,).then((value)async {

         await  database.updateOrder_rating_due_date(orderid: desired_order!.order_id!).then((value) async{
           await  database.updateOrder(orderid: desired_order!.order_id,status: 'rating').then((value) async{
             await socialMediaDatabase.sendPushMessage(title: 'You have new message', body:'Buyer has dropped off your item',
                 token: seller!.deviceid);
           });
         });
         });
        });
      });
    } catch (error) {

      setState(() {
        isloading = false;
      });
      _showErrorDialog(context, error.toString());
    }
  }
DateTime ? returndate;
  bool fetched=false;
  String? _showErrorDialog(BuildContext context, String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Alert'),
          content: Text(msg),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ));
  }

  void _show_my_Dialog() {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
            content: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    onTap: () {

                        getfile(choice: 1, ).then((value) {
                          Navigator.of(context).pop();
                        });

                    },
                    leading: Icon(
                      Icons.camera,
                      color: Colors.green,
                    ),
                    title: Text("Camera"),
                  ),
                  ListTile(
                    onTap: () {

                        getfile(choice: 2,).then((value) {
                          Navigator.of(context).pop();
                        });

                    },
                    leading: Icon(
                      Icons.image,
                      color: Colors.green,
                    ),
                    title: Text("Gallery"),
                  )
                ],
              ),
            )));
  }
  File? image_file1;
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
                    element['order_status'] == "return"
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
                        photos: photos,
                      sellerid: e['sellerid']
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
            int day=0;
            if(desired_order!.products![0].rent_duration=="Weeks"){
              day=7;
            }
            returndate=DateTime(
                desired_order!.picktime!.date!.year,
                desired_order!.picktime!.date!.month,
                ( desired_order!.picktime!.date!.day+day+2)
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
                              Text("Order ID: ${desired_order!.order_id!}",
                                  overflow: TextOverflow.fade,
                                  style: _const.raleway_263238(15, FontWeight.w600)),
                              SizedBox(height: height*0.015,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: height*0.04,
                                    width: width*0.25,
                                    padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                                    decoration: BoxDecoration(
                                        color: Color(0xffBCEFE0),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(child: Text("View Order",style:_const.raleway_535F5B(12, FontWeight.w600),)),
                                  ),

                                  Container(
                                    height: height*0.04,
                                    width: width*0.27,
                                    margin: EdgeInsets.only(left: width*0.01,),
                                    padding: EdgeInsets.only(left: width*0.025,right: width*0.02),
                                    decoration: BoxDecoration(
                                        color: Color(0xffBCEFE0),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(child: Text("View Reciept",style:_const.raleway_535F5B(11.3, FontWeight.w600),)),
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
                Container(
                  margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
                  child: Text("Please return the item"
                    ,style: _const.raleway_535F5B(15, FontWeight.w800),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: height*0.01,),
                Container(
                  margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
                  child:

                  Text.rich(
                      TextSpan(
                        style: _const.raleway_535F5B(15, FontWeight.w500),

                          text: 'We offer an additional 48 hours to return the item to the sellers address below however, if the item is not returned by  ',
                          children: <InlineSpan>[
                            TextSpan(
                              text: '${DateFormat('yMMMMEEEEd').format(returndate!)} at ${desired_order!.picktime!.time.toString()} ',
                              style: _const.raleway_535F5B(15, FontWeight.w700),

                            ),
                            TextSpan(
                              text: 'you may be subjected to additional charges',
                              style:_const.raleway_535F5B(15, FontWeight.w500),

                            )
                          ]
                      )
                  ),

                ),

                SizedBox(height: height*0.025,),
                Container(
                  margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
                  child: Text("Add Photo Of Dropped Off Item"
                    ,style: _const.raleway_535F5B(15, FontWeight.w800),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: height*0.02,),

                Center(
                  child:


                  InkWell(
                    onTap: (){
                      _show_my_Dialog();
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        left: width * 0.05,
                      ),
                      height: height * 0.15,
                      width: width * 0.28,
                      decoration: BoxDecoration(
                          color: Color(0xffE7E7E7),
                          borderRadius: BorderRadius.circular(15)),
                      child:
                      image_file1==null?
                      Center(
                        child: CircleAvatar(
                          radius: 23,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.add,
                              color: Color(0xffCCD2E3), size: 24),
                        ),
                      ):
                      Image.file(image_file1!,fit: BoxFit.values[2])
                      ,
                    ),
                  ),
                ),


                SizedBox(height: height*0.01,),
                Divider(),
                SizedBox(height: height*0.01,),
      isloading?
          SpinKitRing(color: mycolor)
          :
                InkWell(
                  onTap: ()async{
                    setState((){
                      isloading=true;
                    });
                       uploadFile();
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
                    child: Center(child: Text("I’ve Dropped Off The Item",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
                  ),
                ),


                SizedBox(height: height*0.05,),



                Container(
                  margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
                  child: Text("How to return"
                    ,style: _const.raleway_535F5B(15, FontWeight.w800),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: height*0.01,),
                Container(

                  margin: EdgeInsets.only(left: width*0.125,right: width*0.125),
                  child: Column(
                    children: [
                      Text("Please drop off the item at the sellers doorstep if the seller is not available.\nWe always reccomend that you hand the item to the seller and take a photo of the item on the sellers doorstep as proof of return."
                        ,style: _const.raleway_535F5B(15, FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),



                SizedBox(height: height*0.025,),


                SizedBox(height: height*0.01,),
                Divider(),
                SizedBox(height: height*0.01,),

                Container(
                  margin: EdgeInsets.only(left: width*0.05),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: width*0.4,
                        child:   Text("Return Time:",style: _const.raleway_535F5B(20 , FontWeight.w600),),

                      ),
                      SizedBox(height: height*0.01,),
                      Container(
                          width: width*0.4,
                          child: Text("January 4 2022 at 12:30am ",style: _const.raleway_535F5B(15 , FontWeight.w600),)),


                    ],
                  ),
                ),
                SizedBox(height: height*0.02,),

                SizedBox(height: height*0.01,),
                Divider(),
                SizedBox(height: height*0.01,),
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

                SizedBox(height: height*0.01,),
                Divider(),
                SizedBox(height: height*0.01,),
                InkWell(
                  onTap: ()async{
                    String ? chatid=await database.fetch_conversation_id_by_productid(desired_order!.products![0].product_doc_id!);

                    MyUser ? seller=await database.fetch_seller_mini_detail(DesiredUserID:desired_order!.sellerid!);

                    Navigator.of(context).pushNamed(NegotiatePickupTmeChange.routename,arguments: desired_order).then((value)async {
                      if(value!=null){
                        SchedulePickupTime pickuptime=value as SchedulePickupTime;
                        if(chatid!.isNotEmpty){
                          await  time_request_database.negotiatetime(context: context,
                              pickuptime: pickuptime, chatid: chatid, seller: seller, product: desired_order!.products![0]);

                        }
                        else{

                          chatid=await  socialMediaDatabase
                              .getUserInfogetChats(
                              user2:
                              desired_order!.products![0].sellerid,
                              product_id: desired_order!.products![0].product_doc_id
                          );
                          await  time_request_database.negotiatetime(context: context,
                              pickuptime: pickuptime, chatid: chatid, seller: seller, product: desired_order!.products![0]).then((value) async{
                            await socialMediaDatabase.sendPushMessage(title: 'You have new message', body:'Buyer has requested for time extension',
                                token: seller!.deviceid);
                          });

                        }

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
                    child: Center(child: Text("I Didn’t Recieve The Item",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
                  ),
                ),


                SizedBox(height: height*0.02,),
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
                SizedBox(height: height*0.01,),
                Divider(),
                SizedBox(height: height*0.01,),

                Container(
                    margin: EdgeInsets.only(left: width*0.05),

                    child: Text("Seller Information",style: _const.raleway_535F5B(20 , FontWeight.w600),)),
                SizedBox(height: height*0.02,),
               UserInformation(desired_userid: desired_order!.sellerid),

                SizedBox(height: height*0.15,),

              ],
            );
        });

  }
}
