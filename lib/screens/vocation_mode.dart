import 'package:dingzo/Database/database.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/screens/cart.dart';
import 'package:dingzo/screens/checkout.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VocationMode extends StatefulWidget {
  static const routename="VocationMode";

  @override
  State<VocationMode> createState() => _VocationModeState();
}

class _VocationModeState extends State<VocationMode> {
  Constants _const=Constants();

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.8,

          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text("Vocation Mode",style: _const.manrope_regular263238(20, FontWeight.w800)),
          leading: IconButton(onPressed: (){
            Navigator.of(context).pop();

          }, icon: Icon(Icons.arrow_back_ios,color: Color(0xff3A4651),)),
          actions: [

          ],
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: [


            SizedBox(height: height*0.05,),

            Container(
                margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
                child: Text("Vacation Mode hides your listings while you are away so you won’t get new orders.",style: _const.raleway_535F5B(20, FontWeight.w600),textAlign: TextAlign.center,)),

            SizedBox(height: height*0.05,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: ()async{
                    setState(() {
                      currentuser!.vocation=false;
                    });
                    await database.updatevocation(updateduser: currentuser);
                  },
                  child: Container(
                    height: height*0.055,
                    width: width*0.3,

                    decoration: BoxDecoration(
                        color:

                        // (currentuser!=null &&currentuser!.vocation! )?Color.fromRGBO(233, 219, 171, 0.44):

                        currentuser!.vocation!?
                        Color(0xffEBEBEB): mycolor
                        ,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(child: Text("OFF",
                      style:
                      !currentuser!.vocation!?
                      _const.poppin_white(17, FontWeight.w600)
                          : _const.raleway_rgb_textfield(17, FontWeight.w600)
                      ,textAlign: TextAlign.center,)

                    )
                  ),
                ),

                SizedBox(width: width*0.05,),

                InkWell(
                  onTap: ()async{
                    setState(() {
                      currentuser!.vocation=true;
                    });
                    await database.updatevocation(updateduser: currentuser);
                  },
                  child: Container(
                    height: height*0.055,
                    width: width*0.3,

                    decoration: BoxDecoration(
    color:
    currentuser!.vocation!?
    mycolor:
    Color(0xffEBEBEB),



                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(child: Text("ON",style:
                    currentuser!.vocation!?
                    _const.poppin_white(17, FontWeight.w600)
                      : _const.raleway_rgb_textfield(17, FontWeight.w600)
                      ,textAlign: TextAlign.center,)
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),

      ),
    );
  }
}
