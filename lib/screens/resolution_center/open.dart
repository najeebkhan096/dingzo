import 'package:dingzo/constants.dart';
import 'package:flutter/material.dart';
class OpenScreen extends StatelessWidget {

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

          Column(
            children: List.generate(2, (index) => Container(
              margin: EdgeInsets.only(left: width*0.025,right: width*0.025),
              child:   Row(

                children: [
                  Container(
                    width: width*0.27,
                    height: height*0.17,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: AssetImage("images/categ.png")
                        )
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(left: width*0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Text("Reason: Item not as described",style: _const.raleway_SemiBold_darkbrown(14, FontWeight.w600)),
                        SizedBox(height: height*0.015,),
                        Text("Item ID: 384547733",style: _const.raleway_SemiBold_darkbrown(15, FontWeight.w600)),
                        SizedBox(height: height*0.015,),
                        Container(
                          height: height*0.04,
                          width: width*0.25,
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
            )),
          ),

        ],
      ),
    );
  }
}
