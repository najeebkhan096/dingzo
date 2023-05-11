
import 'package:dingzo/Database/database.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/screens/edititem.dart';
import 'package:dingzo/screens/selling/SellerSell_Item_Detail_Page/seller_sell_item_detail_page.dart';
import 'package:dingzo/screens/selling/Seller_Rent_Item_Detail_Page/Seller_Rent_Item_Detail_Page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/model/product.dart';

import 'package:flutter/cupertino.dart';

class SellingCompleted extends StatelessWidget {

  Constants _const=Constants();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body:    StreamBuilder(
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
                      element['seller_id'] == currentuser!.uid

                          && (

                          element['product_status']=='completed'


                      )
                  )
              )

              ).toList();
              if(mydocs.length>0){
                mydocs.forEach((fetcheddata) {
                  List<dynamic> photos = fetcheddata!['photos'];
                  List<dynamic> likesdynamic=fetcheddata['likes'];

                  List<Likes> _likes_list=[];
                  likesdynamic.forEach((element) {
                    if(element['status']){
                      _likes_list.add(
                          Likes(
                              userid: element['userid'].toString(),
                              status: element['status']
                          )
                      );
                    }

                  });

                  Product new_product = Product(
                      likes: _likes_list,
                      order_id: fetcheddata['order_id'],
                      views: fetcheddata['views'],
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
              ListView(
                children: [

                  SizedBox(height: height*0.02,),

                  Column(
                    children: List.generate(newCategories.length, (index) =>  Container(
                      margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
                      child:   Row(
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
                                          image: NetworkImage(newCategories[index].photos![0].toString())
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
                              margin: EdgeInsets.only(left: width*0.025),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(newCategories[index].title.toString(),style: _const.raleway_535F5B(20, FontWeight.w600)),
                                  SizedBox(height: height*0.0025,),
                                  Text("\$${newCategories[index].price}",style: _const.raleway_535F5B(15, FontWeight.w600)),
                                  SizedBox(height: height*0.0025,),
                                  Text("${newCategories[index].likes!.length} Likes",style: _const.raleway_535F5B(15, FontWeight.w600)),
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

                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [

                                InkWell(
                                  onTap: (){
                                    if(newCategories[index].rent!)
                                      Navigator.of(context).pushNamed(Seller_Rent_item_Detail_Page.routename,arguments: newCategories[index]);

                                    else

                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Seller_Sell_item_Detail_Page(current_product: newCategories[index],)));

                                  },
                                  child: Container(
                                    height: height*0.04,
                                    width: width*0.25,
                                    padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                                    decoration: BoxDecoration(
                                        color: Color(0xff1A5A47),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(child: Text("View Item",style:_const.raleway_SemiBold_white(12, FontWeight.w600),)),
                                  ),
                                ),

                                SizedBox(height: height*0.015,),

                                InkWell(
                                  onTap: ()async{
                             await database.updateProductStatus(
                               status: 'listed',
                               productid:newCategories[index].product_doc_id
                             );
                                  },
                                  child: Container(
                                    height: height*0.04,
                                    width: width*0.25,
                                    padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                                    decoration: BoxDecoration(
                                        color: Color(0xff1A5A47),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(child: Text("Re list",style:_const.raleway_SemiBold_white(12, FontWeight.w600),)),
                                  ),
                                ),

                              ],
                            ),
                          ),


                        ],
                      ),
                    ),),
                  )



                ],
              );
          }),
    );
  }
}