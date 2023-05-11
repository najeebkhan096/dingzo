import 'package:dingzo/ForgetPassword/newpassword.dart';
import 'package:email_auth/email_auth.dart';
import 'package:dingzo/ForgetPassword/email.dart';
import 'package:dingzo/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class OTP_Screen extends StatefulWidget {

  /* bool verify(){
    return(EmailAuth.validate(
        receiverMail:  email, //to make sure the email ID is not changed
        userOTP: _otpController.value.text)); //pass in the OTP typed in
    ///This will return you a bool, and you can proceed further after that, add a fail case and a success case (result will be true/false)
  }*/
  static const routename = "OTP_Screen";

  @override
  _OTP_ScreenState createState() => _OTP_ScreenState();
}

class _OTP_ScreenState extends State<OTP_Screen> {
  var otp_list = [];
  String otp_string='';
  EmailAuth ? emailAuth=EmailAuth(
  sessionName: "dingzo",
  );
  final GlobalKey<FormState> _formKey = GlobalKey();

  // void sendOtp() async {
  //   print("here the value is");
  //   print(email);
  //
  //   ///Accessing the EmailAuth class from the package
  //   EmailAuth.sessionName = "Sample";
  //
  //   ///a boolean value will be returned if the OTP is sent successfully
  //   var data = await EmailAuth.sendOtp(receiverMail: email);
  //   if (data) {
  //     ///have your error handling logic here, like a snackbar or popup widget
  //     print("OTP sent");
  //
  //   } else {
  //     print("Could not send");
  //   }
  // }
  // Future<void> _submit() async
  // {
  //   if(!_formKey.currentState.validate())
  //   {
  //     return;
  //   }
  //   _formKey.currentState.save();
  //   print(_fourth_index);
  //   otp_string=_first_index+_second_index+_third_index+_fourth_index+_fifth_index+_sixth_index;
  //   print(otp_string);
  //   verify();
  // }
  TextEditingController textEditingController = TextEditingController();


  TextEditingController first_index = TextEditingController();
  String _first_index = '';
  String _second_index = '';
  String _third_index = '';
  String _fourth_index = '';
  String _fifth_index = '';
  String _sixth_index = '';
  // final auth = FirebaseAuth.instance;
  // Future<void> Dialogue_message(BuildContext context){
  //   return showDialog(context: context, builder: (context)
  //   {
  //     return AlertDialog(
  //       title: Text("Check Your Email"),
  //       content: Text("Confirm New password from your provided gmail"),
  //       actions: [
  //         MaterialButton(onPressed: (){
  //           Navigator.of(context).pushReplacementNamed(Sign_in_screen.routname);
  //         },child: Text("Okay"),)
  //       ],
  //     );
  //
  //   }
  //   );
  // }
  //

  void _showErrorDialog(String msg)
  {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An Error Occured'),
          content: Text(msg),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: (){
                Navigator.of(ctx).pop();
              },
            )
          ],
        )
    );
  }


  // ///create a bool method to validate if the OTP is true
  void verify() {

    var respons= (emailAuth!.validateOtp(
        recipientMail: email, userOtp: otp_string)); //pass in the OTP typed in
    ///This will return you a bool, and you can proceed further after that, add a fail case and a success case (result will be true/false)
    if(respons){
      Fluttertoast.showToast(
          msg:
          "verified",
          toastLength:
          Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: mycolor,
          textColor: Colors.white,
          fontSize: 16.0);
      print("verified"+email.toString()+"aka");
print("zubaan "+email.toString());
        Navigator.of(context).pushNamed(Enter_new_password.routename,arguments: email);
    }
    else{
      print("invalid otp");
      _showErrorDialog("invalid otp");
    }
  }
  String email='';

  @override
  Widget build(BuildContext context) {
    email=ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.18,
            ),
            Center(
                child: Text(
                  "Enter OTP",
                  style: TextStyle(
                      color: Color(0xff000000),
                      fontFamily: 'ProximaNova-Regular',
                      fontWeight: FontWeight.w700,
                      fontSize: 31),
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.099,
            ),

            Container(
              margin: EdgeInsets.only(left: 15,right: 15),
              child: Form (
                key: _formKey,
                child: PinCodeTextField(appContext: context, length: 6,onChanged: (value){
                  print(value);
                }, onCompleted: (value){
                  setState(() {
                    otp_string=value;

                  });
                },
                  keyboardType: TextInputType.number,
                  onAutoFillDisposeAction: AutofillContextAction.cancel,
                  controller: textEditingController,
                  autoDisposeControllers: true,
                  cursorColor: Colors.black,
                  pinTheme: PinTheme(
                      activeColor: Colors.black,
                      selectedColor: Colors.black,
                      inactiveFillColor: Colors.black,
                      disabledColor: Colors.black,
                      activeFillColor: Colors.black,
                      inactiveColor: Colors.black

                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.22,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Container(
                decoration: BoxDecoration(
                  color: mycolor,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextButton(
                  child: Text(
                    'VERIFY',
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  ),
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(10),
                  // ),
                  // color: mycolor,
                  // textColor: Colors.white,
                  onPressed: () {
                    verify();


                  },
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.035,
            ),
            Container(
              decoration: BoxDecoration(
                color: mycolor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton(
                  onPressed: () {
                    // setState(() {
                    //   first_index=null;
                    // });
                    // sendOtp();
                  },
                  child: Text("RESEND",
                      style: TextStyle(
                        color: Colors.white,
                      ))),
            ),
          ],
        ),
      ),
    );
  }
}