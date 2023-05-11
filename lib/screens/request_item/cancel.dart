import 'package:flutter/material.dart';
import 'package:dingzo/model/product.dart';
import 'package:dingzo/screens/edititem.dart';
import 'package:dingzo/screens/request_item/request_detail_Screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/screens/SellItem.dart';
import 'package:dingzo/screens/editaddress.dart';
import 'package:dingzo/screens/request_item/request_item.dart';
import 'package:dingzo/screens/sellerAccountCreation.dart';
import 'package:dingzo/screens/selling/SellingHome/SellingCompleted.dart';
import 'package:dingzo/screens/selling/SellingHome/SellinginProgress.dart';
import 'package:dingzo/screens/selling/SellingHome/listing.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Request_Cancelled extends StatelessWidget {

  Constants _const=Constants();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Products').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return SpinKitCircle(
              color: Colors.black,
            );
          if (!snapshot.hasData) return const Text('No Order');
          List<Product> newCategories = [];
          try{
            List<QueryDocumentSnapshot?> mydocs = snapshot.data!.docs
                .where((element) => (
                (
                    element['seller_id']==currentuser!.uid
                        &&
                        element['product_status'] == "cancelled"
                )

            )

            ).toList();
            if(mydocs.length>0){

              mydocs.forEach((fetcheddata) {
                List<dynamic> photos = fetcheddata!['photos'];
                Product new_product = Product(
                    title: fetcheddata['title'],
                    price: fetcheddata['price'],
                    quantity: 1,
                    rent_duration: fetcheddata['rent_duration'],
                    rent_fare: fetcheddata['rent_fare'],
                    id: fetcheddata.id,
                    product_status: fetcheddata['product_status'],
                    rent: fetcheddata['rent'],
                    date: DateTime.parse(fetcheddata['date']),
                    status: fetcheddata['status'],
                    category: fetcheddata['category'],
                    product_doc_id: fetcheddata.id,
                    description: fetcheddata['description'],
                    total: 0,
                    views: fetcheddata['views'],

                    selected: false,
                    photos:photos
                        .map(
                            (e) => e['imageurl'].toString()
                    )
                        .toList(),

                    sellerid: fetcheddata['seller_id'],

                    sales: fetcheddata['sales'],
                    sellername: fetcheddata['seller_name'].toString()
                );
                print("national 2");
                newCategories.add(new_product);
              });
            }

          }catch(error){

            print("No order");
          }




          return
            newCategories.isEmpty?

            Column(
              children: [
                Container(
                    height: height*0.65,
                    width: width*1,

                    child: Center(child: Text("No Product",style: _const.manrope_regular78909C(15, FontWeight.w700),))),
              ],
            ):
            Container(
              height: height*1,
              child: ListView(
                children: [

                  SizedBox(height: height*0.02,),


                  Column(
                    children: List.generate(newCategories.length, (index) =>
                        Container(
                          margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
                          child:   Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: width*0.3,
                                height: height*0.18,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: NetworkImage(newCategories[index].photos![0].toString())
                                    )
                                ),
                              ),

                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: width*0.025),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(newCategories[index].title.toString(),style: _const.raleway_535F5B(20, FontWeight.w600)),
                                      SizedBox(height: height*0.0025,),
                                      Text("\$${newCategories[index].price}",style: _const.raleway_535F5B(15, FontWeight.w600)),
                                      SizedBox(height: height*0.0025,),
                                      Text("3 Likes",style: _const.raleway_535F5B(15, FontWeight.w600)),
                                      SizedBox(height: height*0.0025,),
                                      Text("${newCategories[index].views} Views",style: _const.raleway_535F5B(15, FontWeight.w600)),
                                      SizedBox(height: height*0.0025,),
                                      Text(newCategories[index].date!.day.toString()+"/"+
                                          newCategories[index].date!.month.toString()+"/"+
                                          newCategories[index].date!.year.toString()
                                          ,style: _const.raleway_535F5B(15, FontWeight.w600)),



                                    ],
                                  ),
                                ),
                              ),

                              Container(
                                width: width*0.28,
                                child: Column(

                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                  children: [

                                    InkWell(
                                      onTap: (){
                                        Navigator.of(context).pushNamed(Request_Detail_Screen.routename,arguments: newCategories[index]);

                                      },
                                      child: Container(
                                        height: height*0.04,
                                        width: width*0.25,
                                        padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                                        decoration: BoxDecoration(
                                            color: mycolor,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Center(child: Text("View Item",style:_const.raleway_SemiBold_white(12, FontWeight.w600),)),
                                      ),
                                    ),

                                    SizedBox(height: height*0.01,),
                                    InkWell(
                                      onTap: (){

                                        Navigator.of(context).pushNamed(EditItem.routename,arguments: newCategories[index]);
                                      },
                                      child: Container(
                                        height: height*0.04,
                                        width: width*0.25,
                                        padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                                        decoration: BoxDecoration(
                                            color: mycolor,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Center(child: Text("Edit",style:_const.raleway_SemiBold_white(12, FontWeight.w600),)),
                                      ),
                                    ),


                                  ],
                                ),
                              ),


                            ],
                          ),
                        )),
                  ),


                ],
              ),
            );
        });
  }
}
