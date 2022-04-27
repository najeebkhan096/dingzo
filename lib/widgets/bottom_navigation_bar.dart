import 'package:dingzo/screens/chat/conversation.dart';
import 'package:dingzo/screens/home.dart';
import 'package:dingzo/screens/notification.dart';
import 'package:dingzo/screens/viewprofile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';



int current_index=0;
class Home_Bottom_Navigation_Bar extends StatefulWidget {
  const Home_Bottom_Navigation_Bar({Key? key}) : super(key: key);

  @override
  State<Home_Bottom_Navigation_Bar> createState() => _Home_Bottom_Navigation_BarState();
}

class _Home_Bottom_Navigation_BarState extends State<Home_Bottom_Navigation_Bar> {
  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
      ),
      child: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        animationDuration: Duration(seconds: 3),
        height: MediaQuery.of(context).size.height*0.12,
        selectedIndex: current_index,
        onDestinationSelected: (index){
          setState(() {
            current_index=index;
          });
          if(current_index==0){
            Navigator.of(context).pushNamed(HomeScreen.routename);
          }
          if(current_index==1){
            Navigator.of(context).pushNamed(NotificationScreen.routename);


          }
          if(current_index==2){

          }

          if(current_index==3){

            Navigator.of(context).pushNamed(Conversation.routename);
          }

          if(current_index==4){
          Navigator.of(context).pushNamed(ViewProfile.routename);
          }
          print(current_index);
        },
        backgroundColor: Colors.white,
        destinations: [

          NavigationDestination( icon:  Image.asset('images/home.png',height:  MediaQuery.of(context).size.height*0.035,color: Color(0xff5F5F5F),),

            label: "",),
          NavigationDestination( icon:  Image.asset('images/notification.png',height:  MediaQuery.of(context).size.height*0.035,color: Color(0xff5F5F5F),),

            label: "",),

          NavigationDestination( icon:
          Image.asset('images/basic.png',height:  MediaQuery.of(context).size.height*0.035,color: Color(0xff5F5F5F),),


              label: ""),

          NavigationDestination( icon:  Image.asset('images/messaging.png',height:  MediaQuery.of(context).size.height*0.035,color: Color(0xff5F5F5F),),
            label: "",),



          NavigationDestination( icon:  Image.asset('images/user.png',height:  MediaQuery.of(context).size.height*0.035,color: Color(0xff5F5F5F),) ,label: ""),

        ],
      ),
    );
  }
}

