import 'package:dingzo/hometesting.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dingzo/Database/payment.dart';
import 'package:dingzo/screens/cart.dart';
import 'package:dingzo/screens/checkout.dart';
import 'package:dingzo/screens/feedback.dart';
import 'package:dingzo/screens/feedback2.dart';
import 'package:dingzo/screens/helpcenter.dart';
import 'package:dingzo/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/screens/EditAccount.dart';
import 'package:dingzo/screens/editaddress.dart';
import 'package:dingzo/screens/editpayment.dart';
import 'package:dingzo/screens/editprofile.dart';
import 'package:dingzo/screens/vocation_mode.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Setting extends StatelessWidget {
  static const routename="Setting";
  Constants _const=Constants();
  List categ=[
    {
      'image':"images/icons8-shirt-64 1.png",
      'title':"Shirts"
    },
    {
      'image':"images/hobby icon.png",
      'title':"Hobby"
    },
    {
      'image':"images/beauty care logo.png",
      'title':"Beauty"
    },
    {
      'image':"images/icons8-lamp-96 1.png",
      'title':"Rooms"
    },
    {
      'image':"images/icons8-lamp-96 1.png",
      'title':"Rooms"
    },

  ];

  // Future releasefund()async{
  //   var headers = {
  //     'Authorization':
  //     'Bearer sk_test_51IGzrSAWdh8XTc5i5j1vNDw4bbwYRZgAbdVwB4LEouLANRFcerYWv1tKDgOuW6RRm4vdr9N3LrUTlWvkpIQDKEa5005qLPLMOf',
  //
  //   };
  //   var request = http.Request('POST', Uri.parse('https://api.stripe.com/v1/payment_intents/pi_3M17bxAWdh8XTc5i1EHhQSiW/capture'));
  //
  //   request.headers.addAll(headers);
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     var data=await response.stream.bytesToString();
  //     print("ali gandu hai "+data.toString());
  //   }
  //   else {
  //     print("lalala "+response.reasonPhrase.toString());
  //     print(response.reasonPhrase);
  //   }
  //
  // }
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.8,
          leadingWidth: width*0.3
          ,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text("Setting",style: _const.manrope_regular263238(20, FontWeight.w800)),
          leading: IconButton(onPressed: (){
            Navigator.of(context).pop();

          }, icon: Icon(Icons.arrow_back_ios,color: Color(0xff3A4651),)),
          actions: [

            InkWell(
              onTap: (){
                Navigator.of(context).pushNamed(Checkout.routename);
              },
              child: Container(
                child: Image.asset('images/cart.png',color: Color(0xff263238)),
              ),
            ),
          ],
        ),


        body: Padding(
          padding:  EdgeInsets.only(left: width*0.05),
          child: ListView(
            children: [
              SizedBox(height: height*0.05,),

              InkWell(
                  onTap: ()async{
                  // await   releasefund();
                  },
                  child: build_setting_tile(context: context,title: "How To Use Supozo",subtitle: "Edit your personal information")),

              InkWell(
                  onTap: (){
                    Navigator.of(context).pushNamed(EditProfile.routename);
                  },
                  child: build_setting_tile(context: context,title: "Edit Profile",subtitle: "Edit your personal information")),

              InkWell(
                  onTap: (){
                    Navigator.of(context).pushNamed(EditAccount.routename);
                  },
                  child: build_setting_tile(context: context,title: "Edit Account",subtitle: "Edit your Payemnt information")),
              InkWell(
                  onTap: (){
                    Navigator.of(context).pushNamed(EditAddress.routename);
                  },
                  child: build_setting_tile(context: context,title: "Edit Address",subtitle: "")),
              InkWell(

                  onTap: (){
                    Navigator.of(context).pushNamed(EditPayment.routename);
                  },
                  child: build_setting_tile(context: context,title: "Edit Payment method",subtitle: "")),
              InkWell(
                  onTap: (){
                    Navigator.of(context).pushNamed(VocationMode.routename);
                  },
                  child: build_setting_tile(context: context,title: "Vocations",subtitle: "Can’t rent/sell right now? Go to vacation mode to hide your listings until you are able to rent/sell again.")),
              InkWell(
                  onTap: (){
                    // Navigator.of(context).pushNamed(EditProfile.routename);
                  },
                  child: build_setting_tile(context: context,title: "Onboard with Stripe",subtitle: "Start earning money with Zarkit")),
              InkWell(
                  onTap: (){

                  },
                  child: build_setting_tile(context: context,title: "Terms of Services",subtitle: "Please view our T&C here")),
              InkWell(
                  onTap: (){
                    // Navigator.of(context).pushNamed(Priv);
                  },
                  child: build_setting_tile(context: context,title: "Privacy Policy",subtitle: "Please view our privacy policy here")),
              InkWell(
                  onTap: (){
                    Navigator.of(context).pushNamed(Feedback2.routename);
                  },
                  child: build_setting_tile(context: context,title: "Feedback ",subtitle: "Edit your personal information")),
              InkWell(
                  onTap: (){
                    Navigator.of(context).pushNamed(HelpCenter.routename);
                  },
                  child: build_setting_tile(context: context,title: "Help ",subtitle: "Help us improve Zarkik")),
              InkWell(
                  onTap: ()async{
                    try{
                      final googleSignIn = GoogleSignIn();
                      await googleSignIn.signOut().then((value) {

                      });
                    }catch(error){

                    }

            FirebaseAuth _auth=  FirebaseAuth.instance;
            await _auth.signOut().then((value) {

bottom_index=0;
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Wrapper()),
                      (route)=>false
              );
            });
                  },
                  child: build_setting_tile(context: context,title: "Logout ",subtitle: "Find how to use the app")),


            ],
          ),
        ),


      ),
    );

  }
  Widget build_setting_tile({BuildContext ? context,String ?title,String ?subtitle,}){
    final width = MediaQuery.of(context!).size.width;
    final height = MediaQuery.of(context).size.height;
    return        ListTile(


      leading: CircleAvatar(
          radius: 25,
          backgroundColor: Color(0xffC3FAE8),
          child: Icon(Icons.person,color: mycolor)),
      title: Text(title!,style: _const.manrope_regular263238(18, FontWeight.w600)),
      subtitle: Text(subtitle!,style: _const.manrope_regular78909C(12, FontWeight.w400),),

    );
  }

}
