import 'package:dingzo/Database/SociaMediaDatabase.dart';
import 'package:dingzo/Database/database.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/model/chat_reciver.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/model/product.dart';
import 'package:dingzo/screens/cart.dart';
import 'package:dingzo/screens/chat/chat.dart';
import 'package:dingzo/screens/checkout.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HelpCenter extends StatelessWidget {
  static const routename="HelpCenter";
  Constants _const=Constants();
  List categ=[
    {
      'image':"images/icons8-shirt-64 1.png",
      'title':"Shirts"
    },
    {
      'image':"images/hobby icon.png",
      'title':"Hobby"
    },
    {
      'image':"images/beauty care logo.png",
      'title':"Beauty"
    },
    {
      'image':"images/icons8-lamp-96 1.png",
      'title':"Rooms"
    },
    {
      'image':"images/icons8-lamp-96 1.png",
      'title':"Rooms"
    },

  ];
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.8,

        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Help Center",style: _const.manrope_regular263238(20, FontWeight.w800)),
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

      body: SingleChildScrollView(
        child: Container(
          height: height*1.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: height*0.025,),
                Text("Welcome to the Help Center",
                style: _const.raleway_263238(28, FontWeight.w800),
                  textAlign: TextAlign.center,
                ),
              SizedBox(height: height*0.025,),
              Container(
                width: width*1,
                margin: EdgeInsets.only(left: width*0.1,right: width*0.1),
                height: height*0.06,
                decoration: BoxDecoration(
                    color: Color(0xffBCEFE0),
                    borderRadius: BorderRadius.circular(15)
                ),
                child: TextField(

               style: _const.raleway_SemiBold_white(17, FontWeight.w600),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                    top: height*0.01
                    ,left: width*0.05),
                      hintText: "Search Dingzo Help",
                      helperStyle: TextStyle(
                        fontFamily: 'Raleway-Regular',
                        fontSize: 17,
                        color: Color.fromRGBO(38, 50, 56, 0.35)
                      ),
                      border: InputBorder.none,
                      suffixIcon: Icon(Icons.search,color: Color(0xff263238),)
                  ),
                ),
              ),

              SizedBox(height: height*0.075,),

              Container(
                margin: EdgeInsets.only(left: width*0.1,right: width*0.1),
                height: height*0.07,
                decoration: BoxDecoration(
                  color: rgbcolor,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text("Buying",style: _const.raleway_1A5A47(19, FontWeight.w600),)),
              ),
              SizedBox(height: height*0.025,),

              Container(
                margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

                height: height*0.07,
                decoration: BoxDecoration(
                color: rgbcolor,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text("Selling",style: _const.raleway_1A5A47(19, FontWeight.w600),)),
              ),
              SizedBox(height: height*0.025,),

              Container(
                margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

                height: height*0.07,
                decoration: BoxDecoration(
                color: rgbcolor,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text("Account",style: _const.raleway_1A5A47(19, FontWeight.w600),)),
              ),
              SizedBox(height: height*0.025,),

              Container(
                margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

                height: height*0.07,
                decoration: BoxDecoration(
                color: rgbcolor,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text("Returns",style: _const.raleway_1A5A47(19, FontWeight.w600),)),
              ),
              SizedBox(height: height*0.025,),

              Container(
                margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

                height: height*0.07,
                decoration: BoxDecoration(
                color: rgbcolor,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text("Shipping",style: _const.raleway_1A5A47(19, FontWeight.w600),)),
              ),
              SizedBox(height: height*0.025,),

              InkWell(
                onTap: ()async{
                  SocialMediaDatabase _social_database=SocialMediaDatabase();
                 _social_database
                      .getUserInfogetChats(
                     user2:
                     "admin",
                 product_id: ''
                 )
                      .then((value) {
                    print(
                        "so final chatroom id is " +
                            value.toString());

                    Navigator.of(context).pushNamed(
                      Chat_Screen.routename,
                      arguments: ChatReciever(

                          chatid: value.toString(),
                          user:  MyUser(
                              uid:"admin",
                              username:"admin",
                              imageurl:"https://d2gg9evh47fn9z.cloudfront.net/1600px_COLOURBOX9896883.jpg"
                          ),
                          product:Product(id: '', price: 23, title: 'dd', quantity: 2)
                      )
                    );

                    //
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

                  height: height*0.07,
                  decoration: BoxDecoration(
                  color: rgbcolor,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(child: Text("Resolution Center",style: _const.raleway_1A5A47(19, FontWeight.w600),)),
                ),
              ),
              SizedBox(height: height*0.025,),

              Container(
                margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

                height: height*0.07,
                decoration: BoxDecoration(
                color: rgbcolor,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text("More Help",style: _const.raleway_1A5A47(19, FontWeight.w600),)),
              ),
              SizedBox(height: height*0.025,),



            ],
          ),
        ),
      ),

    );
  }
}
