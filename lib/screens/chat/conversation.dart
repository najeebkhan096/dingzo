import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/screens/chat/chat.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Conversation extends StatefulWidget {
  static const routename = "Conversation";

  @override
  State<Conversation> createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  final GlobalKey<ScaffoldState> _scaffoldKey2 = GlobalKey<ScaffoldState>();
  Constants _const=Constants();
  List<MyUser> mycontacts=[
  MyUser(username: "najeeb khan",email: "najeeb@gmail.com",imageurl: "https://tse1.mm.bing.net/th?id=OIP.23gnJYIxRYyTnacDs2mUXQHaHa&pid=Api&P=0&w=176&h=176"),
  MyUser(username: "Ali",email: "ali@gmail.com",imageurl: "https://tse4.mm.bing.net/th?id=OIP.R6g_5Iq5uNtt9Fu8KSTzSwHaHa&pid=Api&P=0&w=166&h=166"),
  MyUser(username: "Imran khan",email: "imran@gmail.com",imageurl: "https://tse3.mm.bing.net/th?id=OIP.WzgXUNJ2JoQgiTV19D_n6QEyDM&pid=Api&P=0&w=276&h=184"),
];

  @override
  void initState() {
    // TODO: implement initState
    current_index=1;
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
          Container(
            height: height * 1,
            child:ListView.builder(
                itemCount: mycontacts.length,
                itemExtent: height*0.14,
                itemBuilder: (context, index) {
                 return     InkWell(
                   onTap: (){
                     Navigator.of(context).pushNamed(
                       Chat_Screen.routename,
                       arguments: mycontacts[index]
                     );
                   },
                   child: Container(

                     margin: EdgeInsets.only(left: width*0.05,right: width*0.05,bottom: height*0.025),
                     child:   Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [

                         Container(
                           width: width*0.3,
                           height: height*0.17,
                           decoration: BoxDecoration(
                             shape: BoxShape.circle,
                               image: DecorationImage(
                                   image: NetworkImage(mycontacts[index].imageurl.toString())
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

                                       Text(mycontacts[index].username
                                               .toString(),style: _const.raleway_semi_black(20 ,FontWeight.w600)),

                                       SizedBox(height: height*0.02,),

                                       Text(mycontacts[index].email
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
          ),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: Home_Bottom_Navigation_Bar(),
    );
  }
}
