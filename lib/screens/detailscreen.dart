
import 'package:dingzo/screens/onboarding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dingzo/location/current_location_map.dart';
import 'package:dingzo/model/chat_reciver.dart';
import 'package:dingzo/screens/checkout.dart';
import 'package:dingzo/screens/viewprofile.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:dingzo/Database/SociaMediaDatabase.dart';
import 'package:dingzo/Database/database.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/model/product.dart';
import 'package:dingzo/screens/SellItem.dart';
import 'package:dingzo/screens/cart.dart';
import 'package:dingzo/screens/chat/chat.dart';
import 'package:dingzo/screens/chat/conversation.dart';
import 'package:dingzo/screens/profile.dart';
import 'package:dingzo/widgets/Carsoul_Image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
Constants _const=Constants();
class DetailScreen extends StatefulWidget {
  static const routename="DetailScreen";

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  List<String> textslist=["Buy it now","Message Seller"];

double rate=0.0;

late BannerAd _bannerAd;
bool ad_loaded=false;
_initBannerAd(){
 _bannerAd= BannerAd(
    adUnitId: 'ca-app-pub-9207548761153845/1202976546',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(
      onAdLoaded: (ad){

        setState(() {
          ad_loaded=true;
        });
      },
      onAdFailedToLoad: (ad,error){
        print("error is "+error.toString());
      }
    ),
  );
_bannerAd.load();
}

  void _showModalSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          final height = MediaQuery.of(context).size.height;
          final width = MediaQuery.of(context).size.width;
          return new Container(
height: height*0.5,
            color: Color(0xffFFEA9D),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height*0.025,),
                Center(child: Text("Promote your item",style: _const.raleway_SemiBold_darkbrown(25, FontWeight.w700),))
                ,
                SizedBox(height: height*0.025,),
                Center(child: Container(
                    width: width*0.75,
                    child: Text("Promoting your item will make your items price %10 lower.",style: _const.raleway_SemiBold_darkbrown(20, FontWeight.w700),)))
                ,

                SizedBox(height: height*0.045,),
               Container(
                 margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Column(
                       children: [
                         Text("Your Price",style: _const.raleway_SemiBold_darkbrown(20, FontWeight.w700),)
                         ,
                         SizedBox(height: height*0.015,),
                         Container(
                           width: width*0.2,
                           height: height*0.05,
                           decoration: BoxDecoration(
                             color: Colors.white,
                             borderRadius: BorderRadius.circular(10)
                           ),
                         child: Center(child: Text("54",style: _const.raleway_SemiBold_brown(15, FontWeight.w600),)),
                         ),
                       ],
                     ),

                     Column(
                       children: [
                         Text("New Price",style: _const.raleway_SemiBold_darkbrown(20, FontWeight.w700),)
                         ,
                         SizedBox(height: height*0.015,),
                         Container(
                           width: width*0.2,
                           height: height*0.05,
                           decoration: BoxDecoration(
                               color: Colors.white,
                               borderRadius: BorderRadius.circular(10)
                           ),
                           child: Center(child: Text("54",style: _const.raleway_SemiBold_brown(15, FontWeight.w600),)),
                         ),
                       ],
                     ),

                   ],
                 ),
               ),

                SizedBox(height: height*0.045,),
                InkWell(
                  onTap: (){

                    Navigator.of(context).pop();
                  },
                  child: Center(
                    child: Container(
                      height: height*0.05,
                      width: width*0.25,
                      padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                      decoration: BoxDecoration(
                          color: Color(0xffEFB546),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(child: Text("Promote",style:_const.raleway_SemiBold_white(12, FontWeight.w600),)),
                    ),
                  ),
                ),
              ],

            ),
          );
        }
    );
  }

