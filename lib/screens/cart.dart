import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/screens/checkout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartScreen extends StatelessWidget {
  static const routename="CartScreen";
Constants _const=Constants();

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return Scaffold(
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
            SizedBox(width: width*0.23,),
            Text("Cart",style:_const.poppin_orange(30, FontWeight.w800) ,)
          ],
        ),
        ),
           Row(
             mainAxisAlignment: MainAxisAlignment.end,
             children: [
               Text("Choose All"),
               Checkbox(value: false, onChanged: (val){},
               activeColor: Color(0xff8B6824),
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(4)
                 ),
               )
             ],
           ),

           Container(
             height: height*0.1,
             width: width*1,
             decoration: BoxDecoration(
                 color:  Color(0xffFFEA9D),
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
SizedBox(  height: height*0.025,),

           Container(
             height: height*0.135,
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
                           width: width*0.25,
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(20),
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

                             Container(
                        width: width*0.6,
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Text("Premium Scented Candle",style: _const.poppin_dark_brown(12, FontWeight.w600)),
                                   Container(
                                     height: height*0.001,
                                     child: Checkbox(
                                       value: false, onChanged: (val){},
                                       activeColor: Color(0xff8B6824),
                                       shape: RoundedRectangleBorder(
                                           borderRadius: BorderRadius.circular(4)
                                       ),
                                     ),
                                   )
                                 ],
                               ),
                             ),
                             SizedBox(height: height*0.01,),
                             Text("Tipe : Grosir      Harga : 15.000",
                                 style: _const.poppin_light_brown(9, FontWeight.w600)
                             ),
                             SizedBox(height: height*0.01,),
                             Text("Varian : Cheese     Jumlah : 10",  style: _const.poppin_light_brown(9, FontWeight.w600)),
                             SizedBox(height: height*0.01,),
                             Container(
                               width: width*0.5,
                               child  : Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Text("Total",  style: _const.poppin_dark_brown(15, FontWeight.w600)),
                                   Text("15000",  style: _const.poppin_dark_brown(15, FontWeight.w600))
                                 ],
                               ),
                             ),
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
             height: height*0.135,
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
                           width: width*0.25,
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(20),
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

                               Container(
                                 width: width*0.6,
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Text("Premium Scented Candle",style: _const.poppin_dark_brown(12, FontWeight.w600)),
                                     Container(
                                       height: height*0.001,
                                       child: Checkbox(
                                         value: false, onChanged: (val){},
                                         activeColor: Color(0xff8B6824),
                                         shape: RoundedRectangleBorder(
                                             borderRadius: BorderRadius.circular(4)
                                         ),
                                       ),
                                     )
                                   ],
                                 ),
                               ),
                               SizedBox(height: height*0.01,),
                               Text("Tipe : Grosir      Harga : 15.000",
                                   style: _const.poppin_light_brown(9, FontWeight.w600)
                               ),
                               SizedBox(height: height*0.01,),
                               Text("Varian : Cheese     Jumlah : 10",  style: _const.poppin_light_brown(9, FontWeight.w600)),
                               SizedBox(height: height*0.01,),
                               Container(
                                 width: width*0.5,
                                 child  : Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Text("Total",  style: _const.poppin_dark_brown(15, FontWeight.w600)),
                                     Text("15000",  style: _const.poppin_dark_brown(15, FontWeight.w600))
                                   ],
                                 ),
                               ),
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
             height: height*0.1,
             width: width*1,
             padding: EdgeInsets.only(left: width*0.025),
             decoration: BoxDecoration(
                 color:  Color(0xffF9F6EC),
                 borderRadius: BorderRadius.circular(15)),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [


                 Text("0   Product",style:_const.poppin_orange(18, FontWeight.w700) ,)
                 ,

                 Text("Total :   0",style:_const.poppin_dark_brown(18, FontWeight.w700) ,)
                 ,
               ],
             ),
           ),
           SizedBox(  height: height*0.025,),
           InkWell(
             onTap: (){
               Navigator.of(context).pushNamed(Checkout.routename);

             },
             child: Container(
               height: height*0.08,

               margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.025,right: MediaQuery.of(context).size.width*0.025,),

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
