import 'dart:io';
import 'package:dingzo/Database/SociaMediaDatabase.dart';
import 'package:dingzo/model/chat_reciver.dart';
import 'package:dingzo/screens/chat/chat.dart';
import 'package:dingzo/widgets/UserInformation.dart';
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
class Seller_Rent_item_in_Return extends StatefulWidget {
  final String desired_order_docid;
  Seller_Rent_item_in_Return(this.desired_order_docid);

  @override
  State<Seller_Rent_item_in_Return> createState() => _Seller_Rent_item_in_ReturnState();
}

class _Seller_Rent_item_in_ReturnState extends State<Seller_Rent_item_in_Return> {
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

  Future uploadFile() async {


    try {
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('${"drop_off_item"}/${Path.basename(image_file1!.path)}');
      await ref!.putFile(image_file1!).whenComplete(() async {
        await ref!.getDownloadURL().then((value) async{
          await database.update_drop_off_item_image(img: value,orderid:  desired_order!.order_id,).then((value)async {
            await  database.updateOrder(orderid: desired_order!.order_id,status: 'rating');
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
  void _showModalSheet() {
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
                                      _showModalSheet();
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
                                      _showModalSheet();
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
                Container(
                  margin: EdgeInsets.only(left: width*0.1,right: width*0.1),
                  child: Text("The Buyer Will Return The Item Soon!\n",style: _const.raleway_535F5B(20, FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(left: width*0.1,right: width*0.1),
                  child: Text.rich(

                      TextSpan(

                          style: _const.raleway_535F5B(15, FontWeight.w500),
                          text: 'The buyer will return the item by\n',
                          children: <InlineSpan>[
                            TextSpan(
                              style: _const.raleway_535F5B(15, FontWeight.w700),
                              text: '${ DateFormat('yMMMMEEEEd').format(returndate!)} at ${desired_order!.picktime!.time.toString()}',

                            ),

                          ]
                      )
                  ),
                ),

                SizedBox(height: height*0.025,),




                SizedBox(height: height*0.01,),
                Divider(),
                SizedBox(height: height*0.01,),


                InkWell(
                  onTap: (){

                    socialMediaDatabase
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
                          arguments: ChatReciever(

                              chatid: value.toString(),
                              user:       MyUser(
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
                    child: Center(child: Text("Buyer Did not return item",style:_const.raleway_SemiBold_white(14, FontWeight.w600),)),
                  ),
                ),


                SizedBox(height: height*0.02,),
                InkWell(
                  onTap: ()async{

                    MyUser ? seller_detail=await  database.fetch_seller_mini_detail(DesiredUserID: desired_order!.userid);
                    socialMediaDatabase
                        .getUserInfogetChats(
                        user2:
                        desired_order!.userid,
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
                                  uid:desired_order!.userid.toString(),
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
                          arguments: ChatReciever(

                              chatid: value.toString(),
                              user:       MyUser(
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
                    child: Center(child: Text("Help",style:_const.raleway_SemiBold_white(14, FontWeight.w600),)),
                  ),
                ),





                SizedBox(height: height*0.02,),
                SizedBox(height: height*0.01,),
                Divider(),
                SizedBox(height: height*0.01,),

                Container(
                    margin: EdgeInsets.only(left: width*0.05),

                    child: Text("Buyer Information",style: _const.raleway_535F5B(20 , FontWeight.w600),)),
                SizedBox(height: height*0.02,),
              UserInformation(desired_userid: desired_order!.userid),

                SizedBox(height: height*0.15,),

              ],
            );
        });

  }
}
