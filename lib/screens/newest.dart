import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NewestPage extends StatelessWidget {
  static const routename="NewestPage";
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

      body: SingleChildScrollView(
        child: Container(
          height: height*1.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                height: height*0.2,
                width: width*1,
                decoration: BoxDecoration(
                    color:  Color(0xffFFEA9D),
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(40))
                ),
                child: Column(

                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Newest',style: _const.raleway_extrabold(30, FontWeight.w800),),
                    SizedBox(height: height*0.01,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(

                          child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.white,
                              child:SvgPicture.asset('images/back.svg',height: height*0.025,)
                          ),
                        ),

                        Container(
                          width: width*0.6,
                          height: height*0.06,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: TextField(

                            decoration: InputDecoration(
                                hintText: "Search",
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.search,color: Colors.blue,)
                            ),
                          ),
                        ),

                        Image.asset('images/cart.png',)
                      ],
                    ),

                    SizedBox(height: height*0.03,),
                  ],
                ),

              ),

              SizedBox(height: height*0.025,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Chip(
                    backgroundColor: Color(0xffF9F6EC),
                    label: Text("Save Search",style: _const.poppin_orange(15,FontWeight.w600),),
                  ),
                  SizedBox(width: width*0.05,),

                  Chip(
                    backgroundColor: Color(0xffF9F6EC),
                    label: Text("Sort",style: _const.poppin_orange(15,FontWeight.w600),),
                  ),
                  SizedBox(width: width*0.05,),
                  Chip(
                    backgroundColor: Color(0xffF9F6EC),
                    label: Row(
                      children: [
                        Text("filter",style: _const.poppin_orange(15,FontWeight.w600),),
                        Icon(Icons.arrow_upward,color: Color(0xffEFB546),size: 13,)
                      ],
                    ),
                  ),

                ],
              ),
              Container(
                height: height*0.8,
                child:   GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: height*0.025,
                        crossAxisCount: 3,
                        mainAxisExtent: height*0.15

                    ),

                    itemCount: 20,
                    itemBuilder: (context,index){

                      return Container(
                        margin: EdgeInsets.only(left: width*0.025),
                        width: width*0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:Color(0xffEFB546),
                        ),
                        child: Column(
                          children: [
                            Expanded(

                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage('images/categ.png')
                                    )
                                ),

                              ),
                              flex: 3,
                            ),
                            Expanded(

                              child: Container(
                                margin: EdgeInsets.only(left: width*0.025,right: width*0.025),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("\$20",style: _const.poppin_Regualr(12, FontWeight.w700),),
                                    Icon(Icons.favorite_border,size: 14,)
                                  ],

                                ),
                              ),

                              flex: 1,
                            )

                          ],
                        ),
                        height: height*0.05,

                      );

                    }),
              ),

            ],
          ),
        ),
      ),
      bottomNavigationBar: Home_Bottom_Navigation_Bar(),
    );
  }
}
