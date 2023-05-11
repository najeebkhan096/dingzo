import 'package:dingzo/screens/feedback.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:dingzo/Database/feedback.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/screens/checkout.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
class Feedback2 extends StatefulWidget {
  static const routename="Feedback2";

  @override
  State<Feedback2> createState() => _Feedback2State();
}

class _Feedback2State extends State<Feedback2> {
  Constants _const=Constants();

  double rating=0;

  List<String> categ=[
    'How Buying Works',
    'Return Item',
    'Item has Not Arrived',
    'Paying for him',
    'Check status of chase',
    'Shipping/Delivery',
    'How to cancel an Order',
    'Other'


  ];

  String ? title;

 bool isloading=false;

  final GlobalKey<FormState> _formkey=GlobalKey();

  Future<void> submit() async {
    if(!_formkey.currentState!.validate())
      return null;
 _formkey.currentState!.save();
 setState((){
   isloading=true;
 });
   await  feedbackdatabase.post_feedback(
        feedback: Feedback_Module(
            title: title,
            userid: currentuser!.uid,
            rating: rating
        )
    ).then((value) {
     setState((){
       isloading=false;
     });
  Navigator.of(context).pushReplacementNamed(FeedbackScreen.routename).then((value) {
    Navigator.of(context).pop();
  });
   });
  }

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return Scaffold(

      backgroundColor: Colors.white,

      appBar: AppBar(

        leadingWidth: width*0.3,

        backgroundColor: Colors.white,

        centerTitle: true,

        title: Text("Feedback",style: _const.raleway_263238(20, FontWeight.w700),

          textAlign: TextAlign.center,

        ),

        actions: [

        ],
      ),
      body: ListView(
        children: [

          SizedBox(height: height*0.05,),
          Center(child: Text("Contact Us",style: _const.poppin_BlackBold(27, FontWeight.w800),)),
          SizedBox(height: height*0.05,),
          Container(
              width: width*1,
              margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

              decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(15)
              ),
              child: Text("Please tell us how you think of the app so we can make it better for you!",style: _const.poppin_SemiBold(20, FontWeight.w400),textAlign: TextAlign.center,)
          ),

          SizedBox(height: height*0.025,),
          Center(
            child: RatingBar.builder(
              initialRating: 3,
              itemSize: 50,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: mycolor,
              ),
              onRatingUpdate: (rate) {
                print(rate);
                rating=rate;
              },
            ),
          ),
          SizedBox(height: height*0.025,),
          Form(
            key: _formkey,
            child: Container(
              margin: EdgeInsets.only(left: width*0.05,right: width*0.05),

              height: height*0.2,
              width: width*1,
              decoration: BoxDecoration(
                  color: Color(0xffBCEFE0),
                  borderRadius: BorderRadius.circular(15)
              ),

              child: TextFormField(
                style:  _const.poppin_BlackBold(12, FontWeight.w400),
                onSaved: (value){
                  title=value;
                },
                onFieldSubmitted: (value){
                  title=value;
                },
                decoration: InputDecoration(
                    hintText: "Add Details...",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: width*0.05),
                    hintStyle: TextStyle(
                        color: mycolor,
                        fontFamily: 'Raleway-SemiBold',
                        fontWeight: FontWeight.w600,
                        fontSize: 16
                    )
                ),
              ),
            ),
          ),



          SizedBox(height: height*0.025,),


isloading?
    SpinKitRing(color: mycolor)
    :
          InkWell(
            onTap: (){
             submit();
            },
            child: Container(
              height: height*0.055,
              width: width*1,
              margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

              padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
              decoration: BoxDecoration(
                  color: mycolor,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(child: Text("Submit",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
            ),
          ),

          SizedBox(height: height*0.05,),

        ],
      ),

    );
  }
}
