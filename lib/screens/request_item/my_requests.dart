import 'package:dingzo/model/product.dart';
import 'package:dingzo/screens/edititem.dart';
import 'package:dingzo/screens/onboarding.dart';
import 'package:dingzo/screens/request_item/cancel.dart';
import 'package:dingzo/screens/request_item/in_progress.dart';
import 'package:dingzo/screens/request_item/request_detail_Screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/screens/SellItem.dart';
import 'package:dingzo/screens/editaddress.dart';
import 'package:dingzo/screens/request_item/request_item.dart';
import 'package:dingzo/screens/sellerAccountCreation.dart';

import 'package:dingzo/screens/selling/SellingHome/SellingCompleted.dart';

import 'package:dingzo/screens/selling/SellingHome/SellinginProgress.dart';
import 'package:dingzo/screens/selling/SellingHome/listing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';


class My_Request_Items extends StatefulWidget {

  static const routename = "My_Request_Items";
  @override
  _My_Request_ItemsState createState() => _My_Request_ItemsState();
}

class _My_Request_ItemsState extends State<My_Request_Items>  with SingleTickerProviderStateMixin{
  @override
  Color active = Colors.green;
  Color inactive = Color(0xffF9F9F9);
  bool isrecieved = true;

  Constants _const=Constants();

  @override

  late TabController _controller;


  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    _controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
    _controller.dispose();
  }

  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0.8,
              leadingWidth: width*0.3
              ,
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Text("My Request",style: _const.manrope_regular263238(20, FontWeight.w800)),
              leading: IconButton(onPressed: (){
                Navigator.of(context).pop();

              }, icon: Icon(Icons.arrow_back_ios,color: Color(0xff3A4651),)),

            ),
            body: SingleChildScrollView(
              child: Container(
                height: height*1,
                child: Column(

                  children: [

                    SizedBox(height: height*0.05,),

                    InkWell(
                      onTap: (){

                        if(currentuser!.home_address!.length==0)
                          Navigator.of(context).pushNamed(EditAddress.routename);
                        else if(currentuser!.accountcreated==false)
                          Navigator.of(context).pushNamed(Onboarding.routename);
                        else
                          Navigator.of(context).pushNamed(Post_Request_Item.routename);


                      },
                      child: Container(
                        height: height*0.075,
                        width: width*0.65,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xff1A5A47)
                        ),
                        child: Center(
                          child: Text("Post a New Request",
                            style: _const.poppin_white(15, FontWeight.w600),
                          ),
                        ),
                      ),
                    ),

                    Request_in_progress(),
                  ],
                ),
              ),
            ),

          ),
        ));
  }
}
