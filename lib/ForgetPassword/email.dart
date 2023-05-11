import 'package:dingzo/ForgetPassword/otp.dart';
import 'package:email_auth/email_auth.dart';
import 'package:dingzo/ForgetPassword/newpassword.dart';
import 'package:dingzo/constants.dart';
import 'package:flutter/material.dart';


class Email_Screen extends StatefulWidget {
  static const routename = "Email_Screen";

  @override
  _Email_ScreenState createState() => _Email_ScreenState();
}

class _Email_ScreenState extends State<Email_Screen> {
  bool isloading=false;
  // Declare the object
  EmailAuth ? emailAuth;
  void sendOtp() async {
    print("here the value is");


    ///Accessing the EmailAuth class from the package
    emailAuth = new EmailAuth(
      sessionName: "dingzo",
    );

    bool result = await emailAuth!.sendOtp(

        recipientMail: _emailController.text, otpLength: 5);
    if (result) {
      setState((){
        isloading=false;
      });
      print("result is "+result.toString());

      Navigator.of(context).pushNamed(OTP_Screen.routename,
          arguments: _emailController.text
      );
      //

    }
    else{
      setState((){
        isloading=false;
      });
    }
  }
  // ///create a bool method to validate if the OTP is true
  // bool verify() {
  //   return (emailAuth!.validateOtp(
  //     userOtp: '',
  //       recipientMail: _emailController.text)); //pass in the OTP typed in
  //   ///This will return you a bool, and you can proceed further after that, add a fail case and a success case (result will be true/false)
  // }

  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: Text(
                  "Enter Your Email",
                  style: TextStyle(
                      color: Color(0xff000000),
                      fontFamily: 'ProximaNova-Regular',
                      fontWeight: FontWeight.w700,
                      fontSize: 31),
                )),
            SizedBox(
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: TextFormField(

                controller: _emailController,
                style: TextStyle(fontSize: 20),
                cursorColor: Colors.black,
                decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "Email",labelStyle:  TextStyle(
                    color: Color(0xffABA5A5),
                    fontFamily: 'ProximaNova-Regular',
                    fontWeight: FontWeight.w500,
                    fontSize: 15.51)),
                onTap: () {
                  // email = _emailController.text;
                },
                onSaved: (value) {
                  // setState(() {
                  //   email = _emailController.text;
                  // });
                },
                onFieldSubmitted: (value){
                  // setState(() {
                  //   email=_emailController.text;
                  // });
                },
              ),
            ),
            SizedBox(
              height: 60,
            ),
            isloading?CircularProgressIndicator():Text("")
          ],
        ),
      ),

      bottomNavigationBar: isloading?Text(""):Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: 50,
          width: 298,
          decoration: BoxDecoration(
            color: blackbutton,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextButton(

            child: Text(
              'Send',
              style: TextStyle(
                  color: Color(0xffFFFFFF),
                  fontFamily: 'ProximaNova-Regular',
                  fontWeight: FontWeight.w400,
                  fontSize: 14.51),
            ),
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(10),
            // ),
            // color: Color.fromRGBO(50, 205, 50, 2),
            // textColor: Colors.white70,
            onPressed: () {
              setState(() {
                isloading=true;
              });
              sendOtp();

            },
          ),
        ),
      ),
    );
  }
}
