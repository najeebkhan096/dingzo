import 'package:dingzo/constants.dart';
import 'package:dingzo/hometesting.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/screens/buying/BuyingHomePage.dart';
import 'package:dingzo/screens/editaddress.dart';
import 'package:dingzo/screens/editprofile.dart';
import 'package:dingzo/screens/helpcenter.dart';
import 'package:dingzo/screens/profile.dart';
import 'package:dingzo/screens/request_item/my_requests.dart';
import 'package:dingzo/screens/sellerAccountCreation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:dingzo/screens/selling/SellingHome/SellingHomePage.dart';
import 'package:dingzo/screens/setting.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:dingzo/wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ViewProfile extends StatefulWidget {
  static const routename="ViewProfile";
  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  late BannerAd _bannerAd;
  bool ad_loaded=false;
  _initBannerAd(){
    _bannerAd= BannerAd(
      adUnitId: 'ca-app-pub-9207548761153845/1202976546',
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
          onAdLoaded: (ad){

            setState(() {
              ad_loaded=true;
            });
          },
          onAdFailedToLoad: (ad,error){
            print("error is "+error.toString());
          }
      ),
    );
    _bannerAd.load();
  }

  void _addressdialogue() {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Alert'),
          content: Text("Please provide courier Address"),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: () {

                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return EditAddress();
                }));
              },
            )
          ],
        ));
  }
  int tabindex = 0;

  Constants _const = Constants();

  @override
  void initState() {
    // TODO: implement initState
    bottom_index=4;
    _controller = TabController(length: 2, vsync: this);
    super.initState();
    _initBannerAd();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [

          SizedBox(height: height*0.025,),

            builprofiletile(context),



          // SizedBox(height: height*0.05,),
          // buildtransfer(),





          SizedBox(height: height*0.025,),
          Divider(),
          SizedBox(height: height*0.025,),

      Container(
          margin: EdgeInsets.only(left: width*0.05),
          child: Text("Manage accounts",style: _const.manrope_regular263238(18, FontWeight.w700),)),

          build_manage_accounts_tile(
            title: "How To Use Supozo",
            subtitle: "Edit Your Personal Information"
          ),


          InkWell(
            onTap: (){

              Navigator.push(context, MaterialPageRoute(builder: (context){
                return BuyingHomePage();
              }));
            },
            child: build_manage_accounts_tile(
                title: "My Orders",
                subtitle: "Your Orders"
            ),
          ),
          InkWell(

            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return SellingHomePage();
              }));

              // currentuser!.accountcreated!?
              //         (currentuser!.address!.address1.toString().isEmpty )?
              //         _addressdialogue():
              //         Navigator.of(context).pushNamed(SellingHomePage.routename):
              //
              //         Navigator.of(context).pushNamed(AccountCreation.routename);
            },

            child: build_manage_accounts_tile(
                title: "My Listing",
                subtitle: "Edit Your Personal Information"
            ),
          ),


          InkWell(
            onTap: (){

              Navigator.push(context, MaterialPageRoute(builder: (context){
                return My_Request_Items();
              }));

            },
            child: build_manage_accounts_tile(
                title: "My Item Requests",
                subtitle: "Edit Your Personal Information"
            ),
          ),
          InkWell(
            onTap: (){

              Navigator.push(context, MaterialPageRoute(builder: (context){
                return Setting();
              }));

            },
            child: build_manage_accounts_tile(
                title: "Settings",
                subtitle: "Edit Your Personal Information"
            ),
          ),


          InkWell(
            onTap: (){

              Navigator.push(context, MaterialPageRoute(builder: (context){
                return HelpCenter();
              }));
            },
            child: build_manage_accounts_tile(
                title: "Help Center",
                subtitle: "Edit Your Personal Information"
            ),
          ),

       SizedBox(height: height*0.1,),

         if( ad_loaded)

          Container(

            margin: EdgeInsets.only(left: width*0.025),
            width: width*0.38,
            child:   Container(
              alignment: Alignment.center,
              child: AdWidget(ad: _bannerAd),
              width: _bannerAd.size.width.toDouble(),
              height: _bannerAd.size.height.toDouble(),
            ),
            height: height*0.2,

          )

        ],
      ),

    );
  }
  Widget buildtransfer(){
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return    Container(
      height: height*0.08,
      width: width*1,
      margin: EdgeInsets.only(left: width*0.1,right: width*0.1),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: mycolor
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Transfer funds",style:_const.raleway_1A5A47(20, FontWeight.w700)),

          Text("\$0",style: _const.raleway_SemiBold_white(20, FontWeight.w700),)
        ],
      ),
    );
  }

  Widget build_manage_accounts_tile({String ?title,String ?subtitle,}){
    final width = MediaQuery.of(context).size.width;
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


Widget builprofiletile(BuildContext context){
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          InkWell(
              onTap: (){

                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return EditProfile();
                }));
              },
              child: Icon(Icons.edit_outlined,color: Color(0xff3A4651))),
          SizedBox(width: width*0.025,),
          ( currentuser==null || currentuser!.imageurl==null || currentuser!.imageurl!.isEmpty)?
          CircleAvatar(
            radius: 35,
            child: Text("No Image",style: TextStyle(fontSize: 10)),
          ):
          Container(
            child: CircleAvatar(
              radius: 32,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage( currentuser!.imageurl.toString()),
            ),
          ),
          SizedBox(width: width*0.025,),
          Container(
            width: width*0.45,

            child:   Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(currentuser!=null)

                  Text(currentuser!.username.toString(),
                      style:
                      _const.manrope_regular263238(18, FontWeight.w700)),
                if(currentuser!=null)

                  Container(
                    width: width*0.45,
                    child: Text("User ID:"+currentuser!.uid .toString(),
                        maxLines: 1,
                        overflow: TextOverflow.visible,
                        style:
                        _const.manrope_regular607D8B(14, FontWeight.w700)),
                  ),

              ],
            ),
          ),
          SizedBox(width: width*0.025,),

          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return SocialProfile(currentuser!.uid);
              }));
            },
            child: Image.asset('images/store.png',height: height*0.05,)
          )

        ],
      ),
    );
}
}
