import 'package:dingzo/Database/database.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/model/product.dart';
import 'package:dingzo/screens/checkout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartScreen extends StatefulWidget {
  static const routename="CartScreen";

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double    totalamount = 0;

Constants _const=Constants();

  calculatetotal() {
    totalamount = 0;
    cartitems.forEach((element) {
      setState(() {
        totalamount = totalamount + (element.price!);
      });
    });
  }
@override
  void initState() {
    // TODO: implement initState
  calculatetotal();
  super.initState();
  }
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

            InkWell(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Container(
                margin: EdgeInsets.only(left: width*0.05),
                child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white,
                    child:SvgPicture.asset('images/back.svg',height: height*0.025,)
                ),
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

           Column(
             children: List.generate(cartitems.length, (index) => Container(
               height: height*0.135,
               child: Row(
                 children: [
                   Expanded(
                     flex: 1,
                     child: Container(

                       child: Center(child:
                       Text("${index+1}".toString(),
                           style: _const.poppin_dark_brown(20, FontWeight.w500))
                       ),
                     ),
                   ),
                   Expanded(
                     flex: 7,
                     child: Container(

                       child: Row(
                         children: [
                           (cartitems[index].photos![0]==null || cartitems[index].photos![0].isEmpty)?
                           Container(
                             width: width*0.25,
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(20),
                                 color: Colors.indigo,
                             ),
                             child: Text("No Image"),
                           ):
                           Container(
                             width: width*0.25,
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(20),
                                 color: Colors.indigo,
                                 image: DecorationImage(
                                     fit: BoxFit.fill,
                                     image: NetworkImage(cartitems[index].photos![0].toString())
                                 )
                             ),
                           ),
                           Container(
                             margin: EdgeInsets.only(left: width*0.025),
                             child: Column(
mainAxisAlignment: MainAxisAlignment.center,
                               crossAxisAlignment: CrossAxisAlignment.start,

                               children: [

                                 Container(
                                   width: width*0.6,
                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                       Text(cartitems[index].title!.toString(),style: _const.poppin_dark_brown(12, FontWeight.w600)),
                                       Checkbox(
                                         value: cartitems[index].selected, onChanged: (val){
                                         print("value is "+ cartitems[index].selected.toString());

                                         setState(() {
                                             cartitems[index].selected=val;
                                           });


                                       },
                                         activeColor: Color(0xff8B6824),
                                         shape: RoundedRectangleBorder(
                                             borderRadius: BorderRadius.circular(4)
                                         ),
                                       )
                                     ],
                                   ),
                                 ),
                                 SizedBox(height: height*0.01,),
                                 Text(cartitems[index].description.toString(),
                                   style: _const.poppin_light_brown(9, FontWeight.w600),
                                 ),
                             SizedBox(height: height*0.01,),
                                 // Text("Tipe : Grosir      Harga : 15.000",
                                 //     style: _const.poppin_light_brown(9, FontWeight.w600)
                                 // ),
                                 // SizedBox(height: height*0.01,),
                                 // Text("Varian : Cheese     Jumlah : 10",  style: _const.poppin_light_brown(9, FontWeight.w600)),
                                 // SizedBox(height: height*0.01,),
                                 Container(
                                   width: width*0.5,
                                   child  : Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                       Text("Total",  style: _const.poppin_dark_brown(15, FontWeight.w600)),
                                       Text(cartitems[index].price.toString(),  style: _const.poppin_dark_brown(15, FontWeight.w600))
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

             ),),
           ),

           SizedBox(  height: height*0.025,),

           // Container(
           //   height: height*0.135,
           //   child: Row(
           //     children: [
           //       Expanded(
           //         flex: 1,
           //         child: Container(
           //
           //           child: Center(child: Text("1",style: _const.poppin_dark_brown(20, FontWeight.w500))),
           //         ),
           //       ),
           //       Expanded(
           //         flex: 7,
           //         child: Container(
           //
           //           child: Row(
           //             children: [
           //               Container(
           //                 width: width*0.25,
           //                 decoration: BoxDecoration(
           //                     borderRadius: BorderRadius.circular(20),
           //                     color: Colors.indigo,
           //                     image: DecorationImage(
           //                         fit: BoxFit.fill,
           //                         image: AssetImage("images/categ.png")
           //                     )
           //                 ),
           //               ),
           //               Container(
           //                 margin: EdgeInsets.only(left: width*0.025),
           //                 child: Column(
           //
           //                   crossAxisAlignment: CrossAxisAlignment.start,
           //
           //                   children: [
           //
           //                     Container(
           //                       width: width*0.6,
           //                       child: Row(
           //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
           //                         children: [
           //                           Text("Premium Scented Candle",style: _const.poppin_dark_brown(12, FontWeight.w600)),
           //                           Container(
           //                             height: height*0.001,
           //                             child: Checkbox(
           //                               value: false, onChanged: (val){},
           //                               activeColor: Color(0xff8B6824),
           //                               shape: RoundedRectangleBorder(
           //                                   borderRadius: BorderRadius.circular(4)
           //                               ),
           //                             ),
           //                           )
           //                         ],
           //                       ),
           //                     ),
           //                     SizedBox(height: height*0.01,),
           //                     Text("Tipe : Grosir      Harga : 15.000",
           //                         style: _const.poppin_light_brown(9, FontWeight.w600)
           //                     ),
           //                     SizedBox(height: height*0.01,),
           //                     Text("Varian : Cheese     Jumlah : 10",  style: _const.poppin_light_brown(9, FontWeight.w600)),
           //                     SizedBox(height: height*0.01,),
           //                     Container(
           //                       width: width*0.5,
           //                       child  : Row(
           //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
           //                         children: [
           //                           Text("Total",  style: _const.poppin_dark_brown(15, FontWeight.w600)),
           //                           Text("15000",  style: _const.poppin_dark_brown(15, FontWeight.w600))
           //                         ],
           //                       ),
           //                     ),
           //                   ],
           //                 ),
           //               ),
           //             ],
           //           ),
           //         ),
           //       ),
           //
           //     ],
           //   ),
           //
           // ),
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


                 Text("${cartitems.length.toString()}   Product",style:_const.poppin_orange(18, FontWeight.w700) ,)
                 ,

                 Text("Total :   ${totalamount}",style:_const.poppin_dark_brown(18, FontWeight.w700) ,)
                 ,
               ],
             ),
           ),

           SizedBox(  height: height*0.025,),

           InkWell(
             onTap: (){

               List<Product> newproducts=[];
               cartitems.forEach((element) {
                 if(element.selected!){
                   newproducts.add(element);
                 }
               });

               Navigator.of(context).pushNamed(Checkout.routename,arguments: newproducts).then((value) {
                 setState(() {

                 });
               });

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
