import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dingzo/Database/SociaMediaDatabase.dart';
import 'package:dingzo/Database/database.dart';
import 'package:dingzo/Database/product_database.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/model/product.dart';
import 'package:dingzo/screens/checkout.dart';
import 'package:dingzo/screens/editprofile.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SocialProfile extends StatefulWidget {

    final String ?  DesiredID;
    SocialProfile(this.DesiredID);

    @override
  State<SocialProfile> createState() => _SocialProfileState();
}

class _SocialProfileState extends State<SocialProfile> with SingleTickerProviderStateMixin {
  late TabController _controller;
Database _database=Database();

int tabindex=0;
  void _showModalSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          final height = MediaQuery.of(context).size.height;
          final width = MediaQuery.of(context).size.width;
          return new Container(
height: height*0.4,
            color: Color(0xffFFEA9D),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.02,
                ),
                Text("Report Seller",
                    style: _const.raleway_regular_darkbrown(
                        25, FontWeight.w700)),

                SizedBox(
                  height: height * 0.02,
                ),
                Text("Reason",
                    style: _const.raleway_regular_darkbrown(
                        20, FontWeight.w700)),


                SizedBox(
                  height: height * 0.025,
                ),

                Container(
                  height: height*0.15,
                  width: width*1,
                  margin: EdgeInsets.only(left: width*0.05,right: width*0.05,),

                  padding: EdgeInsets.only(top: height*0.025,),

                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text("Seller has no intention of selling",textAlign: TextAlign.center,style: _const.raleway_SemiBold_brown(15, FontWeight.w700),),
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
                      child: Center(child: Text("Done",style:_const.raleway_SemiBold_white(12, FontWeight.w600),)),
                    ),
                  ),
                ),
              ],

            ),
          );
        }
    );
  }
  Constants _const=Constants();

  @override
  void initState() {
    // TODO: implement initState
    _controller = TabController(length: 4 ,vsync: this);
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
   _controller.dispose();
    super.dispose();
  }

 bool _fetched=false;
 MyUser ? _desireduser;

 @override
  Future<void> didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if(_fetched==false){
     _desireduser= await _database.fetchprofiledata(DesiredUserID: widget.DesiredID);
   if(_desireduser!=null){

            setState(() {
             _fetched=true;
            });
   }
    }
 }
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.8,
          leadingWidth: width*0.3
          ,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text("My Shop",style: _const.manrope_regular263238(20, FontWeight.w800)),
          leading: IconButton(onPressed: (){
            Navigator.of(context).pop();

          }, icon: Icon(Icons.arrow_back_ios,color: Color(0xff3A4651),)),

        ),
        body:_fetched?

        ListView(

          children: [


            Container(
            padding: EdgeInsets.only(top: height*0.025),
              width: width*1,

              decoration: BoxDecoration(
                  color:  Color(0xffF4F4F4),
             ),

              child: Column(

                mainAxisAlignment: MainAxisAlignment.end,
                children: [


                  Container(
                    margin: EdgeInsets.only(left: width * 0.075,right: width * 0.025),
                    width: width * 1,
                    child: Row(
                      children: [

                        if(_desireduser!.uid==currentuser!.uid)
                        InkWell(
                            onTap: (){
                              Navigator.of(context).pushNamed(EditProfile.routename);
                            },
                            child: Icon(Icons.edit_outlined,color: Color(0xff3A4651))),
                        SizedBox(width: width*0.025,),
                        ( _desireduser==null || _desireduser!.imageurl==null || _desireduser!.imageurl!.isEmpty)?
                        CircleAvatar(
                          radius: 35,
                          child: Text("No Image",style: TextStyle(fontSize: 10)),
                        ):
                        Container(
                          child: CircleAvatar(
                            radius: 32,
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage( _desireduser!.imageurl.toString()),
                          ),
                        ),
                        SizedBox(width: width*0.025,),
                        Container(
                          width: width*0.45,

                          child:   Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if(_desireduser!=null)

                                Text(_desireduser!.username.toString(),
                                    style:
                                    _const.manrope_regular263238(18, FontWeight.w700)),

                            ],
                          ),
                        ),
                        SizedBox(width: width*0.025,),
                        Expanded(
                          child: Container(

                            margin: EdgeInsets.only(left: width * 0.025),
                            child: Row(

                              children: [





               if(_desireduser!.uid!=currentuser!.uid)
                                InkWell(
                                  onTap: () async {
                                    SocialMediaDatabase _socialdatabase=SocialMediaDatabase();
                                   await  _socialdatabase.addfollowing(docid:user_docid,allfrdz: currentuser!.socialMedia!.following,
                                   newfriend: _desireduser
                                   ).then((value)async {
                                   await   _socialdatabase.addfollower(
                                     docid: _desireduser!.doc,
                                     newfriend: currentuser,
                                     allfrdz: currentuser!.socialMedia!.follower
                                   );
                                   });

                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: mycolor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.only(left: width*0.025,right: width*0.025,bottom: height*0.01,top: height*0.01),
                                    child:   Text("Follow",style: _const.raleway_SemiBold_white(12, FontWeight.w600)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Container(
                        //     height: height*0.05,
                        //     width: width*0.1,
                        //     decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(15),
                        //         color: Color(0xffEFB546)
                        //     ),
                        //     child: Image.asset('images/Rectangle 1.png',height: height*0.5)),

                      ],
                    ),
                  ),
                  SizedBox(height: height*0.025,),
                  Container(

                    child: Row(

                      children: [
                        Container(
                          margin: EdgeInsets.only(left: width*0.1),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Follower",style: _const.raleway_regular_333333(10, FontWeight.w500),)
                              ,Text(_desireduser!.socialMedia!.followers.toString(),style: _const.raleway_regular_333333(15, FontWeight.w600),)


                            ],
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(left: width*0.05),
                          height: height*0.05,
                          width: width*0.0025,
                          color: Color(0xffEFB546),
                        ),


                        Container(
                          margin: EdgeInsets.only(left: width*0.05),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Rating",style: _const.raleway_regular_333333(10, FontWeight.w500),)
                              ,Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  Text(_desireduser!.socialMedia!.rating.toString(),style: _const.raleway_regular_333333(15, FontWeight.w600),),
                                ],
                              )


                            ],
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(left: width*0.05),
                          height: height*0.05,
                          width: width*0.0025,
                          color: Color(0xffEFB546),
                        ),


                        Container(
                          margin: EdgeInsets.only(left: width*0.1),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Following",style: _const.raleway_regular_333333(10, FontWeight.w500),)
                              ,Text(_desireduser!.socialMedia!.followings.toString(),style: _const.raleway_regular_333333(15, FontWeight.w600),)


                            ],
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(left: width*0.05),
                          height: height*0.05,
                          width: width*0.0025,
                          color: Color(0xffEFB546),
                        ),

                        Container(
                          margin: EdgeInsets.only(left: width*0.1),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Items",style: _const.raleway_regular_333333(10, FontWeight.w500),)
                              ,Text(_desireduser!.socialMedia!.item.toString(),style: _const.raleway_regular_333333(15, FontWeight.w600),)


                            ],
                          ),
                        ),




                      ],
                    ),
                  ),

                  SizedBox(height: height*0.025,)
                ],
              ),

            ),

            SizedBox(height: height*0.025,),




            SizedBox(height: height*0.025,),
            Container(
                margin: EdgeInsets.only(left: width*0.05),
                child: Text("Products",style: _const.raleway_regular_333333(20, FontWeight.w600),)),

            Container(
              height: height*0.1,
              margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
              child: ListView(
              scrollDirection: Axis.horizontal,
               children: [
                  // tabindex==0?
                  // Text("Products For Sale",style: _const.raleway_regular_darkbrown(20, FontWeight.w600),):
                  // Text("Sold Products",style: _const.raleway_regular_darkbrown(20, FontWeight.w600),)
                  //
                  // ,
                  TabBar(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    indicator: BoxDecoration(
                        color: mycolor,
                        borderRadius: BorderRadius.circular(10)),
                    labelColor: Colors.white,
                    onTap: (val){
                      print(val.toString());

                      setState(() {
                        tabindex=val;
                      });
                    },
                    unselectedLabelColor: Color(0xff333333),
                    indicatorColor: mycolor,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelStyle: _const.raleway_regular_333333(12, FontWeight.w600),
                    isScrollable: true,
                    indicatorWeight: height * 0.002,
                    unselectedLabelStyle: _const.raleway_regular_333333(12, FontWeight.w600),
                    controller: _controller,
                    tabs: [
                      Tab(
                        child: // Adobe XD layer: 'Emergency (6)' (text)
                        Text(
                          'All',
                        ),
                      ),

                      Tab(
                        child: // Adobe XD layer: 'Emergency (6)' (text)
                        Text(
                          'For Sale',
                        ),
                      ),

                      Tab(
                        child: // Adobe XD layer: 'Second Opinion' (text)
                        Text(
                          'For Rent',
                        ),


                      ),
                      Tab(
                        child: // Adobe XD layer: 'Second Opinion' (text)
                        Text(
                          'Item Requests',
                        ),


                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: height*0.025,),

         Container(
           height: height*0.4,
           child: TabBarView(
               controller: _controller,
               children: [

                 FutureBuilder(
                     future: productdatabase.fetch_all_products_by_userid(desiredid: _desireduser!.uid),
                     builder: (context,AsyncSnapshot<List<Product>> snapshot){
                   return snapshot.connectionState==ConnectionState.waiting?
                       SpinKitRing(color: mycolor):
                   (snapshot.hasData  && snapshot.data!.length>0) ?
                   Column(
                     children: List.generate(snapshot.data!.length, (index) => Container(
                       margin: EdgeInsets.only(left: width*0.05,right: width*0.05,bottom: height*0.015),
                       child:   Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: [
                           Container(
                             width: width*0.32,
                             height: height*0.13,

                             child: Stack(
                               children: [
                                 Container(
                                   width: width*0.3,
                                   height: height*0.13,
                                   decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(10),
                                       image: DecorationImage(
                                           image: NetworkImage(snapshot.data![index].photos![0].toString())
                                           ,fit: BoxFit.cover
                                       )
                                   ),
                                 ),

                                 Positioned(
                                   left: width*0.024,
                                   top: height*0.015,
                                   child: Container(
                                     height: height*0.05,

                                     decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(10),
                                         color: Color(0xff8F8F8F)
                                     ),
                                     padding: EdgeInsets.only(left: 10,right: 10),

                                     child: Center(
                                       child: Text(
                                         snapshot.data![index].product_status=="inactive"?
                                         "Inactve":
                                         "Active"
                                         ,
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

                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Text(snapshot.data![index].title.toString(),style: _const.raleway_535F5B(18, FontWeight.w600)),
                                   SizedBox(height: height*0.0025,),
                                   Text("\$${snapshot.data![index].price}",style: _const.raleway_535F5B(13, FontWeight.w600)),
                                   SizedBox(height: height*0.0025,),

                                   snapshot.data![index].rent!?
                                   Text("item type: rent"
                                       ,style: _const.raleway_535F5B(13, FontWeight.w600)):
                                   Text("item type: Sell"
                                       ,style: _const.raleway_535F5B(13, FontWeight.w600)),



                                 ],
                               ),
                             ),
                           ),

                           Container(
                             width: width*0.28,
                             child: Column(

                               mainAxisAlignment: MainAxisAlignment.start,

                               children: [

                                 InkWell(
                                   onTap: (){

                                   },
                                   child: Container(
                                     height: height*0.04,
                                     width: width*0.21,
                                     padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                                     decoration: BoxDecoration(
                                         color: Color(0xff1A5A47),
                                         borderRadius: BorderRadius.circular(10)
                                     ),
                                     child: Center(child: Text("View Item",style:_const.raleway_SemiBold_white(10, FontWeight.w600),)),
                                   ),
                                 ),
                                 SizedBox(height: height*0.01,),
                                 Container(
                                   height: height*0.04,
                                   width: width*0.2,
                                   padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                                   decoration: BoxDecoration(
                                       color: Color(0xff1A5A47),
                                       borderRadius: BorderRadius.circular(10)
                                   ),
                                   child: Center(child: Text("More",style:_const.raleway_SemiBold_white(10, FontWeight.w600),)),
                                 ),



                               ],
                             ),
                           ),


                         ],
                       ),
                     )),
                   )
                           :Center(
                             child: Center(child: Text("No Data")),
                           );
                 }),

                 FutureBuilder(
                     future: productdatabase.fetch_ForSale_products_by_userid(desireduserid: _desireduser!.uid!),
                     builder: (context,AsyncSnapshot<List<Product>> snapshot){
                       return snapshot.connectionState==ConnectionState.waiting?
                       SpinKitRing(color: mycolor):
                       (snapshot.hasData  && snapshot.data!.length>0) ?
                       Column(
                         children: List.generate(snapshot.data!.length, (index) => Container(
                           margin: EdgeInsets.only(left: width*0.05,right: width*0.05,bottom: height*0.015),
                           child:   Row(
                             mainAxisAlignment: MainAxisAlignment.start,
                             children: [
                               Container(
                                 width: width*0.32,
                                 height: height*0.13,

                                 child: Stack(
                                   children: [
                                     Container(
                                       width: width*0.3,
                                       height: height*0.13,
                                       decoration: BoxDecoration(
                                           borderRadius: BorderRadius.circular(10),
                                           image: DecorationImage(
                                               image: NetworkImage(snapshot.data![index].photos![0].toString())
                                               ,fit: BoxFit.cover
                                           )
                                       ),
                                     ),

                                     Positioned(
                                       left: width*0.024,
                                       top: height*0.015,
                                       child: Container(
                                         height: height*0.05,

                                         decoration: BoxDecoration(
                                             borderRadius: BorderRadius.circular(10),
                                             color: Color(0xff8F8F8F)
                                         ),
                                         padding: EdgeInsets.only(left: 10,right: 10),

                                         child: Center(
                                           child: Text(
                                             snapshot.data![index].product_status=="inactive"?
                                             "Inactve":
                                             "Active"
                                             ,
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

                                   child: Column(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Text(snapshot.data![index].title.toString(),style: _const.raleway_535F5B(18, FontWeight.w600)),
                                       SizedBox(height: height*0.0025,),
                                       Text("\$${snapshot.data![index].price}",style: _const.raleway_535F5B(13, FontWeight.w600)),
                                       SizedBox(height: height*0.0025,),

                                       snapshot.data![index].rent!?
                                       Text("item type: rent"
                                           ,style: _const.raleway_535F5B(13, FontWeight.w600)):
                                       Text("item type: Sell"
                                           ,style: _const.raleway_535F5B(13, FontWeight.w600)),



                                     ],
                                   ),
                                 ),
                               ),

                               Container(
                                 width: width*0.28,
                                 child: Column(

                                   mainAxisAlignment: MainAxisAlignment.start,

                                   children: [

                                     InkWell(
                                       onTap: (){

                                       },
                                       child: Container(
                                         height: height*0.04,
                                         width: width*0.21,
                                         padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                                         decoration: BoxDecoration(
                                             color: Color(0xff1A5A47),
                                             borderRadius: BorderRadius.circular(10)
                                         ),
                                         child: Center(child: Text("View Item",style:_const.raleway_SemiBold_white(10, FontWeight.w600),)),
                                       ),
                                     ),
                                     SizedBox(height: height*0.01,),
                                     Container(
                                       height: height*0.04,
                                       width: width*0.2,
                                       padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                                       decoration: BoxDecoration(
                                           color: Color(0xff1A5A47),
                                           borderRadius: BorderRadius.circular(10)
                                       ),
                                       child: Center(child: Text("More",style:_const.raleway_SemiBold_white(10, FontWeight.w600),)),
                                     ),



                                   ],
                                 ),
                               ),


                             ],
                           ),
                         )),
                       )
                           :Center(
                         child: Center(child: Text("No Data")),
                       );
                     }),
                 FutureBuilder(
                     future: productdatabase.fetch_ForRent_products_by_userid(desireduserid: _desireduser!.uid!),
                     builder: (context,AsyncSnapshot<List<Product>> snapshot){
                       return snapshot.connectionState==ConnectionState.waiting?
                       SpinKitRing(color: mycolor):
                       (snapshot.hasData  && snapshot.data!.length>0) ?
                       Column(
                         children: List.generate(snapshot.data!.length, (index) => Container(
                           margin: EdgeInsets.only(left: width*0.05,right: width*0.05,bottom: height*0.015),
                           child:   Row(
                             mainAxisAlignment: MainAxisAlignment.start,
                             children: [
                               Container(
                                 width: width*0.32,
                                 height: height*0.13,

                                 child: Stack(
                                   children: [
                                     Container(
                                       width: width*0.3,
                                       height: height*0.13,
                                       decoration: BoxDecoration(
                                           borderRadius: BorderRadius.circular(10),
                                           image: DecorationImage(
                                               image: NetworkImage(snapshot.data![index].photos![0].toString())
                                               ,fit: BoxFit.cover
                                           )
                                       ),
                                     ),

                                     Positioned(
                                       left: width*0.024,
                                       top: height*0.015,
                                       child: Container(
                                         height: height*0.05,

                                         decoration: BoxDecoration(
                                             borderRadius: BorderRadius.circular(10),
                                             color: Color(0xff8F8F8F)
                                         ),
                                         padding: EdgeInsets.only(left: 10,right: 10),

                                         child: Center(
                                           child: Text(
                                             snapshot.data![index].product_status=="inactive"?
                                             "Inactve":
                                             "Active"
                                             ,
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

                                   child: Column(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Text(snapshot.data![index].title.toString(),style: _const.raleway_535F5B(18, FontWeight.w600)),
                                       SizedBox(height: height*0.0025,),
                                       Text("\$${snapshot.data![index].price}",style: _const.raleway_535F5B(13, FontWeight.w600)),
                                       SizedBox(height: height*0.0025,),

                                       snapshot.data![index].rent!?
                                       Text("item type: rent"
                                           ,style: _const.raleway_535F5B(13, FontWeight.w600)):
                                       Text("item type: Sell"
                                           ,style: _const.raleway_535F5B(13, FontWeight.w600)),



                                     ],
                                   ),
                                 ),
                               ),

                               Container(
                                 width: width*0.28,
                                 child: Column(

                                   mainAxisAlignment: MainAxisAlignment.start,

                                   children: [

                                     InkWell(
                                       onTap: (){

                                       },
                                       child: Container(
                                         height: height*0.04,
                                         width: width*0.21,
                                         padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                                         decoration: BoxDecoration(
                                             color: Color(0xff1A5A47),
                                             borderRadius: BorderRadius.circular(10)
                                         ),
                                         child: Center(child: Text("View Item",style:_const.raleway_SemiBold_white(10, FontWeight.w600),)),
                                       ),
                                     ),
                                     SizedBox(height: height*0.01,),
                                     Container(
                                       height: height*0.04,
                                       width: width*0.2,
                                       padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                                       decoration: BoxDecoration(
                                           color: Color(0xff1A5A47),
                                           borderRadius: BorderRadius.circular(10)
                                       ),
                                       child: Center(child: Text("More",style:_const.raleway_SemiBold_white(10, FontWeight.w600),)),
                                     ),



                                   ],
                                 ),
                               ),


                             ],
                           ),
                         )),
                       )
                           :Center(
                         child: Center(child: Text("No Data")),
                       );
                     }),

                 StreamBuilder(
                     stream: FirebaseFirestore.instance.collection('Products').snapshots(),
                     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                       if (snapshot.connectionState == ConnectionState.waiting)
                         return SpinKitCircle(
                           color: Colors.black,
                         );
                       if (!snapshot.hasData) return const Text('No Product');
                       List<Product> newCategories = [];
                       try{
                         List<QueryDocumentSnapshot?> mydocs = snapshot.data!.docs
                             .where((element) => (
                             (
                                 element['seller_id']==_desireduser!.uid
                                     &&
                                     element['product_status'] == "requested"
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
                                 height: height*0.4,
                                 width: width*1,

                                 child: Center(child: Text("No Product",style: _const.manrope_regular78909C(15, FontWeight.w700),))),
                           ],
                         ):
                         Column(
                           children: List.generate(newCategories.length, (index) => Container(
                             margin: EdgeInsets.only(left: width*0.05,right: width*0.05,bottom: height*0.015),
                             child:   Row(
                               mainAxisAlignment: MainAxisAlignment.start,
                               children: [
                                 Container(
                                   width: width*0.32,
                                   height: height*0.13,

                                   child: Stack(
                                     children: [
                                       Container(
                                         width: width*0.3,
                                         height: height*0.13,
                                         decoration: BoxDecoration(
                                             borderRadius: BorderRadius.circular(10),
                                             image: DecorationImage(
                                                 image: NetworkImage(newCategories[index].photos![0].toString())
                                                 ,fit: BoxFit.cover
                                             )
                                         ),
                                       ),

                                       Positioned(
                                         left: width*0.024,
                                         top: height*0.015,
                                         child: Container(
                                           height: height*0.05,

                                           decoration: BoxDecoration(
                                               borderRadius: BorderRadius.circular(10),
                                               color: Color(0xff8F8F8F)
                                           ),
                                           padding: EdgeInsets.only(left: 10,right: 10),

                                           child: Center(
                                             child: Text(
                                               newCategories[index].product_status=="inactive"?
                                               "Inactve":
                                               "Active"
                                               ,
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

                                     child: Column(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Text(newCategories[index].title.toString(),style: _const.raleway_535F5B(18, FontWeight.w600)),
                                         SizedBox(height: height*0.0025,),
                                         Text("\$${newCategories[index].price}",style: _const.raleway_535F5B(13, FontWeight.w600)),
                                         SizedBox(height: height*0.0025,),

                                         newCategories[index].rent!?
                                         Text("item type: rent"
                                             ,style: _const.raleway_535F5B(13, FontWeight.w600)):
                                         Text("item type: Sell"
                                             ,style: _const.raleway_535F5B(13, FontWeight.w600)),



                                       ],
                                     ),
                                   ),
                                 ),

                                 Container(
                                   width: width*0.28,
                                   child: Column(

                                     mainAxisAlignment: MainAxisAlignment.start,

                                     children: [

                                       InkWell(
                                         onTap: (){

                                         },
                                         child: Container(
                                           height: height*0.04,
                                           width: width*0.21,
                                           padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                                           decoration: BoxDecoration(
                                               color: Color(0xff1A5A47),
                                               borderRadius: BorderRadius.circular(10)
                                           ),
                                           child: Center(child: Text("View Item",style:_const.raleway_SemiBold_white(10, FontWeight.w600),)),
                                         ),
                                       ),
                                       SizedBox(height: height*0.01,),
                                       Container(
                                         height: height*0.04,
                                         width: width*0.2,
                                         padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                                         decoration: BoxDecoration(
                                             color: Color(0xff1A5A47),
                                             borderRadius: BorderRadius.circular(10)
                                         ),
                                         child: Center(child: Text("More",style:_const.raleway_SemiBold_white(10, FontWeight.w600),)),
                                       ),



                                     ],
                                   ),
                                 ),


                               ],
                             ),
                           )),
                         );
                     })


           ]),
         ),

          ],
        ):  SpinKitRotatingCircle(
          color: Colors.black,
          size: 50.0,
        ),


      ),
    );
  }
}
