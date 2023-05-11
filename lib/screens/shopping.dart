import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Shopping extends StatelessWidget {

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

                    Text("Shopping",style: _const.raleway_extrabold(27, FontWeight.w800),),
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

          Center(child: Text("Item Weight (Required)",style: _const.raleway_SemiBold_9E772A(20, FontWeight.w600),))
          ,SizedBox(height: height*0.025,),

Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
        Container(

      width: width*0.6,

      child: Text("Make sure the weigt is correct to avoid extra shipping charges.",style: _const.raleway_SemiBold_F0BD5C(14, FontWeight.w600)),

    ),
  ],
),
          SizedBox(height: height*0.025,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: width*0.35,
                height: height*0.055,
                decoration: BoxDecoration(
                  color: Color(0xffE7E7E7),
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
              SizedBox(width: width*0.025,),
              Text('Ib',style: _const.raleway_SemiBold_9E772A(20, FontWeight.w600),)
            ],
          ),
          SizedBox(height: height*0.025,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: width*0.35,
                height: height*0.055,
                decoration: BoxDecoration(
                    color: Color(0xffE7E7E7),
                    borderRadius: BorderRadius.circular(10)
                ),
              ),
              SizedBox(width: width*0.025,),
              Text('Oz',style: _const.raleway_SemiBold_9E772A(20, FontWeight.w600),)
            ],
          ),






          SizedBox(height: height*0.025,),

          Center(child: Text("Item Size (Optional)",style: _const.raleway_SemiBold_9E772A(20, FontWeight.w600),))
          ,
          SizedBox(height: height*0.025,),

          Row(

            children: [
              
              Container(
                margin: EdgeInsets.only(left: width*0.05),
                width: width*0.35,
              child: Text("Item Length",style: _const.raleway_SemiBold_9E772A(20, FontWeight.w600)),
              ),
              
              Container(
                width: width*0.35,
                height: height*0.055,
                decoration: BoxDecoration(
                    color: Color(0xffE7E7E7),
                    borderRadius: BorderRadius.circular(10)
                ),
              ),
              SizedBox(width: width*0.025,),
              Text('Ib',style: _const.raleway_SemiBold_9E772A(20, FontWeight.w600),)
            ],
          ),
          SizedBox(height: height*0.025,),

          Row(

            children: [

              Container(
                margin: EdgeInsets.only(left: width*0.05),
                width: width*0.35,
                child: Text("Item Width",style: _const.raleway_SemiBold_9E772A(20, FontWeight.w600)),
              ),

              Container(
                width: width*0.35,
                height: height*0.055,
                decoration: BoxDecoration(
                    color: Color(0xffE7E7E7),
                    borderRadius: BorderRadius.circular(10)
                ),
              ),
              SizedBox(width: width*0.025,),
              Text('Ib',style: _const.raleway_SemiBold_9E772A(20, FontWeight.w600),)
            ],
          ),


          SizedBox(height: height*0.025,),

          Row(

            children: [

              Container(
                margin: EdgeInsets.only(left: width*0.05),
                width: width*0.35,
                child: Text("Item Height",style: _const.raleway_SemiBold_9E772A(20, FontWeight.w600)),
              ),

              Container(
                width: width*0.35,
                height: height*0.055,
                decoration: BoxDecoration(
                    color: Color(0xffE7E7E7),
                    borderRadius: BorderRadius.circular(10)
                ),
              ),
              SizedBox(width: width*0.025,),
              Text('Ib',style: _const.raleway_SemiBold_9E772A(20, FontWeight.w600),)
            ],
          ),

          SizedBox(height: height*0.025,),

          Divider(),

          SizedBox(height: height*0.025,),
          Container(
            height: height*0.055,
            width: width*1,
            margin: EdgeInsets.only(left: width*0.1,right: width*0.1),
            decoration: BoxDecoration(
                color: Color(0xffEFB546),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Center(child: Text("Continue to Carrier",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
          ),

        ],
      ),

    );
  }
}
