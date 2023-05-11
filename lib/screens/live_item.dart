import 'package:dingzo/constants.dart';
import 'package:dingzo/hometesting.dart';
import 'package:dingzo/model/product.dart';
import 'package:dingzo/screens/SellItem.dart';
import 'package:dingzo/screens/home.dart';
import 'package:dingzo/screens/request_item/request_detail_Screen.dart';
import 'package:flutter/material.dart';
class LiveItem extends StatelessWidget {
  static const routename="LiveItem";
Constants _cont=Constants();
Product ? _prod;
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    _prod=ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(

      body: Container(
        height: height*1,
        width: width*1,
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: height*0.2,),

            Container(
             width: width*0.7,
              child: Text("Your Item Is Live!",
              style: _cont.poppin_BlackBold(40, FontWeight.w600),
              textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: height*0.075,),
InkWell(
  onTap: (){
    Navigator.of(context).pushNamed(SellItem.routename,arguments:_prod );
  },
  child:   Container(

    width: width*0.7,

    height: height*0.06,

    decoration: BoxDecoration(

      borderRadius: BorderRadius.circular(10),

      color: Color(0xff1A5A47)

    ),

    child: Center(

      child: Text('Post Another Item',

      style: _cont.poppin_white(16, FontWeight.w600),

      ),

    ),

  ),
),
            SizedBox(height: height*0.025,),


            InkWell(
              onTap: (){
                Navigator.of(context).pushNamed(Request_Detail_Screen.routename,arguments: _prod);
              },
              child: Container(
                width: width*0.7,
                height: height*0.06,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xff242C29)
                ),
                child: Center(
                  child: Text('View item',
                    style: _cont.poppin_white(16, FontWeight.w600),
                  ),
                ),
              ),
            ),
            SizedBox(height: height*0.025,),
            InkWell(
              onTap: (){
                Navigator.of(context).pushNamedAndRemoveUntil(HomeTesting.routename, (route) => false);
              },
              child: Container(
                width: width*0.7,
                height: height*0.06,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xff242C29)
                ),
                child: Center(
                  child: Text('Return to home',
                    style: _cont.poppin_white(16, FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
