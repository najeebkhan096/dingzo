import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Following extends StatelessWidget {
  Constants _const=Constants();

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

                          child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.white,
                              child:SvgPicture.asset('images/back.svg',height: height*0.025,)
                          ),
                        ),

                        Text('Following',style: _const.raleway_extrabold(30, FontWeight.w800),),
                        Container(

                          child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Color(0xffEFB546),
                              child:Text("2",style: TextStyle(color: Colors.white),)
                          ),
                        ),

                      ],
                    ),

                    SizedBox(height: height*0.03,),
                  ],
                ),

              ),

              SizedBox(height: height*0.025,),

              Column(
                children: List.generate(4, (index) =>   Container(
                  margin: EdgeInsets.only(left: width * 0.05,right: width * 0.025,top: height*0.025),
                  width: width * 1,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
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
                                  child: Text("Radient Sello",
                                      style: _const.raleway_medium_black(
                                          17, FontWeight.w600)),
                                ),

                                SizedBox(height: height*0.02,),

                                Text(
                                  "radient.asdr",
                                  style: _const.raleway_medium_black(
                                      12, FontWeight.w500),
                                )
                              ],
                            ),

                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:  Color(0xffEFB546),
                              ),
                              padding: EdgeInsets.only(left: width*0.03,right: width*0.03,bottom: height*0.01,top: height*0.01),
                              child:   Text("Follow",style: _const.raleway_regular_darkbrown(15, FontWeight.w600)),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),),
              ),

            ],
          ),
        ),
      ),

    );
  }
}
