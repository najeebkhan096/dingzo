import 'dart:math';

import 'package:dingzo/Address/location.dart';
import 'package:dingzo/Database/product_database.dart';
import 'package:dingzo/hometesting.dart';
import 'package:dingzo/location/google_places_api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dingzo/notificationservice/local_notification_service.dart';
import 'package:dingzo/screens/mylikes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:dingzo/screens/editaddress.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:dingzo/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dingzo/screens/checkout.dart';
import 'package:dingzo/screens/home/search.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:dingzo/Database/database.dart';
import 'package:dingzo/Database/payment.dart';
import 'package:dingzo/Database/sellerdatabase.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/model/product.dart';
import 'package:dingzo/screens/detailscreen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/model/order.dart';
import 'package:dingzo/screens/categories.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;

class HomeScreen extends StatefulWidget {
final  List<Product> all_products;
final BannerAd ? banner;
final bool ad_loaded;
 List<Product> browse_products;
HomeScreen({required this.all_products,required this.browse_products,required this.banner,required this.ad_loaded});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Constants _const=Constants();




  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  String? mtoken = "clDp0-WnStCc5nruahpEUI:APA91bFUuZ2LHNNcJE6TQyfdrNl9cKWryeHkNh95zQpLMQCGgwRYpza9JoGCf1BwubHOvF3SKvcLqa__Me4j4wuGS50AXeyKMC-sMcXmdxvTgOQdAv4pWM-fw8Tqpx2hpkRiy0vP8ePl";






@override
  void initState() {
    // TODO: implement initState

  super.initState();
  }


  Future post_likes({required String post_id,required BuildContext context,List<Likes> ? likes}) async {


    int targetindex=likes!.indexWhere((element) => element.userid==currentuser!.uid);

    if(targetindex==-1){

      likes.add(Likes(
          userid: currentuser!.uid,
          status: true
      ));

    }

    else{

      likes[targetindex]=Likes(
          userid: currentuser!.uid,
          status: !likes[targetindex].status!
      );



    }

    CollectionReference collection =
    FirebaseFirestore.instance.collection('Products');

    await  collection.doc(post_id).set(
        {
          'likes':   likes.map((e) => {
            'status':e.status,
            'userid':e.userid
          }).toList()
        }

        , SetOptions(merge: true)).then((value) {

    }).then((value) {


    });

  }



  List<dynamic> categs=[
    {
      'title':'All',
      'status':true
    },
    {
      'title':'Items for Rent',
      'status':false
    },
    {
      'title':'Items for Sale',
      'status':false
    },
    {
      'title':'My Likes',
      'status':false
    },

  ];

  bool fetched=false;
Database _database=Database();

SellerDatabase sellerDatabase=SellerDatabase();

  Future refresh_products()async{


    categs.forEach((element) {

      if(element['title']=='Items for Rent'){
        if(element['status']==true){
          List<Product> newcategories=[];
          widget.all_products.forEach((browse_element) {
            if(browse_element.banner==true){

            }
            else{
              if(browse_element.rent! && browse_element.distance!<currentuser!.filter_distance!){
                newcategories.add(browse_element);
              }
            }

          });

          Random random = new Random();

          int randomNumber = random.nextInt(newcategories.length==0?1:newcategories.length);
          newcategories.insert(randomNumber,
              Product(id: '', price: 11, title: '', quantity: 1,banner: true)

          );
          setState(() {
            widget.browse_products=newcategories;

          });


        }

      }

      else if(element['title']=='Items for Sale'){



        if(element['status']==true){
          List<Product> newcategories=[];
          widget.all_products.forEach((browse_element) {
            if(browse_element.banner==true){

            }
            else{
              if(browse_element.rent==false && browse_element.distance!<currentuser!.filter_distance!){
                newcategories.add(browse_element);
              }
            }



          });
          Random random = new Random();
          int randomNumber = random.nextInt(newcategories.length==0?1:newcategories.length);
          newcategories.insert(randomNumber,
              Product(id: '', price: 11, title: '', quantity: 1,banner: true)

          );
          setState(() {
            widget.browse_products=newcategories;

          });

        }
      }
      else if(element['title']=='My Likes'){

        if(element['status']==true){
          List<Product> newcategories=[];
          widget.all_products.forEach((element) {
            if(element.banner==true){

            }
            else{
              if(element.like_status==true){

                newcategories.add(element);

              }
            }


          }
          );
          Random random = new Random();
          int randomNumber = random.nextInt(newcategories.length==0?1:newcategories.length);
          newcategories.insert(randomNumber,
              Product(id: '', price: 11, title: '', quantity: 1,banner: true)

          );
          setState(() {
            widget.browse_products=newcategories;

          });

        }
      }
      else{
        List<Product> templist=widget.all_products;
templist.forEach((element) {
  print(element.banner.toString());
});
setState(() {
  widget.browse_products=templist;
});
      }

    });






  }









  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;

