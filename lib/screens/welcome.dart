import 'package:dingzo/constants.dart';
import 'package:dingzo/screens/SelectCategory.dart';
import 'package:dingzo/screens/finish.dart';
import 'package:dingzo/Authentication/signup_welcome.dart';
import 'package:dingzo/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Welcome extends StatelessWidget {
  static const routename="Welcome";
  Constants _const=Constants();
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;


    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(

        height: height*1,
        child: Stack(
          children: [
            Container(

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: height*0.25,
                    decoration: BoxDecoration(

                        image: DecorationImage(
                            image: AssetImage("images/dollaricon.png")
                        )
                    ),
                  ),

                  Center(child: Text("Welcome",style: _const.poppin_SemiBold(18, FontWeight.w600),))
                  ,
                  SizedBox(height: height*0.05,),
        Container(
            width: width*0.4,
            child: Text("   Mutual sympathy, do not waste time messenger to harl",style: _const.poppin_Regualr(12, FontWeight.w400),textAlign: TextAlign.center,))

,
                  SizedBox(height: height*0.05,),

                  InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed(Wrapper.routename);

                    },
                    child: Container(
                      height: height*0.055,

                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.25,right: MediaQuery.of(context).size.width*0.25,),

                      decoration: BoxDecoration(
                        color: Color(0xffEFB546),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                            'Next',
                            style: _const.poppin_white(18, FontWeight.w600)
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),


            Positioned(
                right: 0,
                top: 0,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset('images/right.svg',
                      height: height*0.2,fit: BoxFit.fill,
                    ),
                    Positioned(
                        right: width*0.028,
                        child: IconButton(onPressed: (){},
                            icon: Icon(Icons.arrow_forward,color: Color.fromRGBO(0, 0, 0, 0.5),size: 18,)) ),

                  ]
                  ,
                )),

            Positioned(
                bottom: 0,
                left: 0,
                child: SvgPicture.asset('images/left.svg',height: height*0.2,)),

          ],
        ),

      ),
    );
  }
}
