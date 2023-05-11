import 'package:dingzo/screens/marchantportal/marchant_signup.dart';
import 'package:dingzo/wrapper.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:dingzo/Database/database.dart';
import 'package:dingzo/Database/payment.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/screens/PaymentWebView.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountCreation extends StatefulWidget {
  static const routename="AccountCreation";

  @override
  State<AccountCreation> createState() => _AccountCreationState();
}

class _AccountCreationState extends State<AccountCreation> {
  Constants _const=Constants();
String ? accountid;
String ? url;
bool createstripeaccount=false;
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
          title: Text("Account Creation",style: _const.manrope_regular263238(20, FontWeight.w800)),
          leading: IconButton(onPressed: (){
            Navigator.of(context).pop();

          }, icon: Icon(Icons.arrow_back_ios,color: Color(0xff3A4651),)),
          actions: [


          ],
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: [

            SizedBox(height: height*0.025,),

            Center(child: Text("Stripe Account Creation",style: _const.raleway_535F5B (20, FontWeight.w600),)),


            SizedBox(height: height*0.05,),

            if(accountid==null ||  accountid!.isEmpty)

           createstripeaccount?
           SpinKitRotatingCircle(
             color: mycolor,
             size: 50.0,
           )
               :
            InkWell(
              onTap: ()async{

                setState(() {
                    createstripeaccount=true;
                });

                await paymentdatabase.CreateSelerAccount().then((value) async {


                   accountid=value;
                   await paymentdatabase.getAccountLink(accountid!).then((value) {

                   setState(() {
                     url=value.toString();
                     createstripeaccount=false;
                   });
                   });


               });



               },
              child: Container(
                height: height*0.055,
                width: width*0.3,
                margin: EdgeInsets.only(left: width*0.2,right: width*0.2),
                decoration: BoxDecoration(
                    color:blackbutton,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text("Create Stripe Account",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
              ),
            ),

 
            // InkWell(
            //   onTap: ()async{
            //     Navigator.of(context).pushNamed(MarchantSignUp.routename);
            //   },
            //   child: Container(
            //     height: height*0.055,
            //     width: width*0.3,
            //     margin: EdgeInsets.only(left: width*0.2,right: width*0.2),
            //     decoration: BoxDecoration(
            //         color:Color(0xffEFB546),
            //         borderRadius: BorderRadius.circular(10)
            //     ),
            //     child: Center(child: Text("Marchant account",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
            //   ),
            // ),
            SizedBox(height: height*0.05,),
           if(accountid!=null && accountid!.isNotEmpty)
            InkWell(
              onTap: ()async{
print("ali ur is "+url.toString());
                Navigator.of(context).pushNamed(PaymentWebView.routename,arguments: url!).then((value) async {
                  print("after returning value is "+value.toString());
                if(value.toString()=='success'){

              await   database.update_account_id(id: accountid).then((value) {
                currentuser!.accountcreated=true;
                currentuser!.stripe_account_id=accountid;
                Navigator.of(context).pop();
              });

                }
                });

                // await   launch(url!).then((value) {
                //   print("after coming back the value is "+value.toString());
                // });
              },
              child: Container(
                height: height*0.055,
                width: width*0.4,
                margin: EdgeInsets.only(left: width*0.1,right: width*0.1),
                decoration: BoxDecoration(
                    color:blackbutton,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text("Set up Stripe Account Detail",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
              ),
            ),
          ],
        ),

      ),
    );
  }
}
