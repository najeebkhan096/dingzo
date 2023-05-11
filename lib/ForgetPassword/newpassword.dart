import 'package:firebase_auth/firebase_auth.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Enter_new_password extends StatefulWidget {
  static const routename = "Enter_new_password";

  @override
  _Enter_new_passwordState createState() => _Enter_new_passwordState();
}

class _Enter_new_passwordState extends State<Enter_new_password> {
   final auth = FirebaseAuth.instance;


bool isloading=false;
  Future<void> Dialogue_message(BuildContext context){
    return showDialog(context: context, builder: (context)
    {
      return AlertDialog(
        title: Text("Check Your Email"),
        content: Text("Confirm New password from your provided gmail"),
        actions: [
          MaterialButton(onPressed: (){
             Navigator.of(context).pushNamedAndRemoveUntil(Wrapper.routename, (route) => false);
          },child: Text("Okay"),)
        ],
      );

    }
    );
  }
String email='';

  Future reset_password()async{
    print("lund "+email.toString());
   await auth.sendPasswordResetEmail(email: email).then((value) {
     setState(() {
       isloading=false;
     });
     Dialogue_message(context);
   });

  }

  final GlobalKey<FormState> _formKey = GlobalKey();

  Future<void> _submit() async
  {
    if(!_formKey.currentState!.validate())
    {
      return;
    }
    _formKey.currentState!.save();
setState(() {
  isloading=true;
});
    print("jaa ");
    print(email.toString());
    await reset_password();

  }

  String password='';

  String newpassword='';

  String confirm_passord='';

  @override
  Widget build(BuildContext context) {
    email=ModalRoute.of(context)!.settings.arguments as String;
      isloading=false;
    print("SRK");
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Builder(builder: (context){
            return Container(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                    ),
                    Center(
                        child: Text(
                          "Enter"+email.toString(),
                          style: TextStyle(
                              color: Color(0xff000000),
                              fontFamily: 'ProximaNova-Regular',
                              fontWeight: FontWeight.w700,
                              fontSize: 22),
                        )),
                    SizedBox(
                      height: 70,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40, right: 70),
                      child: Container(
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'Password',
                              labelStyle:  TextStyle(
                                  color: Color(0xffABA5A5),
                                  fontFamily: 'ProximaNova-Regular',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.51)
                          ),


                          validator: (value)
                          {
                            if(value!.isEmpty || value.length<=5)
                            {
                              return 'invalid password';
                            }
                            return null;
                          },
                          onSaved: (value)
                          {
                            setState(() {
                              password = value!;
                            });
                          },
                          onChanged: (value){
                            setState(() {
                              password = value;
                            });
                          },
                          onFieldSubmitted: (value){
                            setState(() {
                              password = value;
                            });

                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40, right: 70),
                      child:  TextFormField(
                        decoration: InputDecoration(labelText: 'Confirm Password',
                            labelStyle:  TextStyle(
                                color: Color(0xffABA5A5),
                                fontFamily: 'ProximaNova-Regular',
                                fontWeight: FontWeight.w400,
                                fontSize: 14.51)
                        ),

                        validator: (value)
                        {
                          if(value!.isEmpty || value != password)
                          {
                            return 'invalid password';
                          }
                          return null;
                        },
                        onSaved: (value)
                        {
                          confirm_passord=value!;
                        },
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
          isloading?
              SpinKitRing(color: mycolor)
              :
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width * 0.7,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: mycolor
                        ),
                        child: TextButton(
                          child: Text(
                            'Submit',
                            style: TextStyle(
                                color: Color(0xffFFFFFF),
                                fontFamily: 'ProximaNova-Regular',
                                fontWeight: FontWeight.w400,
                                fontSize: 14.51),
                          ),


                          onPressed: () {
                             _submit();
                            // SnackBar mysnackbar=SnackBar(content: Text("Check your email and change password from there"),duration: Duration(seconds: 5),);
                            // Scaffold.of(context).showSnackBar(mysnackbar);


                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          })

      ),
    );
  }
}