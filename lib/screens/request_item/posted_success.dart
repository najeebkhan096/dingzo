import 'package:dingzo/Database/product_database.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/hometesting.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/model/product.dart';
import 'package:dingzo/screens/checkout.dart';
import 'package:dingzo/screens/detailscreen.dart';
import 'package:dingzo/screens/home.dart';
import 'package:dingzo/screens/request_item/edit_request.dart';
import 'package:dingzo/screens/request_item/my_requests.dart';
import 'package:dingzo/screens/request_item/request_detail_Screen.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Posted_Success extends StatefulWidget {
  static const routename="Posted_Success";

  @override
  State<Posted_Success> createState() => _Posted_SuccessState();
}

class _Posted_SuccessState extends State<Posted_Success> {
  Constants _const=Constants();

Product ? currentproduct;

  Future<bool?>  _show_logout() async{
    bool ?status;
    await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: Color(0xff242C29),
          content:
          Text("Are you sure you want to delete your request?",
          style: _const.poppin_white(16, FontWeight.w600),
          ),

          actions: <Widget>[

            Container(
              decoration: BoxDecoration(
                  color: Color(0xff9A0303),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: TextButton(
                child: Text('Yes',style: TextStyle(color: Colors.white)),
                onPressed: () async {
                  await productdatabase.delete_product(proddocid: currentproduct!.product_doc_id).then((value) {
                    Navigator.pop(context,true);
                  });
                },
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width*0.05,),
            Container(
              decoration: BoxDecoration(
                  color: Color(0xff20C997),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: TextButton(
                child: Text('No',style: TextStyle(color: Colors.white),),
                onPressed: (){
                  Navigator.pop(context,false);
                },
              ),

            ),
            SizedBox(width: MediaQuery.of(context).size.width*0.1,),
          ],
        )
    ).then((value) {
      print("lund"+value.toString());
      status=value;

    });
    return status;
  }

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    currentproduct=ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.8,
        leadingWidth: width*0.3
        ,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Post a Request",style: _const.manrope_regular263238(20, FontWeight.w800)),

        actions: [


        ],
      ),
      body: ListView(
        children: [



          SizedBox(height: height*0.05,),
          Container(
            margin: EdgeInsets.only(left: width*0.15,right: width*0.15),
            child: Text("Your request has been posted!",style: _const.poppin_BlackBold(25, FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: height*0.05,),


          InkWell(
            onTap: (){
              Navigator.pushNamedAndRemoveUntil(context, HomeTesting.routename, (route) => false);
            },
            child: Container(
              height: height*0.055,
              width: width*1,
              margin: EdgeInsets.only(left: width*0.1,right: width*0.1),
              decoration: BoxDecoration(
                  color: blackbutton,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(child: Text("Home",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
            ),
          ),
          SizedBox(height: height*0.025,),

          InkWell(
            onTap: (){
              Navigator.of(context).pushNamed(
                  Request_Detail_Screen.routename,
                arguments: currentproduct
              );
            },
            child: Container(
              height: height*0.055,
              width: width*1,
              margin: EdgeInsets.only(left: width*0.1,right: width*0.1),
              decoration: BoxDecoration(
                  color: blackbutton,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(child: Text("View My Request",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
            ),
          ),
          SizedBox(height: height*0.025,),
          InkWell(
            onTap: (){
              Navigator.of(context).pushReplacementNamed(My_Request_Items.routename);
            },
            child: Container(
              height: height*0.055,
              width: width*1,
              margin: EdgeInsets.only(left: width*0.1,right: width*0.1),
              decoration: BoxDecoration(
                  color: blackbutton,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(child: Text("View All Requests",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
            ),
          ),
          SizedBox(height: height*0.025,),
          InkWell(
            onTap: (){
              Navigator.of(context).pushNamed(
                  Edit_Request_Item.routename,
                  arguments: currentproduct
              );
            },
            child: Container(
              height: height*0.055,
              width: width*1,
              margin: EdgeInsets.only(left: width*0.1,right: width*0.1),
              decoration: BoxDecoration(
                  color: blackbutton,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(child: Text("Edit My Request",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
            ),
          ),
          SizedBox(height: height*0.025,),
          InkWell(
            onTap: ()async{
            await _show_logout().then((value) {
    if(value==true){
      Navigator.of(context).pop();
    }
            });
            },
            child: Container(
              height: height*0.055,
              width: width*1,
              margin: EdgeInsets.only(left: width*0.1,right: width*0.1),
              decoration: BoxDecoration(
                  color: blackbutton,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(child: Text("Delete My Request",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
            ),
          ),
          SizedBox(height: height*0.025,),
        ],
      ),

    );
  }
}
