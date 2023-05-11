import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoriesScreen extends StatelessWidget {
  static const routename="CategoriesScreen";
  Constants _const=Constants();
List categ=["Electronics","Beauty","Hobby","Men","Women","Women"];
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
                    Text('Categories',style: _const.raleway_extrabold(30, FontWeight.w800),),
                    SizedBox(height: height*0.025,),
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

              Container(
                height: height*0.8,
                child:   GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: height*0.025,
                        crossAxisCount: 2,
                        mainAxisExtent: height*0.2

                    ),

                    itemCount: categ.length,
                    itemBuilder: (context,index){

                      return Container(
                        margin: EdgeInsets.only(left: width*0.05,right:  width*0.05),
                        width: width*0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:Color(0xffF0B546).withOpacity(0.6),
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
                      alignment: Alignment.center,
                                margin: EdgeInsets.only(left: width*0.025,right: width*0.025),
                                child: Text(categ[index],style: _const.raleway_regular_darkbrown(18, FontWeight.w700),),
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
