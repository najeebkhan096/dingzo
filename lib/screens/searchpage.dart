import 'package:dingzo/Database/product_database.dart';
import 'package:dingzo/screens/request_item/request_item.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dingzo/Address/location.dart';
import 'package:dingzo/Database/database.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/location/google_places_api.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/model/product.dart';
import 'package:dingzo/screens/detailscreen.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
class SearchPage extends StatefulWidget {
  static const routename="SearchPage";
  final String ? desiredcategory;
   List<String> ? history;
   List<Product> ? desired_products;

    SearchPage({ this.desiredcategory,this.history, this.desired_products});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
    Constants _const=Constants();

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

    List<Product> browse_products=[];
    Future fetch_all_products()async{

      browse_products=[];


      Future.forEach(widget.desired_products!, (_prod) async{
        Product new_product=_prod as Product;
        await  database.fetch_mini_user(DesiredUserID: new_product.sellerid).then((seller) async{


          double distance= await productdatabase.getTheDistance(final_position:

          LatLng(currentuser!.location_details!.latitude!,
              currentuser!.location_details!.longitude!

          ),
              initial: LatLng(seller!.location_details!.latitude!, seller.location_details!.longitude!)
          );
          double miles=distance*0.000621371;

          _prod.distance=miles;

          if(miles<currentuser!.filter_distance!){
            browse_products.add(_prod);
            List<Product> new_likes=[];
            widget.desired_products!.forEach((element) {

              if(element.like_status==true){

                new_likes.add(element);

              }

            }
            );


          }
        });


      }).then((value) {
        setState(() {
          fetched=true;
        });
      });




    }
    Future post_likes({required String post_id,required BuildContext context,List<Likes> ? likes}) async {

      print("list  is "+likes.toString());
      int targetindex=likes!.indexWhere((element) => element.userid==currentuser!.uid);
      print("target index is "+targetindex.toString());
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

    Future refresh_products()async{


      categs.forEach((element) {

        if(element['title']=='Items for Rent'){
          if(element['status']==true){
            List<Product> newcategories=[];
            widget.desired_products!.forEach((browse_element) {
              if(browse_element.rent! && browse_element.distance!<currentuser!.filter_distance!){
                newcategories.add(browse_element);
              }
            });


            setState(() {
              browse_products=newcategories;

            });


          }
        }

        else if(element['title']=='Items for Sale'){
          if(element['status']==true){
            List<Product> newcategories=[];
            widget.desired_products!.forEach((browse_element) {
              if(browse_element.rent==false && browse_element.distance!<currentuser!.filter_distance!){
                newcategories.add(browse_element);
              }
            });


            setState(() {
              browse_products=newcategories;

            });

          }
        }
        else if(element['title']=='My Likes'){

          if(element['status']==true){
            List<Product> newcategories=[];
            widget.desired_products!.forEach((element) {

              if(element.like_status==true){

                newcategories.add(element);

              }

            }
            );

            setState(() {
              browse_products=newcategories;
              print("lund "+newcategories.length.toString());
            });

          }
        }
        else{
          setState(() {
            browse_products=widget.desired_products!;
          });
        }

      });






    }

    @override
  Future<void> didChangeDependencies() async {
    // TODO: implement didChangeDependencies
      await    fetch_all_products();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  _initBannerAd();
    }


    int index=0;

    @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;



    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Container(
          height: height*1.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              SizedBox(height: height*0.075,),

              Center(
                child: Container(
                  width: width*0.8,
                  height: height*0.06,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                        width: 0.5
                      ),
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Center(child: Text(widget.desiredcategory!.toString())),
                ),
              ),

              SizedBox(height: height*0.05,),

              Container(
                margin: EdgeInsets.only(left: width*0.075,right: width*0.075),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pushNamed(GoogleMapsScreenApi.routename);
                      },
                      child:Row(
                        children: [
                          Image.asset("images/location.png",width: width*0.15,height: height*0.035,),


                          Text(currentuser!.home_address!.first.address1! ,style: _const.raleway_regular_black(18, FontWeight.w600),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),

                    Row(
                      children: [

                        InkWell(
                            onTap: ()async{

                              if(!widget.history!.contains(widget.desiredcategory)){
                                widget.history!.add(widget.desiredcategory.toString());
                                await     database.update_saved_search_products_history(user_id, widget.history!, context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Saved your search"))
          );
                              }

                            },
                            child: Icon(Icons.bookmark)),
                        SizedBox(width: width*0.025,),
                        InkWell(
                          onTap: (){
                            Navigator.of(context).pushNamed(LocationScreen.routename);
                          },
                          child: Image.asset("images/Filter Slider.png",
                          width: width*0.05,
                          ),
                        )
                      ],
                    )

                  ],
                ),
              ),



SizedBox(height: height*0.025,),
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




