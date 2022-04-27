import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/screens/SellItem.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:dingzo/wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
class ViewProfile extends StatefulWidget {
  static const routename="ViewProfile";
  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  int tabindex = 0;

  Constants _const = Constants();

  @override
  void initState() {
    // TODO: implement initState
    current_index=4;
    _controller = TabController(length: 2, vsync: this);
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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            height: height * 0.4,
            width: width * 1,
            decoration: BoxDecoration(
                color: Color(0xffFFEA9D),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(40))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin:
                      EdgeInsets.only(left: width * 0.05, right: width * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Container(
                        child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            child: SvgPicture.asset(
                              'images/back.svg',
                              height: height * 0.025,
                            )),
                      ),
                      Container(
                        child: Image.asset('images/cart.png'),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),

                (currentuser!.imageurl==null)?
      CircleAvatar(
      radius: 35,
      backgroundImage: NetworkImage(
          "https://tse1.mm.bing.net/th?id=OIP.1UGZ97SPWRWWtriWU0OIvgHaFj&pid=Api&P=0&w=209&h=157"),
    ):
                    Container(
                  child: CircleAvatar(
                    radius: 35,
                    child: CircleAvatar(
                        radius: 32,
                        backgroundColor: Colors.white,
                    backgroundImage: NetworkImage( currentuser!.imageurl.toString()),
                    ),
                  ),
                ),

                SizedBox(
                  height: height * 0.025,
                ),
                Text(currentuser!.username.toString(),
                    style:
                        _const.raleway_regular_darkbrown(20, FontWeight.w700)),

                SizedBox(
                  height: height * 0.01,
                ),
                Text("sharon_lorenza",
                    style: TextStyle(
                        color: Color(0xffC59943),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Raleway-Medium')),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      5, (index) => Image.asset("images/star.png")),
                ),
                SizedBox(
                  height: height * 0.013,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: width * 0.1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Follower",
                              style: _const.raleway_medium_darkbrown(
                                  10, FontWeight.w500),
                            ),
                            Text(
                              "13",
                              style: _const.raleway_SemiBold_9E772A(
                                  15, FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: width * 0.2, right: width * 0.2),
                        height: height * 0.05,
                        width: width * 0.0025,
                        color: Color(0xffEFB546),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Following",
                              style: _const.raleway_medium_darkbrown(
                                  10, FontWeight.w500),
                            ),
                            Text(
                              "13",
                              style: _const.raleway_SemiBold_9E772A(
                                  15, FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.025,
                )
              ],
            ),
          ),

          SizedBox(height: height*0.05,),

          Container(
            height: height*0.075,
            width: width*1,
            margin: EdgeInsets.only(left: width*0.1,right: width*0.1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xffEFB546),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Transfer funds",style:_const.raleway_regular_darkbrown(20, FontWeight.w700)),

               Text("\$200",style: _const.raleway_SemiBold_white(20, FontWeight.w700),)
              ],
            ),
          ),
          SizedBox(height: height*0.025,),
          Divider(),
          SizedBox(height: height*0.025,),
       Row(

         children: [
           Container(
             margin: EdgeInsets.only(left: width*0.1),
             child: Column(
               children: [
                 Image.asset('images/icons8-packing-96 1.png'),
                 SizedBox(height: height*0.01,),
                 Text("Buying",style: _const.raleway_SemiBold_darkbrown(11, FontWeight.w700),)
               ],
             ),
           ),
           InkWell(
             onTap: (){
               Navigator.of(context).pushNamed(SellItem.routename);
             },
             child: Container(
               margin: EdgeInsets.only(left: width*0.1),
               child: Column(
                 children: [
                   Image.asset('images/icons8-truck-96 1.png'),
                   SizedBox(height: height*0.01,),
                   Text("Selling",style: _const.raleway_SemiBold_darkbrown(11, FontWeight.w700),)
                 ],
               ),
             ),
           ),
           Container(
             margin: EdgeInsets.only(left: width*0.1),
             child: Column(
               children: [
                 Image.asset('images/icons8-packing-96 1.png'),
                 SizedBox(height: height*0.01,),
                 Text("Likes",style: _const.raleway_SemiBold_darkbrown(11, FontWeight.w700),)
               ],
             ),
           ),
           Container(
             margin: EdgeInsets.only(left: width*0.1),
             child: Column(
               children: [
                 Image.asset('images/icons8-packing-96 1.png'),
                 SizedBox(height: height*0.01,),
                 Text("View Shop",style: _const.raleway_SemiBold_darkbrown(11, FontWeight.w700),)
               ],
             ),
           ),
         ],
       ),
          SizedBox(height: height*0.025,),
          Divider(),
          SizedBox(height: height*0.025,),

          Container(
              margin: EdgeInsets.only(left: width*0.1),
              child: Text("Man",style: _const.raleway_medium_black(15, FontWeight.w700))),
          SizedBox(height: height*0.02,),
          Divider(),
          SizedBox(height: height*0.02,),

          Container(
              margin: EdgeInsets.only(left: width*0.1),
              child: Text("Help Center",style: _const.raleway_medium_black(15, FontWeight.w700))),
          SizedBox(height: height*0.02,),
          Divider(),
          SizedBox(height: height*0.02,),

          Container(
              margin: EdgeInsets.only(left: width*0.1),
              child: Text("Setting",style: _const.raleway_medium_black(15, FontWeight.w700))),
          SizedBox(height: height*0.02,),
          Divider(),
          SizedBox(height: height*0.02,),

          Container(
              margin: EdgeInsets.only(left: width*0.1),
              child: Text("Feedback",style: _const.raleway_medium_black(15, FontWeight.w700))),
          SizedBox(height: height*0.02,),
          Divider(),
          SizedBox(height: height*0.02,),

          InkWell(
            onTap: ()async{
              FirebaseAuth _auth=  FirebaseAuth.instance;
              await _auth.signOut().then((value) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Wrapper()),
                        (route)=>false
                );
              });

            },
            child: Container(
                margin: EdgeInsets.only(left: width*0.1),
                child: Text("Logout",style: _const.raleway_medium_black(15, FontWeight.w700))),
          ),

        ],
      ),
      bottomNavigationBar: Home_Bottom_Navigation_Bar(),
    );
  }
}
