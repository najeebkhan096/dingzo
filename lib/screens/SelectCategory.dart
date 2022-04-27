import 'package:dingzo/constants.dart';
import 'package:dingzo/screens/finish.dart';
import 'package:dingzo/Authentication/login.dart';
import 'package:dingzo/wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectCategory extends StatefulWidget {
  static const routename="SelectCategory";
  @override
  State<SelectCategory> createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {
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
                        // Navigator.of(context).pop();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => Wrapper()),
                                (route)=>false
                        );
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

                  Center(child: Text("Welcome, name",style: _const.poppin_brown(20, FontWeight.w600),))
               ,
                  SizedBox(height: height*0.01,),


                  Center(
                    child: Container(
                      width: width*0.4,
                      child: Text("To provide you a better buying experience, select 3 categories you are interested in!",textAlign: TextAlign.center,style: _const.poppin_brown(12, FontWeight.w100)),
                    ),
                  ),
SizedBox(height: height*0.05,),


Container(

  child:   GridView.builder(
  shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

    mainAxisSpacing: height*0.025,
    crossAxisCount: 2,

  ),

      itemCount: categ.length,
      itemBuilder: (context,index){

    return   Container(
margin: EdgeInsets.only(left: width*0.025,right: width*0.025),
      decoration: BoxDecoration(
borderRadius: BorderRadius.circular(10),
        color:Color(0xffEFB546),


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

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(categ[index].toString(),style: _const.poppin_brown(23, FontWeight.w700),),
            Checkbox(value: false, onChanged: (val){
            },

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3)
            ),
            )
            ],

          ),
        ),

    flex: 1,
    )

  ],
),
      height: height*0.2,

    );

  }),
),


                  SizedBox(height: height*0.025,),
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


          ],
        ),

      ),
     floatingActionButton:  InkWell(
       onTap: (){
         Navigator.of(context).pushNamed(FinishScreen.routename);

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
               'Skip',
               style: _const.poppin_white(18, FontWeight.w600)
           ),
         ),
       ),
     ),
    );
  }
}
