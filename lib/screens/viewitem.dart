import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dingzo/Database/database.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/model/product.dart';
import 'package:dingzo/screens/cart.dart';
import 'package:dingzo/screens/checkout.dart';
import 'package:dingzo/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart' as Path;

import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';

class ViewItem extends StatefulWidget {
  static const routename = "ViewItem";

  @override
  State<ViewItem> createState() => _ViewItemState();
}

class _ViewItemState extends State<ViewItem> {
  Constants _const = Constants();


  Product ? currentproduct;
  @override
  Widget build(BuildContext context) {
    currentproduct=ModalRoute.of(context)!.settings.arguments as Product;

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.8,
        leadingWidth: width*0.3
        ,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("View Item",style: _const.manrope_regular263238(20, FontWeight.w800)),
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();

        }, icon: Icon(Icons.arrow_back_ios,color: Color(0xff3A4651),)),
        actions: [

          InkWell(
            onTap: (){
              Navigator.of(context).pushNamed(Checkout.routename);
            },
            child: Container(
              child: Image.asset('images/cart.png',color: Color(0xff263238)),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [

          SizedBox(
            height: height * 0.025,
          ),

          Container(

            child: Container(
                height: height * 0.055,
                width: width * 0.65,
                margin: EdgeInsets.only(left: width * 0.1,right: width*0.1),
                decoration: BoxDecoration(
                    color: mycolor,
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                    alignment: Alignment.center,
                    child: Text(currentproduct!.rent!?"Item for rent":"Item for Sale",style:  _const.raleway_SemiBold_white(16, FontWeight.w600))),
            ),
          ),
          SizedBox(
            height: height * 0.025,
          ),

          Row(children: [

            Container(
              margin: EdgeInsets.only(
                left: width * 0.05,
              ),
              height: height * 0.15,
              width: width * 0.28,
              decoration: BoxDecoration(
                  color: Color(0xffE7E7E7),
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(currentproduct!.photos![0]))),
            ),
            Container(
              margin: EdgeInsets.only(
                left: width * 0.05,
              ),
              height: height * 0.15,
              width: width * 0.28,
              decoration: BoxDecoration(
                  color: Color(0xffE7E7E7),
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(currentproduct!.photos![1]))),
            ),
            Container(
              margin: EdgeInsets.only(
                left: width * 0.05,
              ),
              height: height * 0.15,
              width: width * 0.28,
              decoration: BoxDecoration(
                  color: Color(0xffE7E7E7),
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(currentproduct!.photos![2]))),
            ),
          ]),

          SizedBox(
            height: height * 0.025,
          ),
          Column(children: [
            Container(
              margin: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
              padding: EdgeInsets.only(left: width * 0.03, right: width * 0.05),
              height: height * 0.065,
              width: width * 1,
              decoration: BoxDecoration(
                  color: Color(0xffF6F6F6),
                  borderRadius: BorderRadius.circular(15)),
              alignment: Alignment.centerLeft,
              child: Text(currentproduct!.title!)
            ),
            SizedBox(
              height: height * 0.025,
            ),






            Container(
              margin: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
                padding: EdgeInsets.only(left: width * 0.03, right: width * 0.05,top: height*0.025),
                height: height * 0.2,
                width: width * 1,
                decoration: BoxDecoration(
                    color: Color(0xffF6F6F6),
                    borderRadius: BorderRadius.circular(15)),
                alignment: Alignment.topLeft,
                child: Text(currentproduct!.description!)
            ),

            SizedBox(
              height: height * 0.025,
            ),
            Container(
                height: height * 0.055,
                width: width * 1,
                margin: EdgeInsets.only(left: width * 0.15,right: width*0.15),
                decoration: BoxDecoration(
                    color: mycolor,
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
    alignment: Alignment.center,
    child: Text(currentproduct!.category!,style:  _const.raleway_SemiBold_white(16, FontWeight.w600))),

    ),

            SizedBox(
              height: height * 0.025,
            ),

            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: width*0.1),
              child: Text("Price",
                style: _const.poppin_BlackBold(15, FontWeight.w400),
              ),
            ),

            SizedBox(
              height: height * 0.01,
            ),

            Container(
              margin: EdgeInsets.only(left: width * 0.1, right: width * 0.1),
              padding: EdgeInsets.only(left: width * 0.03),
              height: height * 0.06,
              width: width * 1,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromRGBO(41, 49, 47, 0.51)
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: Text(currentproduct!.price!.toString()),
            ),






            SizedBox(
              height: height * 0.025,
            ),




          ]),






          SizedBox(
            height: height * 0.05,
          ),
        ],
      ),

    );
  }
}
