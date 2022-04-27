import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  late TabController _controller;

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
    _controller = TabController(length: 2 ,vsync: this);
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
   _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,

        body: ListView(
          children: [
            Container(
              height: height*0.3,
              width: width*1,
              decoration: BoxDecoration(
                  color:  Color(0xffFFEA9D),
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(40))
              ),
              child: Column(

                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: width * 0.05,right: width * 0.05),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(

                          child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.white,
                              child:SvgPicture.asset('images/back.svg',height: height*0.025,)
                          ),
                        ),


                        InkWell(
                          onTap: (){
                            _showModalSheet(context);
                          },
                          child: Container(
                            child: Image.asset('images/cart.png'),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: height*0.025,),
                  Container(
                    margin: EdgeInsets.only(left: width * 0.025,right: width * 0.025),
                    width: width * 1,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage("images/Logo.png"),
                        ),

                        SizedBox(width: width*0.025,),
                        Container(
                          width: width*0.6,

                          margin: EdgeInsets.only(left: width * 0.025),
                          child: Row(

                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Text("radiant.aestethic",
                                        style: _const.raleway_SemiBold_9E772A(
                                            15, FontWeight.w600)),
                                  ),

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
                              ),
                              SizedBox(width: width*0.1,),
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xffEFB546),
                                    borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.only(left: width*0.025,right: width*0.025,bottom: height*0.01,top: height*0.01),
                                child:   Text("Follow",style: _const.raleway_regular_darkbrown(12, FontWeight.w600)),
                              ),
                            ],
                          ),
                        ),

                        Container(
                            height: height*0.05,
                            width: width*0.1,
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(15),
                             color: Color(0xffEFB546)
                           ),
                            child: Image.asset('images/Rectangle 1.png',height: height*0.5)),

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
                              Text("Follower",style: _const.raleway_medium_darkbrown(10, FontWeight.w500),)
                              ,Text("13",style: _const.raleway_SemiBold_9E772A(15, FontWeight.w600),)


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
                              Text("Rating",style: _const.raleway_medium_darkbrown(10, FontWeight.w500),)
                              ,Row(
                                children: [
                                  Image.asset('images/star.png'),
                                  Text(" 49",style: _const.raleway_SemiBold_9E772A(15, FontWeight.w600),),
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
                              Text("Following",style: _const.raleway_medium_darkbrown(10, FontWeight.w500),)
                              ,Text("13",style: _const.raleway_SemiBold_9E772A(15, FontWeight.w600),)


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
                              Text("Items",style: _const.raleway_medium_darkbrown(10, FontWeight.w500),)
                              ,Text("396",style: _const.raleway_SemiBold_9E772A(15, FontWeight.w600),)


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

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: width*0.5,
                  child: Text("Hi, this is my shop description",
                  style: TextStyle(
                    color: Color(0xff8C8C8C),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Raleway-SemiBold'

                  ),
                  ),
                ),
              ],
            ),


            SizedBox(height: height*0.025,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: width*0.5,
                  child: Text("Enjoy your shopping :)",textAlign: TextAlign.center,

            style: TextStyle(
                      color: Color(0xff8C8C8C),
                fontSize: 13,
                fontWeight: FontWeight.w600,
                fontFamily: 'Raleway-SemiBold'

            ),
                  ),
                ),
              ],
            ),




            SizedBox(height: height*0.025,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: width*0.6,
                  child: Text("100% Original ProductSupport environmentally friendly packaging",textAlign: TextAlign.center,     style: TextStyle(
                      color: Color(0xff8C8C8C),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Raleway-SemiBold'

                  ),),
                ),
              ],
            ),

            SizedBox(height: height*0.025,),

            Container(
             margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 tabindex==0?
                  Text("Products For Sale",style: _const.raleway_regular_darkbrown(20, FontWeight.w600),):
                 Text("Sold Products",style: _const.raleway_regular_darkbrown(20, FontWeight.w600),)

                  ,
                  TabBar(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    indicator: BoxDecoration(
                        color: Color(0xffEFB546),
                        borderRadius: BorderRadius.circular(10)),
                    labelColor: Colors.white,
                    onTap: (val){
                      print(val.toString());

                    setState(() {
                      tabindex=val;
                    });
                      },
                    unselectedLabelColor: Color(0xffEFB546),
                    indicatorColor: Color(0xff722BFF),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelStyle: _const.raleway_SemiBold_brown(12, FontWeight.w600),
                    isScrollable: true,
                    indicatorWeight: height * 0.002,
                    unselectedLabelStyle: _const.raleway_SemiBold_brown(12, FontWeight.w600),
                    controller: _controller,
                    tabs: [

                      Tab(
                        child: // Adobe XD layer: 'Emergency (6)' (text)
                        Text(
                          'For Sale',
                        ),
                      ),

                      Tab(
                        child: // Adobe XD layer: 'Second Opinion' (text)
                        Text(
                          'Sold',
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: height*0.025,),

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

                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(

                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: AssetImage('images/categ.png')
                                      )
                                  ),

                                ),
                                Positioned(
                                    right: width*0.01,
                                    top:height*0.01,
                                    child: Icon(Icons.favorite_border,size: 20,color: Colors.white,)),
                               tabindex==0?
                                   Text(""):

                                Positioned(
                                    left: 0,
                                    top:0,
                                    child: Container(
                                      width: width*0.1,
                                        height: height*0.04,
                                        decoration: BoxDecoration(
                                          color:Color(0xffEFB546),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Center(child: Text("Sold",style: _const.raleway_SemiBold_white(12, FontWeight.w600),)))
                                )
                              ],
                            ),
                            flex: 3,
                          ),
                          Expanded(

                            child: Container(
                              margin: EdgeInsets.only(left: width*0.025,right: width*0.025),
                              child: Text("\$20",style: _const.poppin_Regualr(15, FontWeight.w700),),
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

        bottomNavigationBar: Home_Bottom_Navigation_Bar(),
      ),
    );
  }
}
