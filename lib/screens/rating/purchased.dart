import 'package:dingzo/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Purchased extends StatelessWidget {

  Constants _const=Constants();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          SizedBox(height: height*0.02,),
          Row(
            children: [
              Container(
                  margin: EdgeInsets.only(left: width * 0.05),

                  child: Text("Seller Overall Rating",style: _const.raleway_regular_darkbrown(17, FontWeight.w600),)),
              SizedBox(width: width*0.02,),
              Row(
                children: List.generate(
                    4,
                        (index) => Image.asset('images/star.png')),
              ),
              SizedBox(width: width*0.01,),
              Text('5.0',
                  style: TextStyle(
                      color: Color(0xffF1C40F),
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Raleway-Regular'
                  )),
              SizedBox(width: width*0.02,),
              Text("(1)",style: _const.raleway_regular_darkbrown(17, FontWeight.w600),)
            ],
          )
          ,
          SizedBox(height: height*0.02,),

          Container(
            height: height*0.12,
            margin: EdgeInsets.only(left: width * 0.05,right: width * 0.05),
            width: width * 0.6,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundImage: AssetImage("images/radiant.png"),
                ),
                Container(

                  width: width*0.68,
                  margin: EdgeInsets.only(left: width * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Text("Melissa So",
                                style: _const.raleway_SemiBold_9E772A(
                                    15, FontWeight.w600)),
                          ),
                          SizedBox(height: height*0.005,),
                          Row(
                            children: List.generate(
                                4,
                                    (index) => Image.asset('images/star.png')),
                          ),
                          SizedBox(height: height*0.005,),
                          Text(
                            "2 days ago",
                            style: _const.raleway_regular_darkbrown(
                                16, FontWeight.w600),
                          )
                        ],
                      ),

                      Container(
                        width: width*0.2,
                        height: height*0.12,
                        decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage("images/categ.png")
                            )
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
          SizedBox(height: height*0.02,),
          Container(
              margin: EdgeInsets.only(left: width * 0.05,right: width * 0.05),

              child: Text("Decent...arrived as described. Thanks!",style: _const.raleway_SemiBold_darkbrown(16, FontWeight.w600),))

        ],
      ),
    );
  }
}
