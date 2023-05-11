import 'package:cloud_firestore/cloud_firestore.dart' as cloud;
import 'package:dingzo/Database/SociaMediaDatabase.dart';
import 'package:dingzo/model/chat_reciver.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/model/product.dart';
import 'package:dingzo/screens/chat/chat.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:dingzo/Database/database.dart';
import 'package:dingzo/Database/sellerdatabase.dart';
import 'package:dingzo/RequestTimeChange.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/model/order.dart';
import 'package:dingzo/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Seller_Rent_item_Pickup extends StatefulWidget {
  final String desired_order_docid;
  Seller_Rent_item_Pickup(this.desired_order_docid);

  @override
  State<Seller_Rent_item_Pickup> createState() => _Seller_Rent_item_PickupState();
}

class _Seller_Rent_item_PickupState extends State<Seller_Rent_item_Pickup> {
  Constants _const=Constants();
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
  Order ? desired_order;

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
                    element['order_status'] == "in_progress"
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

                SizedBox(height: height*0.025,),

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
                  margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
                  child: Text("The buyer will be arriving to pickup the item.\nPlease have the item ready to the give to buyer at the agreed on time.\nPlease be sure to demonstrate the working item to the buyer to avoid future problems. "
                    ,style: _const.raleway_535F5B(15, FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: height*0.02,),
                Container(
                  margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
                  child: Text("Make sure the buyer marks the item as recieved on the Zarkit App after you hand the item to the buyer. If the buyer doesn’t mark the item as recieved, you won’t recieve the money"
                    ,style: _const.raleway_535F5B(15, FontWeight.w800),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: height*0.05,),

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
                          width: width*0.6,
                          child: Text(
                            DateFormat('yMMMMEEEEd').format(desired_order!.picktime!.date!)+"\n"+
                                desired_order!.picktime!.time.toString(),
                            style: _const.raleway_535F5B(15 , FontWeight.w500),)),


                    ],
                  ),
                ),
                SizedBox(height: height*0.02,),




                SizedBox(height: height*0.02,),

                InkWell(
                  onTap: () async {

                    SocialMediaDatabase _social_database=SocialMediaDatabase();

                   MyUser ? seller_detail=await  database.fetch_seller_mini_detail(DesiredUserID: desired_order!.userid);

                    _social_database
                        .getUserInfogetChats(
                        user2:
                        desired_order!.userid!,
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
                            user:        MyUser(
                                uid:desired_order!.userid.toString(),
                                username:seller_detail!.username,
                                imageurl:seller_detail.imageurl,
                                doc: seller_detail.doc,
                                deviceid: seller_detail.deviceid
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
                    child: Center(child: Text("Message Buyer",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
                  ),
                ),


                SizedBox(height: height*0.02,),
                InkWell(
                  onTap: ()async{

                    await  socialMediaDatabase
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

                Container(
                    margin: EdgeInsets.only(left: width*0.05),

                    child: Text("Buyer Information",style: _const.raleway_535F5B(20 , FontWeight.w600),)),
                SizedBox(height: height*0.02,),
                Container(
                  margin: EdgeInsets.only(left: width * 0.025,right: width * 0.025),
                  width: width * 0.6,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage("images/radiant.png"),
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
                                  child: Text("Najeeb khan",
                                      style: _const.raleway_1A5A47(
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
                                  style: _const.poppin_orange(
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
                              child:   Text("Follow",style: _const.raleway_regular_brown(15, FontWeight.w600)),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),


                SizedBox(height: height*0.25,),

              ],
            );
        });

  }
}
