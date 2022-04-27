import 'package:dingzo/constants.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

Constants _const=Constants();

class Carsoul_Image extends StatelessWidget {

final bool ? sold;
Carsoul_Image({required this.sold});

  List categ=[
    {
      'image':"https://tse2.mm.bing.net/th?id=OIP.WfI7aMWbrc8NqxxDd0d7TQHaEy&pid=Api&P=0&w=255&h=165",
      'title':"Shirts"
    },
    {
      'image':"https://tse2.mm.bing.net/th?id=OIP.WfI7aMWbrc8NqxxDd0d7TQHaEy&pid=Api&P=0&w=255&h=165",
      'title':"Hobby"
    },
    {
      'image':"https://tse1.explicit.bing.net/th?id=OIP.uEW_6gBej6tDPbEQg4zMswHaE8&pid=Api&P=0&w=267&h=178",
      'title':"Beauty"
    },
    {
      'image':"https://tse3.mm.bing.net/th?id=OIP.o7FeDoDEgIrN7bA4r1mvNgHaE4&pid=Api&P=0&w=257&h=169",
      'title':"Rooms"
    },


  ];
  int index=0;
  final controller = PageController(viewportFraction: 0.8, keepPage: true);
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return Container(
      child: Stack(
        children: [
          CarouselSlider(
              items:
              categ.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,

                      decoration: BoxDecoration(
                        image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(i['image'])
                          )
                      ),

                    );
                  },
                );
              }).toList(),
              options: CarouselOptions(
                height:
                sold!?  height*0.4:
                height*0.3,
                aspectRatio: 16/9,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              )
          ),
sold!?
          Positioned(

              top: height*0.08,
              child: Container(
            width: width*1,
            color: Color(0xffFFEA9D),
            child: Column(
              children: [
                SizedBox(height: height*0.025,),
                Text("Sold 1 month ago",style:_const.raleway_regular_darkbrown(20, FontWeight.w700) ),

                SizedBox(height: height*0.025,),
                Container(
                  height: height*0.05,
                  width: width*0.25,
                  padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                  decoration: BoxDecoration(
                      color: Color(0xffEFB546),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(child: Text("View Sale",style:_const.raleway_SemiBold_white(12, FontWeight.w600),)),
                ),
                SizedBox(height: height*0.025,),
              ],
            ),
          )):Text(""),

          Positioned(
            bottom: height*0.05,
            left: width*0.4,
            child: SmoothPageIndicator(
              count: categ.length,
              controller: controller,
              effect: WormEffect(
                dotHeight: 16,
                dotWidth: 16,
                activeDotColor: Color(0xffEFB546),
                type: WormType.thin,
                // strokeWidth: 5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
