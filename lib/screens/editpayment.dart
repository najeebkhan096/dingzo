import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditPayment extends StatelessWidget {
  Constants _const = Constants();
  void _showModalSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          final height = MediaQuery.of(context).size.height;
          final width = MediaQuery.of(context).size.width;
          return new Container(

            color: Color(0xffFFEA9D),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height*0.025,),
                Center(child: Text("Select Address",style: _const.raleway_regular_bold(25, FontWeight.w700),))
                ,
                SizedBox(height: height*0.025,),
                Container(
                  margin: EdgeInsets.only(left: width * 0.02),
                  child: Row(

                    children: [
                      Checkbox(

                        onChanged: (val){}, value: false,
                      ),
                      Image.asset('images/visa.png'),
                      SizedBox(width: width*0.02,),
                      Container(
                          width: width * 0.45,
                          child: Text(
                              "****3032 11/20 8043 Allsboro Rd Cherokee, Alabama, 35616",
                              style: _const.raleway_SemiBold_9E772A(
                                  15, FontWeight.w600))),
                      Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(233, 219, 171, 0.44),
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.only(
                            left: width * 0.03,
                            right: width * 0.03,
                            bottom: height * 0.01,
                            top: height * 0.01),
                        child: Text("Edit",
                            style: TextStyle(
                              color: Color.fromRGBO(158, 119, 42, 0.62),
                              fontSize: 17,
                              fontFamily: 'Raleway-SemiBold',
                            )),
                      ),
                    ],
                  ),
                ),


                SizedBox(height: height*0.045,),
                InkWell(
                  onTap: (){

                    Navigator.of(context).pop();
                  },
                  child: Center(
                    child: Container(
                      height: height*0.055,
                      width: width*1,
                      margin: EdgeInsets.only(left: width*0.1,right: width*0.1),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(238, 191, 24, 0.44),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(child: Text("Submit Address",style:_const.raleway_SemiBold_white(12, FontWeight.w600),)),
                    ),
                  ),
                ),
              ],

            ),
          );
        }
    );
  }

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
                      Text("EditPayment",
                          style: _const.raleway_extrabold(27, FontWeight.w800)),
                      Image.asset(
                        'images/cart.png',
                      )
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
            Center(
              child: Text("Select Payment Method",
                  style: _const.raleway_SemiBold_9E772A(20, FontWeight.w600)),
            ),
            SizedBox(
              height: height * 0.025,
            ),
            Container(
              margin: EdgeInsets.only(left: width * 0.02),
              child: Row(

                children: [
                  Checkbox(

                    onChanged: (val){}, value: false,
                  ),
                  Image.asset('images/visa.png'),
                  SizedBox(width: width*0.02,),
                  Container(
                      width: width * 0.45,
                      child: Text(
                          "****3032 11/20 8043 Allsboro Rd Cherokee, Alabama, 35616",
                          style: _const.raleway_SemiBold_9E772A(
                              15, FontWeight.w600))),
                  Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(233, 219, 171, 0.44),
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.only(
                        left: width * 0.03,
                        right: width * 0.03,
                        bottom: height * 0.01,
                        top: height * 0.01),
                    child: Text("Edit",
                        style: TextStyle(
                          color: Color.fromRGBO(158, 119, 42, 0.62),
                          fontSize: 17,
                          fontFamily: 'Raleway-SemiBold',
                        )),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: height * 0.025,
            ),
            Divider(),

            SizedBox(
              height: height * 0.025,
            ),

            Container(
              height: height*0.055,
              width: width*1,
              margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

              padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
              decoration: BoxDecoration(
                  color: Color(0xffEFB546),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(child: Text("Add New Card",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
            ),
            SizedBox(
              height: height * 0.025,
            ),

            Container(
              width: width * 1,
              color: Color(0xffFFEA9D),
              padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
              child: Column(
                children: [


                  SizedBox(height: height*0.025,),
                  Text(
                    "Edit Payment",
                    style:
                    _const.raleway_regular_bold(25, FontWeight.w700),
                  ),
                  SizedBox(height: height*0.025,),


                  Row(
                    children: [
                      Container(
                        width: width * 0.3,
                        child: Text("Full Name",
                            style: _const.raleway_regular_bold(
                                19, FontWeight.w700)),
                      ),
                      Container(
                        width: width * 0.285,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        alignment: Alignment.center,
                        child: Text("First ",
                            style: _const.raleway_SemiBold_brown(
                                15, FontWeight.w600)),
                        height: height * 0.055,
                      ),
                      SizedBox(width: width*0.025,),
                      Container(
                        width: width * 0.285,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        alignment: Alignment.center,
                        child: Text("last ",
                            style: _const.raleway_SemiBold_brown(
                                15, FontWeight.w600)),
                        height: height * 0.055,
                      )
                    ],
                  ),

                  SizedBox(height: height*0.025,),
                  Row(
                    children: [
                      Container(
                        width: width * 0.35,
                        child: Text("Card Number :",
                            style: _const.raleway_regular_bold(
                                19, FontWeight.w700)),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: width*0.05),
                        width: width * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        alignment: Alignment.center,
                        child: Text("Address 1 ",
                            style: _const.raleway_SemiBold_brown(
                                15, FontWeight.w600)),
                        height: height * 0.055,
                      )
                    ],
                  ),

                  SizedBox(height: height*0.025,),
                  Row(
                    children: [
                      Container(
                        width: width * 0.4,
                        child: Text("Expiration Date :",
                            style: _const.raleway_regular_bold(
                                19, FontWeight.w700)),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: width*0.025),

                        width: width * 0.45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        alignment: Alignment.center,
                        child: Text("Address 2 ",
                            style: _const.raleway_SemiBold_brown(
                                15, FontWeight.w600)),
                        height: height * 0.055,
                      )
                    ],
                  ),

                  SizedBox(height: height*0.025,),
                  Row(
                    children: [
                      Container(
                        width: width * 0.3,
                        child: Text("CCV:",
                            style: _const.raleway_regular_bold(
                                19, FontWeight.w700)),
                      ),
                      Container(
                        width: width * 0.6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        alignment: Alignment.center,
                        child: Text("City : ",
                            style: _const.raleway_SemiBold_brown(
                                15, FontWeight.w600)),
                        height: height * 0.055,
                      )
                    ],
                  ),

                  SizedBox(height: height*0.025,),
                  Row(
                    children: [
                      Container(
                        width: width * 0.3,
                        child: Text("Address :",
                            style: _const.raleway_regular_bold(
                                19, FontWeight.w700)),
                      ),
                      Container(
                        height: height*0.055,
                        width: width*0.45,
                        margin: EdgeInsets.only(left: width*0.02),
                       decoration: BoxDecoration(
                            color: Color(0xffEFB546),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            CircleAvatar(
                             radius: 12,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.add,size: 14,color: Color(0xffEFB546)),
                            ),


SizedBox(width: width*0.025,),

                            Text("Add Address",style:_const.raleway_SemiBold_white(16, FontWeight.w600),),

                          ],
                        ),
                      ),

                    ],
                  ),


                  SizedBox(height: height*0.05,),

                  InkWell(
                    onTap: (){
                      _showModalSheet(context);
                    },
                    child: Container(
                      height: height*0.055,
                      width: width*1,
                      margin: EdgeInsets.only(left: width*0.1,right: width*0.1),
                      padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                      decoration: BoxDecoration(
                          color: Color(0xffEFB546),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(child: Text("Add New Card",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
                    ),
                  ),
                  SizedBox(height: height*0.05,),

                ],
              ),
            ),

          ],
        ),
        bottomNavigationBar: Home_Bottom_Navigation_Bar(),
      ),
    );
  }
}