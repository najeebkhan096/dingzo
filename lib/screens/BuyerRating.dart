import 'package:dingzo/Database/database.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
class BuyerRating extends StatelessWidget {
  static const routename="BuyerRating";
  MyUser ? buyer;
  Constants _const=Constants();
double rating =1;
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    buyer=ModalRoute.of(context)!.settings.arguments as MyUser;
    return SafeArea(
      child: Scaffold(
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
                      InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            child:SvgPicture.asset('images/back.svg',height: height*0.025,)
                        ),
                      ),


                      Text("BuyerRating",style: _const.raleway_extrabold(27, FontWeight.w800)),
                      Image.asset('images/cart.png',)
                    ],
                  ),

                  SizedBox(height: height*0.03,),
                ],
              ),

            ),
            SizedBox(height: height*0.025,),



            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: width*0.4,

                    child: Text("How would you rate the buyer?",style: _const.raleway_regular_darkbrown(20, FontWeight.w600),textAlign: TextAlign.center,)),
              ],
            ),


            SizedBox(height: height*0.025,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: width*0.3,
                    height: height*0.12,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("images/radiant.png")
                      )
                    ),
                  ),
                ],
              ),

            SizedBox(height: height*0.025,),

        Center(
          child: RatingBar.builder(
            initialRating: 3,
            itemSize: 50,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rate) {
              print(rate);
              rating=rate;
            },
          ),
        ),
           // Row(
           //   mainAxisAlignment: MainAxisAlignment.center,
           //   children:  List.generate(5, (index) => Container(
           //       margin: EdgeInsets.only(left: width*0.02),
           //       child: SvgPicture.asset("images/Star 1.svg"))
           //   ),
           // ),


            SizedBox(height: height*0.05,),
Container(
    margin: EdgeInsets.only(left: width*0.05,right: width*0.05),

    child: Text("Do not rate if there is an issue with the order.All sales are final after you rate. If there are any issues with the order, click here!",style: _const.raleway_SemiBold_darkbrown(13, FontWeight.w600))),
            SizedBox(height: height*0.025,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: height*0.055,
                  width: width*0.2,
           decoration: BoxDecoration(
                      color: Color(0xffEFB546),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(child: Text("Help",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
                ),
              ],
            ),


            SizedBox(height: height*0.07,),


            InkWell(
              onTap: ()async{
                List<double> ? data=buyer!.rating;
                data!.add(rating);

                await database.update_rating(buyer!.doc!, data, context).then((value) {



                });
              },
              child: Container(
                height: height*0.055,
                width: width*1,
                margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
                decoration: BoxDecoration(
                    color: Color(0xffEFB546),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text("Rate Buyer",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
              ),
            ),

          ],
        ),

      ),
    );
  }
}
