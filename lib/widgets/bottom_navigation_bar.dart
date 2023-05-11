import 'package:dingzo/constants.dart';
import 'package:dingzo/hometesting.dart';
import 'package:dingzo/screens/chat/conversation.dart';
import 'package:dingzo/screens/home.dart';
import 'package:dingzo/screens/notification.dart';
import 'package:dingzo/screens/selling/selling_bottom_bar.dart';
import 'package:dingzo/screens/viewprofile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';


int current_index=0;
class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;

    return Container(
      height: MediaQuery.of(context).size.height*0.09,
      width: width*1,
      decoration: BoxDecoration(
        color: Colors.white, ),
      padding: EdgeInsets.only(left: width*0.025,right: width*0.025),
      child: GNav(
        curve: Curves.fastOutSlowIn,
        duration: Duration(milliseconds: 1),

        haptic: true, // haptic feedback
        tabBorderRadius: 15,

        gap: 8, // the tab button gap between icon and text
        color: Colors.grey[800], // unselected icon color
        activeColor: mycolor, // selected icon and text color
        iconSize: 24, // tab button icon size
        tabBackgroundColor: mycolor.withOpacity(0.1), // selected tab background color
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tabs: [
          GButton(

            icon: LineIcons.home,
            iconColor: Colors.black,

            iconActiveColor: mycolor,
            textColor: mycolor,
            backgroundColor: mycolor.withOpacity(0.2),
           

          ),
          GButton(

            icon: LineIcons.bell,
            iconColor: Colors.black,

            iconActiveColor: mycolor,
            textColor: mycolor,
            backgroundColor: mycolor.withOpacity(0.2),

          ),
          GButton(

            icon: LineIcons.tag,
            iconColor: Colors.black,

            iconActiveColor: mycolor,
            textColor: mycolor,
            backgroundColor: mycolor.withOpacity(0.2),

          ),
          GButton(
      
            icon: LineIcons.facebookMessenger,
            iconColor: Colors.black,

            iconActiveColor: mycolor,
            textColor: mycolor,
            backgroundColor: mycolor.withOpacity(0.2),
          ),
          GButton(

            icon: LineIcons.user,
            iconColor: Colors.black,

            iconActiveColor: mycolor,
            textColor: mycolor,
            backgroundColor: mycolor.withOpacity(0.2),

          ),
        ],
        selectedIndex: bottom_index,
        onTabChange: (index){
        
          setState(() {
            bottom_index =index;
          });


          bottom_controller.jumpToPage(index);

        },
      ),
    );
    // return NavigationBarTheme(
    //   data: NavigationBarThemeData(
    //   ),
    //   child: NavigationBar(
    //     labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
    //     animationDuration: Duration(seconds: 3),
    //     height: MediaQuery.of(context).size.height*0.12,
    //     selectedIndex: current_index,
    //     onDestinationSelected: (index){
    //       setState(() {
    //         current_index=index;
    //       });
    //       if(current_index==0){
    //         Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.routename, (route) => false);
    //       }
    //       if(current_index==1){
    //
    //
    //         Navigator.of(context).pushNamedAndRemoveUntil(NotificationScreen.routename, (route) => false);
    //       }
    //       if(current_index==2){
    //
    //
    //         Navigator.of(context).pushNamedAndRemoveUntil(SellingBottomBar.routename, (route) => false);
    //       }
    //       if(current_index==3){
    //
    //
    //         Navigator.of(context).pushNamedAndRemoveUntil(Conversation.routename, (route) => false);
    //       }
    //
    //       if(current_index==4){
    //
    //       Navigator.of(context).pushNamedAndRemoveUntil(ViewProfile.routename, (route) => false);
    //       }
    //       print(current_index);
    //     },
    //     backgroundColor: Colors.white,
    //     destinations: [
    //
    //       NavigationDestination( icon:  Image.asset('images/home.png'
    //
    //         ,height:  MediaQuery.of(context).size.height*0.035,color:
    //   current_index==0?mycolor:
    // Color(0xff5F5F5F),),
    //
    //         label: "",),
    //       NavigationDestination( icon:  Image.asset('images/notification.png',height:  MediaQuery.of(context).size.height*0.035,color:
    //       current_index==1?mycolor:
    //       Color(0xff5F5F5F),),
    //
    //         label: "",),
    //       NavigationDestination( icon:  Image.asset('images/coolicon.png',height:  MediaQuery.of(context).size.height*0.035,color:
    //       current_index==2?mycolor:
    //       Color(0xff5F5F5F),),
    //
    //         label: "",),
    //
    //
    //       NavigationDestination( icon:  Image.asset('images/messaging.png',height:  MediaQuery.of(context).size.height*0.035,color:
    //       current_index==3?mycolor:
    //       Color(0xff5F5F5F),),
    //         label: "",),
    //
    //
    //
    //       NavigationDestination( icon:  Image.asset('images/user.png',height:  MediaQuery.of(context).size.height*0.035,color:
    //       current_index==4?mycolor:
    //       Color(0xff5F5F5F),) ,label: ""),
    //
    //     ],
    //   ),
    // );
  }
}

