import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/screens/selling/OrderProcessed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Checkout extends StatelessWidget {
  static const routename="Checkout";
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
            height: height*0.18,
            width: width*1,
            decoration: BoxDecoration(
                color:  Color(0xffFFEA9D),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(40))
            ),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: width*0.05),
                  child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.white,
                      child:SvgPicture.asset('images/back.svg',height: height*0.025,)
                  ),
                ),
                SizedBox(width: width*0.2,),
                Text("Checkout",style:_const.raleway_extrabold(30, FontWeight.w800) ,)
              ],
            ),
          ),

          Container(
            height: height*0.1,
            width: width*1,
            decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(

                  children: [
                    Container(
                      margin: EdgeInsets.only(left: width*0.025),
                      child: Image.asset('images/Ellipse 13.png',height: height*0.1,),
                    ),
                    SizedBox(width: width*0.025,),
                    Text("radiant.aestethic",style:_const.poppin_dark_brown(15, FontWeight.w600) ,)
                    ,
                  ],
                ),


                Checkbox(value: false, onChanged: (val){},
                  activeColor: Color(0xff8B6824),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)
                  ),
                )
              ],
            ),
          ),

          Divider(),


          Container(
            height: height*0.1,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(

                    child: Center(child: Text("1",style: _const.poppin_dark_brown(20, FontWeight.w500))),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Container(

                    child: Row(
                      children: [
                        Container(
                          width: width*0.2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.indigo,
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage("images/categ.png")
                              )
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: width*0.025),
                          child: Column(

                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [

                              Text("Premium Scented Candle",style: _const.poppin_dark_brown(12, FontWeight.w600)),
                              SizedBox(height: height*0.02,),
                              Text("Price : 1500",style: _const.poppin_dark_brown(12, FontWeight.w600)),


                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),

          ),

          SizedBox(  height: height*0.025,),
         Container(
             margin: EdgeInsets.only(left: width*0.05),
             child: Text("Delivery : UPS First Class: \$4.00",style: _const.poppin_Regualr(15, FontWeight.w600),)),
          SizedBox(  height: height*0.015,),
          Container(
              margin: EdgeInsets.only(left: width*0.05),
              child: Text("Delivery : ETA 20 March - 30 march",style:TextStyle(
                  color: Colors.black54,
                  fontSize:12,
                  fontFamily: 'Poppins-SemiBold'
              ))),
          Divider(),

          Container(
              margin: EdgeInsets.only(left: width*0.05),
              child: Text("Order Summary",style: _const.poppin_Regualr(15, FontWeight.bold),)),

          SizedBox(  height: height*0.015,),

          Row(
            children: [
              Container(
                  width: width*0.25,
                  margin: EdgeInsets.only(left: width*0.05),
                  child: Text("Delivery to ",style:TextStyle(
                      color: Colors.black54,
                      fontSize:12,
                      fontFamily: 'Poppins-SemiBold'
                  ))),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(

                      child: Text("AZ ",style:TextStyle(
                          color: Colors.black,
                          fontSize:12,
                          fontFamily: 'Poppins-SemiBold'
                      ))),
                  Container(

                      child: Text("1480 Big Run road seaman ohio ",style:TextStyle(
                          color: Colors.black54,
                          fontSize:12,
                          fontFamily: 'Poppins-SemiBold'
                      ))),
                ],
              )
            ],
          ),

          SizedBox(  height: height*0.015,),


          Row(
            children: [
              Container(
                width: width*0.25,
                  margin: EdgeInsets.only(left: width*0.05),
                  child: Text("Card & Billing ",style:TextStyle(
                      color: Colors.black54,
                      fontSize:12,
                      fontFamily: 'Poppins-SemiBold'
                  ))),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(

                      child: Text("AZ ",style:TextStyle(
                          color: Colors.black,
                          fontSize:12,
                          fontFamily: 'Poppins-SemiBold'
                      ))),
                  Container(
                      child: Text("1480 Big Run road seaman ohio ",style:TextStyle(
                          color: Colors.black54,
                          fontSize:12,
                          fontFamily: 'Poppins-SemiBold'
                      ))),
                ],
              )
            ],
          ),

          Divider(),
          SizedBox(  height: height*0.05,),
Container(
 margin: EdgeInsets.only(left: width*0.2,right: width*0.05),

  height: height*0.25,
  child: Column(
    children: [
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
  Text("Subtitle ",style:TextStyle(
      color: Colors.black54,
      fontSize:12,
      fontFamily: 'Poppins-SemiBold'
  )),

  Text("\$5.0  ",style:TextStyle(
      color: Colors.black54,
      fontSize:12,
      fontFamily: 'Poppins-SemiBold'
  ))

],
),
      SizedBox(  height: height*0.01,),

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Shipping ",style:TextStyle(
              color: Colors.black54,
              fontSize:12,
              fontFamily: 'Poppins-SemiBold'
          )),

          Text("\$6.0  ",style:TextStyle(
              color: Colors.black54,
              fontSize:12,
              fontFamily: 'Poppins-SemiBold'
          ))

        ],
      ),
      SizedBox(  height: height*0.01,),

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Tax ",style:TextStyle(
              color: Colors.black54,
              fontSize:12,
              fontFamily: 'Poppins-SemiBold'
          )),

          Text("\$2.0  ",style:TextStyle(
              color: Colors.black54,
              fontSize:12,
              fontFamily: 'Poppins-SemiBold'
          ))

        ],
      ),
      SizedBox(  height: height*0.01,),

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Balance ",style:TextStyle(
              color: Colors.black54,
              fontSize:12,
              fontFamily: 'Poppins-SemiBold'
          )),

          Text("Apply ",style:TextStyle(
              color: Colors.black54,
              fontSize:12,
              fontFamily: 'Poppins-SemiBold'
          ))

        ],
      ),
      SizedBox(  height: height*0.01,),


      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("You Pay ",style:TextStyle(
              color: Colors.black54,
              fontSize:12,
              fontFamily: 'Poppins-SemiBold'
          )),

          Text("\$13.0 ",style:TextStyle(
              color: Colors.black54,
              fontSize:16,
              fontWeight: FontWeight.w700,
              fontFamily: 'Poppins-SemiBold'
          ))

        ],
      ),


    ],
  ),
),

          SizedBox(  height: height*0.025,),
          Container(
              margin: EdgeInsets.only(left: width*0.05,right: width*0.035),
              child: Text("Protect yourself against fruad scams which will resukt in loss of your money ",style:TextStyle(
                  color: Colors.black54,
                  fontSize:12,
                  fontFamily: 'Poppins-SemiBold'
              ),
              textAlign: TextAlign.center,
              )),
        Divider(),

          Container(
            margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(

                    child: Text("Total (item)",style:TextStyle(
                        color: Colors.black,
                        fontSize:12,
                        fontFamily: 'Poppins-SemiBold'
                    ))),
                Container(

                    child: Text("\$13.0 ",style:TextStyle(
                        color: Colors.black,
                        fontSize:12,
                        fontFamily: 'Poppins-SemiBold'
                    ))),
              ],
            ),
          ),

          SizedBox(  height: height*0.025,),
          InkWell(
            onTap: (){
              Navigator.of(context).pushNamed(OrderProcessed.routename);

            },
            child: Container(
              height: height*0.08,

              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,
                right: MediaQuery.of(context).size.width*0.05,),

              decoration: BoxDecoration(
                color: Color(0xffEFB546),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                    'Checkout',
                    style: _const.poppin_white(18, FontWeight.w600)
                ),
              ),
            ),
          ),
          SizedBox(  height: height*0.025,),

        ],
      ),
    );
  }
}