Product ? _prod;
@override
  void initState() {
    // TODO: implement initState

  super.initState();
  _initBannerAd();
  }
  String? _show_stripe_dialogue(BuildContext context, String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Alert'),
          content: Text(msg),
          actions: <Widget>[
            TextButton(
              child: Text('Not Right Now',
                  style: TextStyle(
                      color: Colors.black
                  )
              ),
              onPressed: () {
                Navigator.of(ctx).pop();

              },
            ),
            Container(
              decoration: BoxDecoration(
                  color: mycolor,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: TextButton(
                child: Text('Onboard',style: TextStyle(
                    color: Colors.white
                )),
                onPressed: () {

                  Navigator.of(context).pushNamed(Onboarding.routename).then((value) {
                    Navigator.of(context).pop();
                  });
                },
              ),
            )
          ],
        ));
  }
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    _prod=ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.8,
        leadingWidth: width*0.3
        ,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(_prod!.category.toString(),style: _const.manrope_regular263238(20, FontWeight.w800)),
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();

        }, icon: Icon(Icons.arrow_back_ios,color: Color(0xff3A4651),)),
        actions: [

          InkWell(
            onTap: (){
              Navigator.of(context).pushNamed(Checkout.routename);
            },
            child: Container(
              child: Image.asset('images/cart.png',color: Color(0xff263238)),
            ),
          ),
        ],
      ),

      body: ListView(

        children: [


Carsoul_Image(sold: false,prodimages: _prod!.photos),
          SizedBox(height: height*0.025,),
          Center(child: Text(_prod!.title!,style: _const.raleway_regular_black(30, FontWeight.w700),)),
          Center(child: Text("Price \$${_prod!.price}",style: _const.raleway_regular_black(22, FontWeight.w700),)),
          SizedBox(height: height*0.025,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(textslist.length, (index) =>     InkWell(

              onTap: (){
                if(textslist[index]=="Edit Item"){
                }else{
                  _showModalSheet(context);
                }


              },
              child:


              InkWell(
                onTap: () async {
                  if(index==1){

                    SocialMediaDatabase _social_database=SocialMediaDatabase();

                   await  _social_database
                        .getUserInfogetChats(
                        user2:
                        _prod!.sellerid .toString(),
                    product_id: _prod!.product_doc_id
                    )
                        .then((value) async {
                      print(
                          "so final chatroom id is " +
                              value.toString());


              MyUser ? sellerend= await database.fetch_seller_mini_detail(DesiredUserID: _prod!.sellerid);


                      Navigator.of(context).pushNamed(
                        Chat_Screen.routename,
                        arguments: ChatReciever(

                            chatid: value.toString(),
                            user:  sellerend,
                            product:_prod
                        )
                      );


                    });
                  }
                  else {
                    if (currentuser!.accountcreated == false){
                      _show_stripe_dialogue(context, "In order to list the item, you must onboard.");

                    }
                    else{
                      if(cartitems.any((element) => element.product_doc_id==_prod!.product_doc_id)
                      ){
                        Fluttertoast.showToast(
                            msg: "Already Added to Cart",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                      else{
                        cartitems.add(_prod!);
                        Fluttertoast.showToast(
                            msg: "Added to Cart",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    }

                  }
                },
                child: Container(
                  height: height*0.07,
                  width: width*0.4,
                  margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
                  padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                  decoration: BoxDecoration(
                      color: mycolor,
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: Center(child: Text(textslist[index],textAlign: TextAlign.center,style: _const.poppin_white(15, FontWeight.w700),)),
                ),
              ),
            ),
            ),
          ),



          DetailsBox(context,rate,_prod!),


          SizedBox(height: height*0.02,),
          if(ad_loaded)
            Container(
              alignment: Alignment.center,
              child: AdWidget(ad: _bannerAd),
              width: _bannerAd.size.width.toDouble(),
              height: _bannerAd.size.height.toDouble(),
            ),
          SizedBox(height: height*0.02,),
          Divider(),
          SizedBox(height: height*0.02,),
          if(_prod!.seller!=null)
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return SocialProfile(_prod!.sellerid);
              }));
            },
            child: Container(
              height: height*0.15,
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: width*0.025),

                    width: width*0.6,

                    child: Row(
                      children: [
                        (_prod!.seller!=null&& _prod!.seller!.imageurl!=null && _prod!.seller!.imageurl!.isNotEmpty)?
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(_prod!.seller!.imageurl!.toString()),
                        ):
                        CircleAvatar(
                          radius: 25,
                          child: Text("No Image",style: TextStyle(fontSize: 10,color: Colors.white)),
                        )
                        ,
                        Container(
                          margin: EdgeInsets.only(left: width*0.025),

                          child: Column(

                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [

                              Container(
                                child: Text(_prod!.seller!.username!,style: _const.poppin_Regualr(15, FontWeight.w600)),
                              ),


                              Row(
                                children: [
                                  Row(
                                    children: List.generate(5, (index) => Icon(Icons.star,color: Colors.yellow,)),
                                  ),
                                  Text(_prod!.seller!.socialMedia!.rating!.toString(),style: _const.poppin_orange(17, FontWeight.w600),)
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),

                  ),

                ],
              ),
            ),
          ),
          SizedBox(height: height*0.025,),


          Divider(),
          SizedBox(height: height*0.02,),
          Container(
            margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
            child: Row(
              children: [
                Container(
                  height: height*0.12,
                  width: width*0.25,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(4)

                  ),
                ),

                Container(
                    margin: EdgeInsets.only(left: width*0.05),

                    width: width*0.6,
                    child: Text("Buyer Protection: Revieve your item as described or your money back for all purchases on Dingzo. ",style: _const.raleway_SemiBold_darkbrown(14, FontWeight.w600),))
              ],
            ),
          ),
          SizedBox(height: height*0.02,),
          Divider(),
          SizedBox(height: height*0.02,),

          Container(
              margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

              child: Text("Similar Items",style: _const.poppin_dark_brown(22, FontWeight.w600),)),
          SizedBox(height: height*0.02,),


          StreamBuilder(
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
                          element['seller_id']!=currentuser!.uid
                              &&
                              element['product_status'] == "listed" &&
                              element['category']==_prod!.category &&
                              element.id!=_prod!.product_doc_id
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
                          height: height*0.22,

                          child: Center(child: Text("No Product",style: _const.manrope_regular78909C(15, FontWeight.w700),))),
                    ],
                  ):
                  Container(
                    height:  height *((newCategories.length /3)*0.75),
                    child:   GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: height*0.025,
                            crossAxisCount: 3,
                            mainAxisExtent: height*0.25

                        ),

                        itemCount: newCategories.length,
                        itemBuilder: (context,index){

                          return  Container(
                            margin: EdgeInsets.only(left: width*0.025),
                            width: width*0.38,

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(

                                  child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(newCategories[index].photos![0])
                                        )
                                    ),

                                  ),
                                  flex: 3,
                                ),


                                Expanded(

                                  child: Container(
                                    margin: EdgeInsets.only(left: width*0.025,right: width*0.025),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(newCategories[index].title!,style: _const.raleway_regular_black(12, FontWeight.w600),),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [


                                            Container(
                                                width: width*0.2,
                                                child: Text(newCategories[index].price!.toString(),style: _const.raleway_regular_black(12, FontWeight.w700),)),

                                            Icon(Icons.favorite,color: Colors.red,size: 12,),
                                          ],
                                        ),

                                      ],

                                    ),
                                  ),

                                  flex: 1,
                                )

                              ],
                            ),
                            height: height*0.2,

                          );

                        }),
                  );
              }),


          SizedBox(height: height*0.15,),


        ],
      ),

      floatingActionButton: InkWell(
        onTap: (){
          if (currentuser!.accountcreated == false){
            _show_stripe_dialogue(context, "In order to list the item, you must onboard.");

          }
          else{
            if(cartitems.any((element) => element.product_doc_id==_prod!.product_doc_id)
            ){
              Fluttertoast.showToast(
                  msg: "Already Added to Cart",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
            else{

              cartitems.add(_prod!);
              Fluttertoast.showToast(
                  msg: "Added to Cart",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          }

        },
        child: Container(
          height: height*0.07,
          width: width*0.6,
          margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
          padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
          decoration: BoxDecoration(
              color: mycolor,
              borderRadius: BorderRadius.circular(30)
          ),
          child: Center(child: Text("Buy it now",textAlign: TextAlign.center,style: _const.poppin_white(15, FontWeight.w700),)),
        ),
      ),
   floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
Widget DetailsBox(BuildContext context,double rate,Product prod){
  final width=MediaQuery.of(context).size.width;
  final height=MediaQuery.of(context).size.height;
  return Container(
    margin: EdgeInsets.only(left: width*0.05,right:  width*0.05),
    child: Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(),
        Text("Description",style: _const.raleway_regular_black(22, FontWeight.w700),),
        SizedBox(height: height*0.015,),
        Text(prod.description.toString(),style: _const.raleway_regular_black(15, FontWeight.w500)),
        SizedBox(height: height*0.015,),
        Divider(),

        Text("Category",style: _const.raleway_regular_black(22, FontWeight.w700),),
        SizedBox(height: height*0.015,),

        Text("${prod.category} : ${prod.title}",style: _const.raleway_regular_black(15, FontWeight.w500)),
        SizedBox(height: height*0.025,),

       FutureBuilder(
           future: database.fetch_mini_user(DesiredUserID: prod.sellerid),
           builder: (context,AsyncSnapshot<MyUser?> snapshot){
         return snapshot.connectionState==ConnectionState.waiting || !snapshot.hasData?Text(""):
         CurrentLocationScreen(my_location: LatLng(snapshot.data!.location_details!.latitude!,
             snapshot.data!.location_details!.longitude!),);
       })


      ],
    ),
  );
}