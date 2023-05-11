// import 'package:dingzo/Database/SociaMediaDatabase.dart';
// import 'package:dingzo/Database/database.dart';
// import 'package:dingzo/constants.dart';
// import 'package:dingzo/model/chat_reciver.dart';
// import 'package:dingzo/model/myuser.dart';
// import 'package:dingzo/model/product.dart';
// import 'package:dingzo/screens/BuyerRating.dart';
// import 'package:dingzo/screens/chat/chat.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// class Rating extends StatefulWidget {
//
//   @override
//   State<Rating> createState() => _RatingState();
// }
//
// class _RatingState extends State<Rating> {
//   Constants _const=Constants();
//   double calAverage(List<double> ratings){
//     double aver=0;
//     double sum=0;
//
//     ratings.forEach((element) {
//       sum=sum+element;
//     });
//     aver=sum/ratings.length;
//     return aver;
//   }
// bool isloading=false;
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: StreamBuilder(
//
//           stream: FirebaseFirestore.instance.collection('Orders').snapshots(),
//           builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting)
//               return SpinKitCircle(
//                 color: Colors.black,
//               );
//             if (!snapshot.hasData) return const Text('Loading...');
//             List<QueryDocumentSnapshot> precist = snapshot.data!.docs
//                 .where((element) =>
//             (
//                 element['order_status'] == "shipped")
//
//             )
//                 .toList();
//             print("besharam"+precist.toString());
//             final int messageCount = precist.length;
//
//             return
//               precist.length>0?
//               ListView(
//                 children: List.generate(precist.length, (index) => Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//
//                     SizedBox(height: height * 0.02,),
//
//                     Container(
//                       margin: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Container(
//                             width: width * 0.3,
//                             height: height * 0.17,
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 image: DecorationImage(
//                                     image: NetworkImage(precist[index]['products'][0]['imageurl'][0])
//                                 )
//                             ),
//                           ),
//
//                           Expanded(
//
//                             child: Container(
//                               margin: EdgeInsets.only(
//                                   left: width * 0.025, right: width * 0.025),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(precist[index]['products'][0]['title'],
//                                           style: _const.raleway_SemiBold_darkbrown(
//                                               20, FontWeight.w600)),
//                                       Text("\$${precist[index]['products'][0]['price']}",
//                                           style: _const.raleway_SemiBold_darkbrown(
//                                               15, FontWeight.w600)),
//
//                                     ],
//                                   ),
//
//                                   SizedBox(height: height * 0.015,),
//                                   Text("Order ID: ${precist[index].id}",
//                                       style: _const.raleway_SemiBold_darkbrown(
//                                           15, FontWeight.w600)),
//                                   SizedBox(height: height * 0.015,),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Container(
//                                         height: height * 0.04,
//                                         width: width * 0.25,
//                                         padding: EdgeInsets.only(
//                                             left: width * 0.02, right: width * 0.02),
//                                         decoration: BoxDecoration(
//                                             color: Color(0xffEFB546),
//                                             borderRadius: BorderRadius.circular(10)
//                                         ),
//                                         child: Center(child: Text("View Order",
//                                           style: _const.raleway_SemiBold_white(
//                                               12, FontWeight.w600),)),
//                                       ),
//
//                                       Container(
//                                         height: height * 0.04,
//                                         width: width * 0.25,
//                                         padding: EdgeInsets.only(
//                                             left: width * 0.02, right: width * 0.02),
//                                         decoration: BoxDecoration(
//                                             color: Color(0xffEFB546),
//                                             borderRadius: BorderRadius.circular(10)
//                                         ),
//                                         child: Center(child: Text("View Reciept",
//                                           style: _const.raleway_SemiBold_white(
//                                               12, FontWeight.w600),)),
//                                       ),
//                                     ],
//                                   ),
//
//                                 ],
//                               ),
//                             ),
//                           ),
//
//
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: height * 0.01,),
//                     Divider(),
//                     SizedBox(height: height * 0.01,),
//                     Center(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Container(
//                               margin: EdgeInsets.only(left: width*0.05),
//
//                               child: Text("Rate Buyer",style: _const.raleway_SemiBold_9E772A(20 , FontWeight.w600),)),
//
//                           SizedBox(height: height*0.02,),
//
//                           Container(
//                               margin: EdgeInsets.only(left: width*0.05),
//
//                               child: Text("The buyer has recieved this package.Rate the buyer to complete the order and recieve your funds.",style: _const.raleway_SemiBold_9E772A(15 , FontWeight.w600),)),
//
//                         ],
//                       ),
//                     ),
//
//                     SizedBox(height: height * 0.035,),
//                     isloading?SpinKitRotatingCircle(
//                       color: Colors.black,
//                       size: 50.0,
//                     ):
//                     InkWell(
//                       onTap: () async {
// setState((){
//   isloading=true;
// });
//                         print("sanam"+precist[index].id);
//
//                         MyUser ? buyer=await database.fetchprofiledata(DesiredUserID: precist[index]['userid']);
//
//                         print(buyer!.uid);
//
//                          Navigator.of(context).pushNamed(BuyerRating.routename,
//                              arguments:buyer
//                          )
//                              .then((value) async {
//                            if(value==true){
//                              await database.updateProductStatus(productid:precist[index]['products'][0]['prodoct_id'] ,status: 'listed').then((value)async {
//                                await  database.updateOrder(orderid: precist[index].id,status: 'completed');
//
//                              });
//
//                            }
//                            print("value is "+value.toString());
//
//                          });
//
//                       },
//                       child: Container(
//                         height: height * 0.055,
//                         width: width * 1,
//                         margin: EdgeInsets.only(left: width * 0.1, right: width * 0.1),
//
//                         padding: EdgeInsets.only(left: width * 0.02, right: width * 0.02),
//                         decoration: BoxDecoration(
//                             color: Color(0xffEFB546),
//                             borderRadius: BorderRadius.circular(10)
//                         ),
//                         child: Center(child: Text("Rate Buyer",
//                           style: _const.raleway_SemiBold_white(16, FontWeight.w600),)),
//                       ),
//                     ),
//
//
//
//                     SizedBox(height: height * 0.02,),
//
//                     InkWell(
//                       onTap: () async {
//
//                         SocialMediaDatabase _social_database=SocialMediaDatabase();
//
//                        await  _social_database
//                             .getUserInfogetChats(
//                            user2:
//                            precist[index]['userid'].toString(),
//                        product_id: ''
//                        )
//                             .then((value) async {
//                           print(
//                               "so final chatroom id is " +
//                                   value.toString());
//                           MyUser ? sellerend= await database.fetch_seller_mini_detail(DesiredUserID:precist[index]['userid'].toString());
//                           Navigator.of(context).pushNamed(
//                             Chat_Screen.routename,
//                             arguments:  ChatReciever(
//                               jund: true,
//                                 chatid: value.toString(),
//                                 user:  sellerend,
//                                 product:Product(id: '', price: 23, title: 'dd', quantity: 2)
//                             )
//                           );
//
//                           //
//                         });
//                       },
//                       child: Container(
//                         height: height * 0.055,
//                         width: width * 1,
//                         margin: EdgeInsets.only(left: width * 0.1, right: width * 0.1),
//
//                         padding: EdgeInsets.only(left: width * 0.02, right: width * 0.02),
//                         decoration: BoxDecoration(
//                             color: Color(0xffEFB546),
//                             borderRadius: BorderRadius.circular(10)
//                         ),
//                         child: Center(child: Text("Message Buyer",
//                           style: _const.raleway_SemiBold_white(16, FontWeight.w600),)),
//                       ),
//                     ),
//                     SizedBox(height: height * 0.02,),
//                     Container(
//                       height: height * 0.055,
//                       width: width * 1,
//                       margin: EdgeInsets.only(left: width * 0.1, right: width * 0.1),
//
//                       padding: EdgeInsets.only(left: width * 0.02, right: width * 0.02),
//                       decoration: BoxDecoration(
//                           color: Color(0xffEFB546),
//                           borderRadius: BorderRadius.circular(10)
//                       ),
//                       child: Center(child: Text("View Tracking",
//                         style: _const.raleway_SemiBold_white(16, FontWeight.w600),)),
//                     ),
//
//
//
//                     SizedBox(height: height * 0.02,),
//                     Container(
//                       height: height * 0.055,
//                       width: width * 1,
//                       margin: EdgeInsets.only(left: width * 0.1, right: width * 0.1),
//
//                       padding: EdgeInsets.only(left: width * 0.02, right: width * 0.02),
//                       decoration: BoxDecoration(
//                           color: Color(0xffEFB546),
//                           borderRadius: BorderRadius.circular(10)
//                       ),
//                       child: Center(child: Text("Edit Tracking",
//                         style: _const.raleway_SemiBold_white(16, FontWeight.w600),)),
//                     ),
//                     SizedBox(height: height * 0.02,),
//
//                     Container(
//                         margin: EdgeInsets.only(left: width * 0.05),
//
//                         child: Text("Buyer Information",
//                           style: _const.raleway_SemiBold_9E772A(20, FontWeight.w600),)),
//                     SizedBox(height: height * 0.02,),
//                     FutureBuilder(
//                         future: database.fetchprofiledata(DesiredUserID: precist[index]['userid']),
//                         builder: (context,AsyncSnapshot<MyUser?> snapshot){
//                           return snapshot.hasData?
//                           Container(
//                             margin: EdgeInsets.only(left: width * 0.025,right: width * 0.025),
//                             width: width * 1,
//                             child: Row(
//                               children: [
//                                 CircleAvatar(
//                                   radius: 25,
//                                   backgroundImage: AssetImage("images/radiant.png"),
//                                 ),
//
//
//                                 Container(
//                                   width: width*0.7,
//                                   margin: EdgeInsets.only(left: width * 0.025),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         mainAxisAlignment: MainAxisAlignment.center,
//                                         children: [
//                                           Container(
//                                             child: Text(snapshot.data!.username.toString(),
//                                                 style: _const.raleway_SemiBold_9E772A(
//                                                     15, FontWeight.w600)),
//                                           ),
//
//                                           Row(
//                                             children: List.generate(
//                                                 calAverage(snapshot.data!.rating!).toInt(),
//                                                     (index) => Icon(
//                                                   Icons.star,
//                                                   color: Colors.yellow,
//                                                 )),
//                                           ),
//                                           Text(
//                                             calAverage(snapshot.data!.rating!).toStringAsFixed(1),
//                                             style: _const.poppin_orange(
//                                                 17, FontWeight.w600),
//                                           )
//                                         ],
//                                       ),
//
//                                       Container(
//                                         decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(10),
//                                             border: Border.all(color: const  Color(0xff8B6824))
//                                         ),
//                                         padding: EdgeInsets.only(left: width*0.025,right: width*0.025,bottom: height*0.01,top: height*0.01),
//                                         child:   Text("Follow",style: _const.raleway_regular_brown(15, FontWeight.w600)),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )
//                               :Text('');
//                         }),
//
//                     SizedBox(height: height * 0.1,),
//
//                   ],)),
//               ):const Text('No Item');
//           }),
//
//     );
//   }
// }
