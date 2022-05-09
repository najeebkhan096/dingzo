import 'package:dingzo/Database/SociaMediaDatabase.dart';
import 'package:dingzo/Database/database.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/screens/chat/chat.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dingzo/model/myuser.dart';
class Conversation extends StatefulWidget {
  static const routename = "Conversation";

  @override
  State<Conversation> createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  final GlobalKey<ScaffoldState> _scaffoldKey2 = GlobalKey<ScaffoldState>();
  Constants _const=Constants();

Database _database=Database();

  @override
  void initState() {
    // TODO: implement initState
    current_index=3;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(

      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            height: height*0.2,
            width: width*1,
            decoration: BoxDecoration(
                color:  Color(0xffFFEA9D),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(40))
            ),
            child: Column(

              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Chat',style: _const.raleway_extrabold(30, FontWeight.w800),),
                SizedBox(height: height*0.025,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [

                    Container(
                      width: width*0.6,
                      height: height*0.06,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: TextField(

                        decoration: InputDecoration(
                            hintText: "",
                            border: InputBorder.none,
                      ),
                      ),
                    ),


                  ],
                ),

                SizedBox(height: height*0.03,),
              ],
            ),

          ),

          SizedBox(
            height: height * 0.02,
          ),
         FutureBuilder(
             future: _database.fetchusers(),
             builder: (BuildContext context,AsyncSnapshot<List<MyUser>> snapshot){
           return snapshot.connectionState==ConnectionState.waiting?
           SpinKitRotatingCircle(
             color: Colors.black,
             size: 50.0,
           ):
               (snapshot.hasData && snapshot.data!.length>0)?
               Container(
                 height: height * 1,
                 child:ListView.builder(
                     itemCount: snapshot.data!.length,
                     itemExtent: height*0.14,
                     itemBuilder: (context, index) {
                       return     InkWell(
                         onTap: (){
                    SocialMediaDatabase socialdatabase=SocialMediaDatabase();
                    socialdatabase
                               .getUserInfogetChats(snapshot
                               .data![index].uid
                               .toString())
                               .then((value) {
                             print(
                                 "so final chatroom id is " +
                                     value.toString());
                             Navigator.of(context).pushNamed(
                               Chat_Screen.routename,
                               arguments: [
                                 value.toString(),
                                 snapshot.data![index]
                               ],
                             );

                             //
                           });

                         },
                         child: Container(

                           margin: EdgeInsets.only(left: width*0.05,right: width*0.05,bottom: height*0.025),
                           child:   Row(
                             mainAxisAlignment: MainAxisAlignment.start,
                             children: [
                               (snapshot.data![index].imageurl==null || snapshot.data![index].imageurl!.isEmpty)?
                               Container(
                                 width: width*0.3,
                                 height: height*0.17,
                                 decoration: BoxDecoration(
                                     shape: BoxShape.circle,
                                 ),
                               child: Center(child: Text("No Image")),
                               ):
                               Container(
                                 width: width*0.3,
                                 height: height*0.17,
                                 decoration: BoxDecoration(
                                     shape: BoxShape.circle,
                                     image: DecorationImage(
                                         image: NetworkImage(snapshot.data![index].imageurl.toString())
                                     )
                                 ),
                               ),
                               Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [

                                   Container(
                                     // margin: EdgeInsets.only(left: width*0.025),
                                     width: width*0.565,
                                     child: Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [

                                             Text(snapshot.data![index].username
                                                 .toString(),style: _const.raleway_semi_black(20 ,FontWeight.w600)),

                                             SizedBox(height: height*0.02,),

                                             Text(snapshot.data![index].email
                                                 .toString(),
                                                 style: TextStyle(
                                                     color: Color(0xffC4C4C4),
                                                     fontSize: 12,
                                                     fontWeight: FontWeight.w600,
                                                     fontFamily: 'Raleway-SemiBold'
                                                 )),
                                           ],
                                         ),

                                       ],
                                     ),
                                   ),
                                 ],
                               ),






                             ],
                           ),
                         ),
                       );
                       // return ListTile(
                       //   onTap: () {
                       //
                       //
                       //   },
                       //   leading: CircleAvatar(
                       //     radius: 30,
                       //     backgroundImage: NetworkImage(
                       //         mycontacts[index].imageurl
                       //             .toString()),
                       //   ),
                       //   title: Text(mycontacts[index].name
                       //       .toString(),style: _const.raleway_semi_black(20 ,FontWeight.w600)),
                       //   subtitle: Text(mycontacts[index].email
                       //       .toString(),
                       //   style: TextStyle(
                       //     color: Color(0xffC4C4C4),
                       //     fontSize: 12,
                       //     fontWeight: FontWeight.w600,
                       //     fontFamily: 'Raleway-SemiBold'
                       //   ),
                       //   ),
                       // );
                     }),
               ):
                   Text("No User");
         }),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: Home_Bottom_Navigation_Bar(),
    );
  }
}