              fetched?



              Container(
height: height*0.45,

                child:   GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: height*0.025,
                      crossAxisCount: 3,
                      mainAxisExtent: height*0.15

                    ),

                    itemCount: browse_products.length+1,
                    itemBuilder: (context,index){

                      return

                        index==0?
                        ad_loaded?

                        Container(
                          margin: EdgeInsets.only(left: width*0.025),
                          width: width*0.38,

                          child:   Container(
                            alignment: Alignment.center,
                            child: AdWidget(ad: _bannerAd),
                            width: _bannerAd.size.width.toDouble(),
                            height: _bannerAd.size.height.toDouble(),
                          ),
                          height: height*0.2,

                        )
                            :Text(""):
                        Container(
                          margin: EdgeInsets.only(left: width*0.025),
                          width: width*0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color:mycolor,
                          ),
                          child: Column(
                            children: [
                              Expanded(

                                child: InkWell(
                                  onTap: ()async{
                                    await       productdatabase.update_views(
                                        productid: browse_products[index-1].product_doc_id,
                                        views: browse_products[index-1].views!+1
                                    ).then((value) async{
                                      await database.fetchprofiledata(DesiredUserID: browse_products[index-1].sellerid).then((seller) {
                                        browse_products[index-1].seller=seller;
                                        Navigator.of(context).pushNamed(DetailScreen.routename ,arguments: browse_products[index-1]);
                                      });
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(
                                                browse_products[index-1].photos!.length==0?
                                                    "https://static1.anpoimages.com/wordpress/wp-content/uploads/2020/02/Our-5-favorite-universal-USB-C-Power-Delivery-chargers-for-all-your-gadgets-Hero.png":
                                                browse_products[index-1].photos![0])
                                        )
                                    ),

                                  ),
                                ),
                                flex: 3,
                              ),

                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: width*0.025,right: width*0.025),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(browse_products[index-1].price!.toString(),style: _const.poppin_white(12, FontWeight.w700),),
                                      browse_products[index-1].like_status! ?

                                      InkWell(
                                        onTap: ()async{

                                          setState(() {
                                            browse_products[index-1].like_status=!browse_products[index-1].like_status!;

                                          });

                                          await  post_likes(
                                            post_id: browse_products[index-1].id!,context: context,
                                            likes:browse_products[index-1].likes! ,

                                          ).then((value) {
                                            refresh_products();
                                          });

                                        },
                                        child:   Icon(Icons.favorite,color: Colors.red,size: 16,),
                                      ) :
                                      InkWell(

                                        onTap: ()async{

                                          setState(() {
                                            browse_products[index-1].like_status=!browse_products[index-1].like_status!;

                                          });
                                          refresh_products();
                                          await  post_likes(
                                            post_id: browse_products[index-1].id!,context: context,
                                            likes:browse_products[index-1].likes! ,

                                          ).then((value) {

                                          });

                                        },
                                        child:   Icon(Icons.favorite_border,color: Colors.red,size: 16,),
                                      ),

                                    ],

                                  ),
                                ),

                                flex: 1,
                              )

                            ],
                          ),
                          height: height*0.05,

                        );

                    }),
              ):

              Container(
                  height: height*0.45,
                  child: Center(child: Text("No Product ")))
              ,

              Center(
                child: Container(
                  margin: EdgeInsets.only(left: width*0.025,
                  right: width*0.025
                  ),
                  child: Text("Don’t see the item you are looking for?",
                  style: _const.raleway_regular_black(height*0.02, FontWeight.w700),
                  ),
                ),
              ),
              SizedBox(height: height*0.02,),
              
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pushNamed(Post_Request_Item.routename);
                      },
                      child: Container(
                        width: width*0.55,
                        height: height*0.06,
                        margin: EdgeInsets.only(right: width*0.025),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: mycolor,
                        ),
child: Center(
  child:   Text("Request an item",
  style: _const.raleway_SemiBold_white(height*0.02, FontWeight.w600),
  ),
),
                      ),
                    ),
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: mycolor,
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.question_mark,color: mycolor,size: 14.5),
                      ),
                    )
                  ],
                ),
              ),
              

            ],
          ),
        ),
      ),

    );
  }
}
