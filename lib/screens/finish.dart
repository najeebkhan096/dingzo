import 'package:dingzo/constants.dart';
import 'package:dingzo/screens/SelectCategory.dart';
import 'package:dingzo/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FinishScreen extends StatefulWidget {
  static const routename="FinishScreen";
  @override
  State<FinishScreen> createState() => _FinishScreenState();
}

class _FinishScreenState extends State<FinishScreen> {
  Constants _const=Constants();

  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _switch=false;
  String ? name='';

  String ? email='';

  String ? pass='';

  bool  show=false;
  List categ=['Men','Women','Beauty','Hobby'];
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

              child: ListView(
                children: [
                  Row(
                    children: [
                      IconButton(onPressed: (){
                        Navigator.of(context).pop();
                      },
                        icon: Icon(Icons.arrow_back,
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          size: 18,),
                      ),
                      Container(
                        height: height*0.2,
                        width: width*0.75,
                        decoration: BoxDecoration(

                            image: DecorationImage(
                                image: AssetImage("images/dollaricon.png")
                            )
                        ),
                      ),
                      Text("")
                    ],
                  ),

                  SizedBox(height: height*0.03,),

                  Center(child: Container(
                      width: width*0.7,
                      child: Text("Sell unlimited items for FREE! No fees to list No fees after sale Your Product Your Money",style: _const.poppin_brown(20, FontWeight.w600),))),
                  SizedBox(height: height*0.1,),

        InkWell(
          onTap: (){
            Navigator.of(context).pushNamed(HomeScreen.routename);

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
                  'Sell Now',
                  style: _const.poppin_white(18, FontWeight.w600)
              ),
            ),
          ),
        )
                  ,
                  SizedBox(height: height*0.025,),

                  InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed(HomeScreen.routename);
                    },
                    child: Container(
                      height: height*0.055,

                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.25,right: MediaQuery.of(context).size.width*0.25,),

                      decoration: BoxDecoration(
                        color: Color(0xffF9F6EC),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                            'Selling Tips',
                            style: _const.poppin_orange(18, FontWeight.w600)
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height*0.025,),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed(HomeScreen.routename);
                    },
                    child: Center(
                      child: Text(
                          'Skip',
                          style: _const.poppin_orange(18, FontWeight.w600)
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
                        icon: Icon(Icons.share,
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          size: 18,),
                      ),
                    ),

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
