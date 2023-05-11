import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/model/product.dart';
import 'package:dingzo/screens/detailscreen.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyLikes extends StatelessWidget {
  static const routename="MyLikes";
  Constants _const=Constants();
List<Product> products=[];
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    products=ModalRoute.of(context)!.settings.arguments as List<Product>;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.8,

        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("My Likes",style: _const.manrope_regular263238(20, FontWeight.w800)),

        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();

        }, icon: Icon(Icons.arrow_back_ios,color: Color(0xff3A4651),)),
        actions: [

        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: height*1.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [



              SizedBox(height: height*0.025,),
              Container(
                height: height*0.8,
                child:   GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: height*0.025,
                        crossAxisCount: 2,
                        mainAxisExtent: height*0.36
                    ),

                    itemCount: products.length,
                    itemBuilder: (context,index){

                      return InkWell(
                        onTap: (){
                          Navigator.of(context).pushNamed(DetailScreen.routename ,arguments: products[index]);
                        },
                        child: Container(
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
                                              image: NetworkImage(products[index].photos!.first)
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
                                      Text("\$${products[index].price}",style: _const.raleway_SemiBold_9E772A(12, FontWeight.w700),),

                                      Text(products[index].description!,style: _const.raleway_medium_black(15, FontWeight.w500),)

                                    ],

                                  ),
                                ),

                                flex: 1,
                              )

                            ],
                          ),
                          height: height*0.05,

                        ),
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
