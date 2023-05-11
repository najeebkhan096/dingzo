import 'package:dingzo/Database/auth.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/screens/cart.dart';
import 'package:dingzo/screens/checkout.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:dingzo/wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_auth/email_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class EditAccount extends StatefulWidget {
  static const routename="EditAccount";

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  Constants _const=Constants();

String ?currentpass;
String? pass;
String ?confirmpas;

  bool isloading=false;
  void _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An Error Occured'),
          content: Text(msg),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ));
  }
  final GlobalKey<FormState> _formKey = GlobalKey();

  Future<void> _submit() async {

    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    setState(() {
      isloading=true;
    });
    print(pass.toString());

    AuthCredential ? credential;
    try{
      credential = EmailAuthProvider.credential(
          email:currentuser!.email!,
          password:currentpass!
      );

      await   auth.currentUser!.reauthenticateWithCredential(credential).then((value) async {
        auth.currentUser!.updatePassword(pass!).then((value) async{
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Password Changed"))
          );
          await auth.signOut().then((value) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => Wrapper()),
                    (route)=>false
            );
          });
        });



      });


    }catch(error){
      _showErrorDialog("Current Password is not Correct");
    }



// Prompt the user to re-provide their sign-in credentials




  }

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.8,
          leadingWidth: width*0.3
          ,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text("My Account",style: _const.manrope_regular263238(20, FontWeight.w800)),
          leading: IconButton(onPressed: (){
            Navigator.of(context).pop();

          }, icon: Icon(Icons.arrow_back_ios,color: Color(0xff3A4651),)),
          actions: [


          ],
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: [

            SizedBox(height: height*0.05,),
Center(child: Text("Email",style:_const.raleway_535F5B(20, FontWeight.w600))),
            SizedBox(height: height*0.025,),

            Container(
              margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

              height: height*0.07,
              decoration: BoxDecoration(
                  color: Color.fromRGBO (32, 201, 151, 0.27),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(child: Text(currentuser!.email.toString(),style: _const.raleway_1A5A47(17, FontWeight.w600),)),
            ),
            SizedBox(height: height*0.075,),


            Center(child: Text("Password",style:_const.raleway_535F5B(20, FontWeight.w600))),
            SizedBox(height: height*0.025,),


            Container(
              margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

              height: height*0.07,
              decoration: BoxDecoration(
                  color: Color.fromRGBO (32, 201, 151, 0.27),
                  borderRadius: BorderRadius.circular(10)
              ),
              child:TextFormField(
                onSaved: (val){
                  currentpass=val;
                },
                onChanged: (val){

              currentpass=val;

                },
                validator: (val){
                  if(val!.isEmpty){
                    return 'Should not be Empty';
                  }


                },
                textAlign: TextAlign.center,

                decoration: InputDecoration(
                    border: InputBorder.none,
                  hintText: "Current Password",
                  hintStyle:  _const.raleway_rgb_textfield(17, FontWeight.w600),
                ),
                style: _const.raleway_rgb_textfield(17, FontWeight.w600),),
            ),
            SizedBox(height: height*0.025,),

            Container(
              margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

              height: height*0.07,
              decoration: BoxDecoration(
                  color: Color.fromRGBO (32, 201, 151, 0.27),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: TextFormField(
                onSaved: (val){
                  pass=val;
                },
                onChanged: (val){

                  pass=val;

                },
                textAlign: TextAlign.center,
                validator: (val){
                  if(val!.isEmpty){
                    return 'Should not be Empty';
                  }


                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                  hintText: "New Password",
                  hintStyle:  _const.raleway_rgb_textfield(17, FontWeight.w600),
                ),
                style: _const.raleway_rgb_textfield(17, FontWeight.w600),),
            ),
            SizedBox(height: height*0.025,),

            Container(
              margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

              height: height*0.07,
              decoration: BoxDecoration(
                  color: Color.fromRGBO (32, 201, 151, 0.27),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: TextFormField(
                onSaved: (val){
                 confirmpas=val;
                },
                onChanged: (val){

                 confirmpas=val;

                },
                textAlign: TextAlign.center,
     validator: (val){
                  if(val!.isEmpty){
                    return 'Should not be Empty';
                  }
                  else if(val.toString()!=pass){
                    return "Not Matched";
                  }

     }, 
                decoration: InputDecoration(
                    border: InputBorder.none,
                  hintText: "Confirm Password",
                  hintStyle:  _const.raleway_rgb_textfield(17, FontWeight.w600),

                ),
                style: _const.raleway_rgb_textfield(17, FontWeight.w600),),
            ),
            SizedBox(height: height*0.025,),

            isloading?SpinKitRotatingCircle(
              color: Colors.black,
              size: 50.0,
            ):
            InkWell (
              onTap: ()async{
_submit();

              },
              child: Container(
                height: height*0.055,
                width: width*1,
                margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

                padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                decoration: BoxDecoration(
                    color: blackbutton,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text("Update",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
              ),
            ),
            SizedBox(height: height*0.025,),
            Container(
              margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

              height: height*0.07,
              decoration: BoxDecoration(
                  color: Color.fromRGBO (32, 201, 151, 0.27),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(child: Text("Close Account",style: _const.raleway_rgb_textfield(17, FontWeight.w600),)),
            ),
            SizedBox(height: height*0.025,),
          ],
        ),

      ),
    );
  }
}
