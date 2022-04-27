import 'package:dingzo/constants.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class CarsoulImageOFF extends StatelessWidget {

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
  Constants _const=Constants();
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
                height: height*0.3,
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

          Positioned(
            top: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.only(left: width*0.025,right: width*0.025,bottom:  height*0.025,top:  height*0.025),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xffB1CE9B),
              ),
              child: Text("10 % OFF",style: _const.raleway_SemiBold_white(20, FontWeight.w600),),
            ),
          ),

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
