import 'dart:convert';
import 'package:dingzo/Database/notification.dart';
import 'package:dingzo/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationScreen extends StatefulWidget {

  static const routename = "NotificationScreen";
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>  with SingleTickerProviderStateMixin{
  @override
  Color active = Colors.green;
  Color inactive = Color(0xffF9F9F9);
  bool isrecieved = true;

  Constants _const=Constants();

  @override


  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: height*1,
            child: Column(

              children: [

                SizedBox(height: height*0.025,),
                StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('Notification').snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return SpinKitCircle(
                          color: Colors.black,
                        );
                      if (!snapshot.hasData) return const Text('No Notification');
                      List<SendNotification> ?  new_notification=[];
                      try{
                        List<QueryDocumentSnapshot?> mydocs = snapshot.data!.docs.toList();

                        if(mydocs.length>0){
                          mydocs.forEach((fetcheddata) {

                            print("step1 "+mydocs.toString());
                            new_notification.add(SendNotification(
                                title:
                                fetcheddata!['title'].toString(),
                                description: fetcheddata['description'].toString(),
                                image:
                                fetcheddata['image_url'].toString(),
                                item_name:
                                fetcheddata['item_name'].toString(),
                                date: DateTime.parse(fetcheddata['date'])

                            ));
                            print("step2 "+mydocs.toString());
                          });
                        }

                      }catch(error){

                        print("No Notification");
                      }




                      return
                        new_notification.isEmpty?

                        Column(
                          children: [
                            Container(
                                height: height*0.65,
                                width: width*1,

                                child: Center(child: Text("No Data",style: _const.manrope_regular78909C(15, FontWeight.w700),))),
                          ],
                        ):
                        Column(

                            children:List.generate(new_notification.length, (index) =>       Container(

                              margin: EdgeInsets.only(left: width*0.05,right: width*0.05,bottom: height*0.025),
                              child:   Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [

                                  Container(
                                    width: width*0.3,
                                    height: height*0.17,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: NetworkImage(new_notification[index].image!)
                                        )
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: height*0.03,
                                        width: width*0.6,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [


                                            Text(new_notification[index].date!.toString(),style: TextStyle(color: Color(0xffC4C4C4),fontFamily: 'Raleway-SemiBold',fontSize: height*0.02,fontWeight: FontWeight.w600)),
                                            Text("")

                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: width*0.025),
                                        width: width*0.565,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [

                                                Container(
                                                    width: width*0.5,
                                                    child: Text(new_notification[index].title!,style: _const.raleway_regular_darkbrown(18, FontWeight.w700))),

                                                SizedBox(height: height*0.01,),

                                                Text(new_notification[index].description!,style: _const.raleway_263238(15, FontWeight.w600),),

                                                // Container(
                                                //   height: height*0.04,
                                                //   width: width*0.25,
                                                //   padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                                                //   decoration: BoxDecoration(
                                                //       color: Color(0xff9E772A),
                                                //       borderRadius: BorderRadius.circular(10)
                                                //   ),
                                                //   child: Center(child: Text("View Sale",style:_const.raleway_SemiBold_white(12, FontWeight.w600),)),
                                                // ),

                                              ],
                                            ),
                                            // Image.asset('images/icons8-shopping-bag-90 1.png')
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),






                                ],
                              ),
                            ),
                            )
                        );
                    }),





              ],
            ),
          ),
        ));
  }
}
