import 'package:dingzo/Database/database.dart';
import 'package:dingzo/location/google_places_api.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/screens/editaddress.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dingzo/constants.dart';
import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
static const routename="LocationScreen";

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  Constants _const=Constants();

@override
  void dispose() {
    // TODO: implement dispose

  super.dispose();
  database.update_filter_distance();
}

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        leading: Container(
          padding: EdgeInsets.all(12),
            margin: EdgeInsets.only(left: width*0.05),
            child: InkWell(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: SvgPicture.asset('images/back.svg',width: width*0.025,color: mycolor))),
        title:  Text("Location" ,style: _const.poppin_SemiBold(18, FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(
        children: [

          SizedBox(height: height*0.025,),

InkWell(
  onTap: (){
    Navigator.of(context).pushNamed(GoogleMapsScreenApi.routename);
  },
  child:   Container(



    width: width*1,

    margin: EdgeInsets.only(left: width*0.05,right: width*0.05),

    padding: EdgeInsets.only(left: width*0.05,right: width*0.05,top: height*0.025,bottom: height*0.025),

    decoration: BoxDecoration(

      border: Border.all(

        color: Colors.black,

        width: 0.5

      )

    ),

    child: Column(

      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        Text("Zipcode",style: _const.poppin_SemiBold(16, FontWeight.w600),),



        Row(

          mainAxisAlignment: MainAxisAlignment.start,

          children: [

            Container(

              width: width*0.6,

              child: Text(currentuser!.home_address!.first.address1!+","+currentuser!.home_address!.first.state!+

                ","+currentuser!.home_address!.first.city!+

                ","+currentuser!.home_address!.first.zipcode!

                ,style: _const.poppin_SemiBold(16, FontWeight.w600),),

            ),





            InkWell(

              onTap: (){

                Navigator.of(context).pushNamed(EditAddress.routename);

              },

              child: Container(

                  margin: EdgeInsets.only(left: width*0.05),

                  child: SvgPicture.asset('images/farward.svg',width: width*0.05,color: mycolor)),

            ),



          ],

        ),

      ],

    ),

  ),
),

          SizedBox(height: height*0.025,),

          Container(

            width: width*1,
            margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
            padding: EdgeInsets.only(left: width*0.05,right: width*0.05,top: height*0.025,bottom: height*0.025),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black,
                    width: 0.5
                )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Local Distance",style: _const.poppin_SemiBold(18, FontWeight.w600),),

                SizedBox(height: height*0.025,),

                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    valueIndicatorColor: Color(0xff252B42), // This is what you are asking for
               
                  ),
                  child: Slider(
                    divisions: 100,

                    label: "${currentuser!.filter_distance} Miles",
                  semanticFormatterCallback: (double val){
                      return "value ";
                  },
                  onChanged: (value){

setState(() {
  currentuser!.filter_distance=value.toInt();
});
                  },
                    value: currentuser!.filter_distance!.toDouble(),
                    max: 100,
                      min: 1,

                  ),
                ),
              ],
            ),
          ),


        ],
      ),
    );
  }
}
