import 'package:dingzo/Database/database.dart';
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
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class BuyerInProgress extends StatefulWidget {

  @override
  State<BuyerInProgress> createState() => _BuyerInProgressState();
}

class _BuyerInProgressState extends State<BuyerInProgress> {

  void _show_processing_dialogue() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(

              height: MediaQuery.of(context).size.height*0.3,
              width: MediaQuery.of(context).size.width*0.7,
              decoration: BoxDecoration(
                  color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Center(
                child: SpinKitCircle(
                  color: mycolor,
                ),
              ),
            ),
          ],
        ));
  }
  Constants _const=Constants();
  bool laoding=false;
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
                       (element['order_status'] == "in_progress" ||
                           element['order_status'] == "rating" ||
                           element['order_status']=="in_use" ||
                           element['order_status'] == "return"
                       )
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
                                category: e['category'],
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
                        products: fetched_prod,
                     rating_due_date:
                     rating_due_date_stamp==null?
                         DateTime.now():
                     rating_due_date_stamp.toDate()
                   ,
                     buyer_rate: fetcheddata['buyer_rate'],
                     seller_rate: fetcheddata['seller_rate'],
                     payment_id: fetcheddata['payment_id']
                    ));


                  });
                }
            
              }catch(error){
                
                print("No order");
              }




              return
                laoding?
                   SpinKitCircle(
                     color: mycolor,
                   )
                    :
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
                        Navigator.of(context).pushReplacementNamed(BuyingDetail.routename,arguments:desiredorders[index]);
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
                                  Text(desiredorders[index].date!.day.toString()+"-"+desiredorders[index].date!.month.toString()+"-"+desiredorders[index].date!.year.toString()  ,style: _const.raleway_535F5B(15, FontWeight.w600)),


                                ],
                              ),
                            ),

                            InkWell(

                              onTap: () async {

                                if(desiredorders[index].products![0].rent!) {
    if(desiredorders[index].order_status=="rating") {
      bool expred = desiredorders[index].rating_due_date!.isAfter(
          DateTime.now());
      if(expred==false){
        setState(() {
          laoding=true;
        });
        List<double> ratings=await database.fetchrating(DesiredUserID: desiredorders[index].sellerid!);
        ratings.add(5);
        await database.fetch_seller_mini_detail(DesiredUserID:desiredorders[index].sellerid!).then((sellerend) async{

          print("seller doc is "+sellerend!.doc.toString());
          await database.update_rating(sellerend.doc.toString(), ratings, context).then((value) async{
            await     database.updateProductStatus(productid: desiredorders[index].products![0].product_doc_id,status: 'completed').then((value)async {

              await  releasefund(desiredorders[index].payment_id!).then((value) async{
                await     database.updateOrder(orderid:desiredorders[index].order_id,status: 'completed',
                    buyer_rate: true
                ).then((value) async{


                  await socialMediaDatabase.sendPushMessage(title: 'You have new message', body:'Seller rated your order',
                      token: sellerend.deviceid);
setState(() {
  laoding=false;
});
                  Navigator.of(context).pushNamed(BuyingDetail.routename,
                      arguments:desiredorders[index]);
                });
              });

            });

          });
        });

      }
      else{
        Navigator.of(context).pushNamed(BuyingDetail.routename,
            arguments:desiredorders[index]);
      }
    }
    else{
      Navigator.of(context).pushNamed(BuyingDetail.routename,
          arguments:desiredorders[index]);
    }


                                }
                                else{
if(desiredorders[index].order_status=="rating"){

bool expred=desiredorders[index].rating_due_date!.isAfter(DateTime.now());

if(expred==false){
   setState(() {
     laoding=true;
   });
  List<double> ratings=await database.fetchrating(DesiredUserID: desiredorders[index].sellerid!);
  ratings.add(5);
  await database.fetch_seller_mini_detail(DesiredUserID:desiredorders[index].sellerid!).then((sellerend) async{
 print("seller doc is "+sellerend!.doc.toString());
    await database.update_rating(sellerend.doc.toString(), ratings, context).then((value) async{
      await     database.updateProductStatus(productid: desiredorders[index].products![0].product_doc_id,status: 'completed').then((value)async {

        await  releasefund(desiredorders[index].payment_id!).then((value) async{
          await     database.updateOrder(orderid:desiredorders[index].order_id,status: 'completed',
              buyer_rate: true
          ).then((value) async{


            await socialMediaDatabase.sendPushMessage(title: 'You have new message', body:'Seller rated your order',
                token: sellerend.deviceid);
            setState(() {
              laoding=false;
            });
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Buyer_Sell_Home_Page(current_order:desiredorders[index],)));


          });
        });

      });

    });
  });

}
else{
  Navigator.push(context, MaterialPageRoute(builder: (context)=>Buyer_Sell_Home_Page(current_order:desiredorders[index],)));

}
}

else{
  Navigator.push(context, MaterialPageRoute(builder: (context)=>Buyer_Sell_Home_Page(current_order:desiredorders[index],)));


}

                                  //

                                }

                              },
                              child: Container(
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
