import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopRattedSeller extends StatelessWidget {
  Constants _const = Constants();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            Container(
              height: height * 0.15,
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
                        child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            child: SvgPicture.asset(
                              'images/back.svg',
                              height: height * 0.025,
                            )),
                      ),
                      Text("TopRattedSeller",
                          style: _const.raleway_extrabold(27, FontWeight.w800)),
                   Text("")
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
            CircleAvatar(
              radius: 50,
              child: Image.asset('images/Subtract.png'),
              backgroundColor: Color.fromRGBO(239, 181, 70, 0.7),
            ),

            SizedBox(
              height: height * 0.035,
            ),
            Container(
                margin: EdgeInsets.only(left: width * 0.1, right: width * 0.1),
                child: Text(
                  'Top rated sellers are our most trusted sellers on Dingzo.',
                  style: _const.raleway_SemiBold_9E772A(15, FontWeight.w600),
                  textAlign: TextAlign.center,
                )),
            SizedBox(
              height: height * 0.025,
            ),
            Container(
                margin: EdgeInsets.only(left: width * 0.1, right: width * 0.1),
                child: Text(
                  'A top rated seller is a badge sellers can receive after completing 50 5 star sales in a row or 100 transactions with no returns and no cancelations and fast response times.',
                  style: _const.raleway_SemiBold_9E772A(15, FontWeight.w600),
                  textAlign: TextAlign.center,
                )),
            SizedBox(
              height: height * 0.025,
            ),
            Container(
                margin: EdgeInsets.only(left: width * 0.1, right: width * 0.1),
                child: Text(
                  'After all these requirements are met, Dingzo will evaluate the sellers account to see if theyare qualified to be a top rated seller.',
                  style: _const.raleway_SemiBold_9E772A(15, FontWeight.w600),
                  textAlign: TextAlign.center,
                )),
            SizedBox(
              height: height * 0.025,
            ),
            Container(
                margin: EdgeInsets.only(left: width * 0.1, right: width * 0.1),
                child: Text(
                  'A seller can both earn and lose their badge.',
                  style: _const.raleway_SemiBold_9E772A(15, FontWeight.w600),
                  textAlign: TextAlign.center,
                )),
            SizedBox(
              height: height * 0.025,
            ),
            Container(
                margin: EdgeInsets.only(left: width * 0.1, right: width * 0.1),
                child: Text(
                  'A seller will lose their badge if they don’t fufull the requirements above and have to start over to recieve the badge again',
                  style: _const.raleway_SemiBold_9E772A(15, FontWeight.w600),
                  textAlign: TextAlign.center,
                )),

            SizedBox(
              height: height * 0.05,
            ),
            Container(
              height: height*0.055,
              width: width*1,
              margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
              decoration: BoxDecoration(
                  color: Color(0xffEFB546),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(child: Text("Continue",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
            ),
            SizedBox(
              height: height * 0.05,
            ),
          ],
        ),
        bottomNavigationBar: Home_Bottom_Navigation_Bar(),
      ),
    );
  }
}
