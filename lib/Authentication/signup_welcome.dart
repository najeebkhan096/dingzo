import 'package:dingzo/Database/database.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/Authentication/login.dart';
import 'package:dingzo/Authentication/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignupWelcome extends StatelessWidget {
  static const routename="SignupWelcome";

Constants _const=Constants();
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;


    return Scaffold(
backgroundColor: Color(0xffFFEA9D),
      body: Container(
        margin: EdgeInsets.only(top: height*0.1),
        decoration: BoxDecoration(
            color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight:  Radius.circular(50))

        ),
        height: height*1,
        width: width*1,
        child: Stack(
          children: [
            Container(
              child: ListView(
                children: [
              Container(
                height: height*0.15,
                decoration: BoxDecoration(

                  image: DecorationImage(
                    image: AssetImage("images/dollaricon.png")
                  )
                ),
              ),

                  Center(child: Text("Congratulate",style: _const.poppin_SemiBold(18, FontWeight.w600),))
,
                  SizedBox(height: height*0.1,),
                  Center(child: Text("Sign up",style: _const.poppin_SemiBold(24, FontWeight.w600),))
          ,
                  Center(child: Text("It’s easier to sing up new",
                  style: _const.poppin_SemiBold(14, FontWeight.w400),

                  )),
                  SizedBox(height: height*0.025,),
                  InkWell(
                    onTap: ()async{
                      print("pressed");

                      Database _database=Database();
                      await _database.googleSignIn(context).then((value) {

                      });
                    },
                    child: Container(
                      height: height*0.055,

                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05,),

                      decoration: BoxDecoration(
                          color: Color(0xffFFEA9D),
                          borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                      children: [
                        SizedBox(width: width*0.15,),
                         Image.asset('images/google.png',height: height*0.05),

                          SizedBox(width: width*0.035,),
                          Text(
                            'Sign up with Google',
                            style: _const.poppin_brown(16, FontWeight.w500)
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: height*0.025,),
                  Container(
                    height: height*0.055,

                    margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05,),

                    decoration: BoxDecoration(
                      color: Color(0xffFFEA9D),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(

                      children: [
                        SizedBox(width: width*0.15,),
                        Image.asset('images/fb.png',height: height*0.05),

                        SizedBox(width: width*0.035,),
                        Text(
                            'Sign up with facebook',
                            style: _const.poppin_brown(16, FontWeight.w500)
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height*0.025,),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed(SignupScreen.routename);

                    },
                    child: Container(
                      height: height*0.055,

                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05,),

                      decoration: BoxDecoration(
                        color: Color(0xffFFEA9D),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(

                        children: [
                          SizedBox(width: width*0.15,),
                          Icon(Icons.email_outlined,color: Colors.white,),

                          SizedBox(width: width*0.06,),
                          Text(
                              'Sign up with email',
                              style: _const.poppin_brown(16, FontWeight.w500)
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: height*0.025,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? ",style: _const.poppin_Regualr(12, FontWeight.w400),),
                    InkWell(
                        onTap: (){

                          Navigator.of(context).pushNamed(LoginScreen.routename);

                        },
                        child: Text("Login",style: _const.poppin_brown(12, FontWeight.w400),))
                    ],
                  )
                  

          ],
              ),
            ),


            Positioned(
                right: 0,
                top: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(topRight:  Radius.circular(50))
,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset('images/right.svg',
                        height: height*0.2,fit: BoxFit.fill,
                      ),
                    Positioned(
                        right: width*0.028,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.white,
                    child: IconButton(onPressed: (){},
                        icon: Icon(Icons.close,color: Color(0xffC1C7DD),size: 11,))

                        ) ),

                    ]
                    ,
                  ),
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
