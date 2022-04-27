import 'package:dingzo/constants.dart';
import 'package:flutter/material.dart';
class Completed extends StatelessWidget {

  Constants _const=Constants();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [

          SizedBox(height: height*0.02,),

          Container(
            margin: EdgeInsets.only(left: width*0.025,right: width*0.025),
            child:   Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: width*0.3,
                  height: height*0.17,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: AssetImage("images/categ.png")
                      )
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(left: width*0.025,right: width*0.025),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text("Chargers",style: _const.raleway_SemiBold_darkbrown(20, FontWeight.w600)),
                      SizedBox(height: height*0.005,),
                      Text("3 Likes",style: _const.raleway_SemiBold_darkbrown(15, FontWeight.w600)),
                      Text("48 Views",style: _const.raleway_SemiBold_darkbrown(15, FontWeight.w600)),
                      Text("\$4.99",style: _const.raleway_SemiBold_darkbrown(15, FontWeight.w600)),
                      Text("1/4/2022",style: _const.raleway_SemiBold_darkbrown(15, FontWeight.w600)),
                    ],
                  ),
                ),

                Container(
                  height: height*0.04,
                  width: width*0.25,
                  margin: EdgeInsets.only(left: width*0.05),
                  padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                  decoration: BoxDecoration(
                      color: Color(0xffEFB546),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(child: Text("View Order",style:_const.raleway_SemiBold_white(12, FontWeight.w600),)),
                ),



              ],
            ),
          ),

        ],
      ),
    );
  }
}
