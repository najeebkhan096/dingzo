import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/widgets/Carsoul_Image.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Constants _const = Constants();

class MakeAnOffer extends StatelessWidget {
  List<String> textslist = ["Promote items", "Edit Item", "Delete Item"];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: height * 1.2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: height * 0.16,
                width: width * 1,
                decoration: BoxDecoration(
                    color: Color(0xffFFEA9D),
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(40))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          child: SvgPicture.asset(
                            'images/back.svg',
                            height: height * 0.025,
                          ),
                        ),
                        Text(""),
                        Image.asset(
                          'images/cart.png',
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.025,
              ),
              Container(
                height: height * 0.15,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: width * 0.025),
                      width: width * 0.6,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: AssetImage("images/radiant.png"),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: width * 0.025),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text("radiant.aestethic",
                                      style: _const.poppin_Regualr(
                                          15, FontWeight.w600)),
                                ),
                                Text("5 minutes ago",
                                    style: _const.poppin_Regualr(
                                        12, FontWeight.w500)),
                                Text("Varian : Cheese     Jumlah : 10",
                                    style: _const.poppin_light_brown(
                                        9, FontWeight.w600)),
                                Row(
                                  children: [
                                    Row(
                                      children: List.generate(
                                          5,
                                          (index) => Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                              )),
                                    ),
                                    Text(
                                      "5.0",
                                      style: _const.poppin_orange(
                                          17, FontWeight.w600),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: width * 0.35,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            child: Image.asset('images/like.png'),
                            backgroundColor: Color(0xffEFB546),
                          ),
                          SizedBox(
                            width: width * 0.025,
                          ),
                          Text(
                            "3 Likes",
                            style: _const.poppin_Regualr(15, FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.025,
              ),
              Container(
                color: Color(0xffFFEA9D),
                child: Column(
                  children: [
                    Carsoul_Image(sold: false,prodimages: []),
                    SizedBox(
                      height: height * 0.025,
                    ),
                    Text("Make an Offer",
                        style: _const.raleway_regular_darkbrown(
                            25, FontWeight.w700)),

                    SizedBox(
                      height: height * 0.015,
                    ),
                    Text("Your Offer",
                        style: _const.raleway_regular_darkbrown(
                            20, FontWeight.w700)),

                    SizedBox(
                      height: height * 0.025,
                    ),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: width*0.05,right: width*0.05,top: height*0.015,bottom:  height*0.015),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(child: Text("\$22",textAlign: TextAlign.center,style: _const.raleway_SemiBold_brown(15, FontWeight.w700),)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    Text("Your Message",
                        style: _const.raleway_regular_darkbrown(
                            20, FontWeight.w700))
                    ,
                    SizedBox(
                      height: height * 0.015,
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
                      child: Text("I want this",textAlign: TextAlign.center,style: _const.raleway_SemiBold_brown(15, FontWeight.w700),),
                    ),

                    SizedBox(
                      height: height * 0.015,
                    ),

                    Container(
                      height: height*0.06,
                      width: width*0.2,
                      margin: EdgeInsets.only(left: width*0.05),
                      padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                      decoration: BoxDecoration(
                          color: Color(0xffF4CB7D),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(child: Text("Done",style: _const.poppin_white(15, FontWeight.w700),)),
                    ),

                    SizedBox(
                      height: height * 0.025,
                    ),

                  ],
                ),
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
