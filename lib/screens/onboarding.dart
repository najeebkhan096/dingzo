import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/screens/sellerAccountCreation.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Onboarding extends StatelessWidget {
  static const routename="Onboarding";
  Constants _const=Constants();

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.8,
        leadingWidth: width*0.3
        ,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Onboard",style: _const.manrope_regular263238(20, FontWeight.w800)),
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();

        }, icon: Icon(Icons.arrow_back_ios,color: Color(0xff3A4651),)),
        actions: [


        ],
      ),
      body: ListView(
        children: [



          SizedBox(height: height*0.1,),

          Center(child: Text("Onboard ",style: _const.poppin_black_rgb(40, FontWeight.w800),))
          ,
          SizedBox(height: height*0.05,),
          Center(
            child: Container(
              width: width*0.7,
              child: Text('You are almost done listing your first item!\n\nBy connecting to stripe, you are giving the buyers a way to pay you.',style: _const.poppin_BlackBold(15, FontWeight.w300),textAlign: TextAlign.center),),
          ),
          SizedBox(height: height*0.075,),


          InkWell(
            onTap: (){
              Navigator.of(context).pushNamed(AccountCreation.routename).then((value) {

                if(currentuser!.accountcreated==true){
                  Navigator.of(context).pop();
                }

              });
            },
            child: Center(
              child: Container(
                height: height*0.055,
                width: width*0.65,
                decoration: BoxDecoration(
                    color: blackbutton,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text("Connect stripe",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
              ),
            ),
          ),

        ],
      ),


    );
  }
}
