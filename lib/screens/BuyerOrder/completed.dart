import 'package:dingzo/constants.dart';
import 'package:dingzo/model/order.dart';
import 'package:dingzo/screens/buying/Buyer_Sell_order/Buyer_Sell_Home.dart';
import 'package:dingzo/screens/buying/BuyingDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as cloud;
import 'package:dingzo/Database/SociaMediaDatabase.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/model/product.dart';
import 'package:dingzo/screens/chat/chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuyerCompleted extends StatelessWidget {

  Constants _const=Constants();


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin:EdgeInsets.only(top: height*0.025),
        child:
        StreamBuilder(
            stream: cloud.FirebaseFirestore.instance.collection('Orders').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<cloud.QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return SpinKitCircle(
                  color: Colors.black,
                );
              if (!snapshot.hasData) return const Text('No Order');
              List<Order> ?  desiredorders=[];
              try{
                List<cloud.QueryDocumentSnapshot?> mydocs = snapshot.data!.docs
                    .where((element) => (
                    (
                        element['userid']==currentuser!.uid
                            &&
                            element['order_status'] == "completed"
                    )

                )

                ).toList();
                if(mydocs.length>0){
                  mydocs.forEach((fetcheddata) {
                    cloud.Timestamp stamp = fetcheddata!['date'];
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
                                category: e['category'],
                                id: e['prodoct_id'],
                                indiviusal_totalprice: fetcheddata['total_price'],
                                photos: photos
                            ));
                      });
                    }

                    cloud.Timestamp pickupstamp = fetcheddata['pickup']['date'];
                    DateTime date = stamp.toDate();
                    DateTime pickupdate = pickupstamp.toDate();
                    desiredorders.add( Order(
                        drop_of_item_image: fetcheddata['drop_of_item_image'],
                        order_id: fetcheddata.id,
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
                    ));
                  });
                }

              }catch(error){

                print("No order");
              }




              return
                desiredorders.isEmpty?

                Column(
                  children: [
                    Container(
                        height: height*0.65,
                        width: width*1,

                        child: Center(child: Text("No Data",style: _const.manrope_regular78909C(15, FontWeight.w700),))),
                  ],
                ):
                Column(

                    children:List.generate(desiredorders.length, (index) =>         InkWell(
                      onTap: (){
                        if(desiredorders[index].products![0].rent!) {
                          Navigator.of(context).pushNamed(BuyingDetail.routename,
                              arguments:desiredorders[index]);
                        }
                        else{
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Buyer_Sell_Home_Page(current_order:desiredorders[index],)));

                        }

                      },
                      child: Container(
                        margin: EdgeInsets.only(left: width*0.025,right: width*0.025),
                        child:   Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: width*0.3,
                              height: height*0.17,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(desiredorders[index].products![0].photos![0])
                                  )
                              ),
                            ),

                            Container(
                              width: width*0.3,
                              margin: EdgeInsets.only(left: width*0.025,right: width*0.025),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(desiredorders[index].products![0].title!,style: _const.raleway_535F5B(20, FontWeight.w600),
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                  SizedBox(height: height*0.01,),
                                  Text("\$${desiredorders[index].total_price}",style: _const.raleway_535F5B(15, FontWeight.w600)),
                                  SizedBox(height: height*0.01,),
                                  Text(desiredorders[index].date!.day.toString()+"-"+desiredorders[index].date!.month.toString()+"-"+desiredorders[index].date!.year.toString()  ,style: _const.raleway_SemiBold_darkbrown(15, FontWeight.w600)),


                                ],
                              ),
                            ),

                            Container(
                              height: height*0.04,
                              width: width*0.25,
                              margin: EdgeInsets.only(left: width*0.05),
                              padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                              decoration: BoxDecoration(
                                  color: Color(0xffBCEFE0),

                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Center(child: Text("View Order",style:_const.raleway_535F5B(12, FontWeight.w600),)),
                            ),



                          ],
                        ),
                      ),
                    ),
                    )
                );
            }),
      ),
    );
  }

}
