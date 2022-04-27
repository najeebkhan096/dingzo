import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/widgets/CarsoulOFF.dart';
import 'package:dingzo/widgets/Carsoul_Image.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Constants _const=Constants();
class SoldSellerend extends StatelessWidget {

  List<String> textslist=["Buy it now","Make an offer","Add To Cart"];

  void _showModalSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          final height = MediaQuery.of(context).size.height;
          final width = MediaQuery.of(context).size.width;
          return new Container(

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

  void _showErrorDialog(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    showDialog(
        context: context,
        builder: (ctx) =>Container(
          color: Color(0xffFFEA9D),
          width: width*1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Sold 1 month ago",style: _const.raleway_regular_darkbrown(30, FontWeight.w700),)
            ],
          ),
        ));
  }
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Container(
          height: height*4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: height*0.15,
                width: width*1,
                decoration: BoxDecoration(
                    color:  Color(0xffFFEA9D),
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(40))
                ),
                child: Column(

                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(

                          child: SvgPicture.asset('images/back.svg',height: height*0.025,),
                        ),

                        Text(""),

                        Image.asset('images/cart.png',)
                      ],
                    ),

                    SizedBox(height: height*0.03,),



                  ],
                ),

              ),
              SizedBox(height: height*0.025,),
              Container(
                height: height*0.15,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: width*0.025),

                      width: width*0.6,

                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: AssetImage("images/radiant.png"),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: width*0.025),

                            child: Column(

                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [

                                Container(
                                  child: Text("radiant.aestethic",style: _const.poppin_Regualr(15, FontWeight.w600)),
                                ),

                                Text("5 minutes ago",
                                    style: _const.poppin_Regualr(12, FontWeight.w500)
                                ),

                                Text("Varian : Cheese     Jumlah : 10",  style: _const.poppin_light_brown(9, FontWeight.w600)),

                                Row(
                                  children: [
                                    Row(
                                      children: List.generate(5, (index) => Icon(Icons.star,color: Colors.yellow,)),
                                    ),
                                    Text("5.0",style: _const.poppin_orange(17, FontWeight.w600),)
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),

                    ),
                    Container(
                      width: width*0.35,

                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            child: Image.asset('images/like.png'),
                            backgroundColor: Color(0xffEFB546),
                          ),
                          SizedBox(width: width*0.025,),
                          Text("3 Likes",style: _const.poppin_Regualr(15, FontWeight.w600),)

                        ],
                      ),

                    ),
                  ],
                ),
              ),
              SizedBox(height: height*0.025,),
              Carsoul_Image(sold: true),
              SizedBox(height: height*0.025,),

              DetailsBox(context),
              SizedBox(height: height*0.025,),
              Container(
                margin: EdgeInsets.only(left: width * 0.025,right: width * 0.025),
                width: width * 1,
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
                                width: width*0.4,
                                child: Text("radiant.aestethic",
                                    style: _const.raleway_SemiBold_9E772A(
                                        15, FontWeight.w600)),
                              ),
                              //
                              Text(
                                "Illinois",
                                style: _const.raleway_medium_darkbrown(
                                    12, FontWeight.w500),
                              )
                            ],
                          ),

                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xff8B6824),
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
              SizedBox(height: height*0.02,),
              Divider(),
              SizedBox(height: height*0.02,),
              Container(
                height: height*0.055,
                width: width*1,
                margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

                padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                decoration: BoxDecoration(
                    color: Color(0xffEFB546),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text("Message Seller",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
              ),
              SizedBox(height: height*0.02,),
              Divider(),
              SizedBox(height: height*0.02,),
              Container(
                height: height*0.055,
                width: width*1,
                margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

                padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                decoration: BoxDecoration(
                    color: Color(0xffEFB546),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text("Sell Samilar Like This",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
              ),
              SizedBox(height: height*0.02,),
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
              Container(
                height: height*0.8,
                child:   GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: height*0.025,
                        crossAxisCount: 3,
                        mainAxisExtent: height*0.15

                    ),

                    itemCount: 20,
                    itemBuilder: (context,index){

                      return Container(
                        margin: EdgeInsets.only(left: width*0.025),
                        width: width*0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:Color(0xffEFB546),
                        ),
                        child: Column(
                          children: [
                            Expanded(

                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage('images/categ.png')
                                    )
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
                                    Text("\$20",style: _const.poppin_Regualr(12, FontWeight.w700),),
                                    Icon(Icons.favorite_border,size: 14,)
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
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Home_Bottom_Navigation_Bar(),
    );
  }
}
Widget DetailsBox(BuildContext context){
  final width=MediaQuery.of(context).size.width;
  final height=MediaQuery.of(context).size.height;
  return Container(
    margin: EdgeInsets.only(left: width*0.05,right:  width*0.05),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(),
        Text("Description",style: _const.poppin_dark_brown(22, FontWeight.w600),),
        SizedBox(height: height*0.015,),
        Text("I like my charger cable but I must sell it",style: _const.raleway_medium_darkbrown(15, FontWeight.w500)),
        SizedBox(height: height*0.015,),
        Divider(),

        Text("Details",style: _const.poppin_dark_brown(22, FontWeight.w600),),
        SizedBox(height: height*0.015,),
        Text("Condition: Good",style: _const.raleway_medium_darkbrown(15, FontWeight.w500)),
        SizedBox(height: height*0.015,),
        Text("Brand : Apple",style: _const.raleway_medium_darkbrown(15, FontWeight.w500)),
        SizedBox(height: height*0.015,),
        Text("Category : Electronic Charger",style: _const.raleway_medium_darkbrown(15, FontWeight.w500)),
        SizedBox(height: height*0.025,),
        Divider(),


        Text("Shipment",style: _const.poppin_dark_brown(22, FontWeight.w600),),
        SizedBox(height: height*0.015,),
        Text("Est Delivery: +6 days",style: _const.raleway_medium_darkbrown(15, FontWeight.w500)),
        SizedBox(height: height*0.015,),
        Text("Ships from: NJ",style: _const.raleway_medium_darkbrown(15, FontWeight.w500)),
        SizedBox(height: height*0.015,),
        Text("Shipment Price: Free",style: _const.raleway_medium_darkbrown(15, FontWeight.w500))

      ],
    ),
  );
}