    return   currentuser==null?
    Container(
      height: height*1,
      child: SpinKitCircle(
        color: mycolor,
      ),
    )
        :
    SingleChildScrollView(
      child: Container(
        height:
        height*1.18
        ,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              margin: EdgeInsets.only(left: width*0.025,right: width*0.075),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return GoogleMapsScreenApi();
                            })).then((value) {
                              setState(() {

                              });
                            });
                          },
                          child: Image.asset("images/location.png",width: width*0.15,height: height*0.035,)),

                      if(currentuser!.home_address!.length>0)
                        InkWell(
                          onTap: (){

                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return LocationScreen();
                            })).then((value) {setState(() {

                            });});


                          },
                          child: Text(currentuser!.home_address!.first.address1!+" : ${currentuser!.filter_distance} miles" ,style: _const.raleway_regular_black(18, FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        )
                    ],
                  ),



                ],
              ),
            ),
            SizedBox(height: height*0.015,),
            Container(
              height: height*0.08,

              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(categs.length, (index) =>  InkWell(
                    onTap: (){

                      for(int i=0;i<categs.length;i++){
                        if(i==index){
                          setState(() {
                            categs[i]['status']=true;
                          });
                        }
                        else{
                          setState(() {
                            categs[i]['status']=false;
                          });
                        }
                      }
                      refresh_products();
                    },
                    child: Container(

                      margin: EdgeInsets.only(left: width*0.05),
                      child: Chip(
                          side: BorderSide(
                              color: categs[index]['status']?
                              mycolor:
                              Colors.black,
                              width: 0.5
                          ),
                          padding: EdgeInsets.all(7),
                          label: Text(categs[index]['title'],
                            style: _const.raleway_1A5A47(12, FontWeight.w700),
                          ),

                          backgroundColor:
                          categs[index]['status']==true?
                          mycolor:
                          Colors.white
                      ),
                    ),
                  ))
              ),
            ),



            (widget.browse_products.length==0 || widget.ad_loaded==false)?

            Container(
                width: width*1,
                height: height*0.28,
                child: Center(child: Text("No Product",style: _const.manrope_regular263238(12, FontWeight.w600),)))

                :
            Container(
              height: height*0.8,
              child:   GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: height*0.025,
                      crossAxisCount: 3,
                      mainAxisExtent: height*0.2

                  ),

                  itemCount: widget.browse_products.length,
                  itemBuilder: (context,index){


                    return

                      widget.browse_products[index].banner==true?

                      StatefulBuilder(
                        builder: (context, setState)
                        {
                        ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
                          print("lund"+errorDetails.silent.toString());
                        return Text("",
                        style: TextStyle(
                          fontSize: 11
                        ),
                        );
                        };

                        return Container(
                          child: AdWidget(ad: widget.banner!),
                          width: widget.banner!.size.width.toDouble(),
                          height: 100.0,
                          alignment: Alignment.center,
                        );
                        }

                      )
                          :


                      Container(
                        margin: EdgeInsets.only(left: width*0.025,right: width*0.025 ),
                        width: width*0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Expanded(

                              child: InkWell(
                                onTap: ()async{
                                  await       productdatabase.update_views(
                                      productid: widget.browse_products[index].product_doc_id,
                                      views: widget.browse_products[index].views!+1
                                  ).then((value) async{
                                    await database.fetchprofiledata(DesiredUserID: widget.browse_products[index].sellerid).then((seller) {
                                      widget.browse_products[index].seller=seller;
                                      Navigator.of(context).pushNamed(DetailScreen.routename ,arguments: widget.browse_products[index]);
                                    });
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(widget.browse_products[index].photos![0])
                                      )
                                  ),

                                ),
                              ),
                              flex: 4,
                            ),

                            Expanded(

                              child: Container(

                                margin: EdgeInsets.only(left: width*0.015,right: width*0.015),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    widget.browse_products[index].rent!?
                                    Text(widget.browse_products[index].title!.toString()+" For Rent",style: _const.raleway_regular_black(12, FontWeight.w700),):
                                    Text(widget.browse_products[index].title!.toString()+" For Sale",style: _const.raleway_regular_black(12, FontWeight.w700),),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("\$"+widget.browse_products[index].price!.toString(),style: _const.raleway_regular_black(12, FontWeight.w700),),
                                        widget.browse_products[index].like_status! ?

                                        InkWell(
                                          onTap: ()async{

                                            setState(() {
                                              widget.browse_products[index].like_status=!widget.browse_products[index].like_status!;

                                            });

                                            await  post_likes(
                                              post_id: widget.browse_products[index].id!,context: context,
                                              likes:widget.browse_products[index].likes! ,

                                            ).then((value) {
                                              refresh_products();
                                            });

                                          },
                                          child:   Icon(Icons.favorite,color: Colors.red,size: 16,),
                                        ) :
                                        InkWell(

                                          onTap: ()async{

                                            setState(() {
                                              widget.browse_products[index].like_status=!widget.browse_products[index].like_status!;

                                            });
                                            refresh_products();
                                            await  post_likes(
                                              post_id: widget.browse_products[index].id!,context: context,
                                              likes:widget.browse_products[index].likes! ,

                                            ).then((value) {

                                            });

                                          },
                                          child:   Icon(Icons.favorite_border,color: Colors.red,size: 16,),
                                        ),

                                      ],

                                    ),
                                  ],
                                ),
                              ),

                              flex: 2,
                            )

                          ],
                        ),
                        height: height*0.05,

                      );

                  }),
            ),

            SizedBox(height: height*0.02,),



          ],
        ),
      ),
    );

  }
}
