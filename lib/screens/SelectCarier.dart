import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectCarier extends StatelessWidget {
  Constants _const=Constants();

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,

      body: ListView(
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

                    Text("Select Carier",style: _const.raleway_extrabold(27, FontWeight.w800),),
                    Container(
                      height: height*0.065,
                      width: width*0.25,
                      margin: EdgeInsets.only(left: width*0.05),
                      padding: EdgeInsets.only(left: width*0.025,right: width*0.025),
                      decoration: BoxDecoration(
                          color: Color(0xffEFB546),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(child: Text("My Saved Drafts (4)",style:_const.raleway_SemiBold_white(14, FontWeight.w600),textAlign: TextAlign.center,)),
                    ),
                  ],
                ),

                SizedBox(height: height*0.03,),

              ],
            ),

          ),

          SizedBox(height: height*0.025,),

          Column(
            children: List.generate(5, (index) => Container(
              margin: EdgeInsets.only(left: width*0.05,top: height*0.025),
              child: Row(
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (val){},

                  ),
                  Container(
                      height: height*0.1,
                      width: width*0.3,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage("images/service.png")
                          )
                      )),

                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('USPS First-Class',style: _const.raleway_SemiBold_9E772A(20, FontWeight.w600),),
                        SizedBox(height: height*0.01,),
                        Text("\$6.15      1-5 days",style: _const.raleway_SemiBold_F0BD5C(14, FontWeight.w600  ),)

                      ],
                    ),
                  )
                ],
              ),
            )),
          ),


        ],
      ),
      bottomNavigationBar: Home_Bottom_Navigation_Bar(),
    );
  }
}
