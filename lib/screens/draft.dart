import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DraftSave extends StatelessWidget {
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
                height: height*0.15,
                width: width*1,
                decoration: BoxDecoration(
                    color:  Color(0xffFFEA9D),
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(40))
                ),
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
                              child:SvgPicture.asset('images/back.svg',height: height*0.025,)
                          ),
                        ),

                        Text('SavedDraft',style: _const.raleway_extrabold(30, FontWeight.w800),),


                        Text("")
                      ],
                    ),

                    SizedBox(height: height*0.03,),
                  ],
                ),

              ),

              SizedBox(height: height*0.025,),

              Container(
                height: height*0.8,
                child:   GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: height*0.025,
                        crossAxisCount: 2,
                        mainAxisExtent: height*0.36
                    ),

                    itemCount: 20,
                    itemBuilder: (context,index){

                      return Container(
                        margin: EdgeInsets.only(left: width*0.025,right: width*0.025),
                        width: width*0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),

                        ),
                        child: Column(
                          children: [
                            Container(
                              height:height*0.23,
                              child: Stack(
                                children: [
                                  Container(
                                    height:height*0.23,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: AssetImage('images/categ.png')
                                        )
                                    ),

                                  ),
                                  Positioned(
                                      right: width*0.025,
                                      top: height*0.025,
                                      child: Icon(Icons.favorite,color: Colors.red,))

                                ],
                              ),
                            ),

                            Expanded(

                              child: Container(
                                margin: EdgeInsets.only(left: width*0.025,right: width*0.025),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: height*0.01,),

                                    Text("\$30",style: _const.raleway_SemiBold_9E772A(12, FontWeight.w700),),
                                    SizedBox(height: height*0.01,),

                                    Text("[space.room] Aestethic Concrete Vase",style: _const.raleway_medium_black(15, FontWeight.w500),)

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

    );
  }
}
