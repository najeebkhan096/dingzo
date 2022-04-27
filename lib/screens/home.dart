import 'package:dingzo/Database/database.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/screens/cart.dart';
import 'package:dingzo/screens/categories.dart';
import 'package:dingzo/screens/mylikes.dart';
import 'package:dingzo/screens/newest.dart';
import 'package:dingzo/screens/searchpage.dart';
import 'package:dingzo/screens/shirts.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  static const routename="HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Constants _const=Constants();

List categ=[
  {
    'image':"images/icons8-shirt-64 1.png",
    'title':"Music"
  },
  {
    'image':"images/hobby icon.png",
    'title':"Memorabilla"
  },
  // {
  //   'image':"images/beauty care logo.png",
  //   'title':"Beauty"
  // },
  // {
  //   'image':"images/icons8-lamp-96 1.png",
  //   'title':"Rooms"
  // },
  // {
  //   'image':"images/icons8-lamp-96 1.png",
  //   'title':"Rooms"
  // }

];

bool fetched=false;
Database _database=Database();




  @override
  Future<void> didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    if(fetched==false){

      await _database.fetchprofiledata(DesiredUserID: user_id).then((value) async{

        currentuser=value;

        user_docid=currentuser!.doc!;

      });

    }

  }
@override
  void initState() {
    // TODO: implement initState
  current_index=0;
  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Container(
          height: height*1.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: height*0.45,
                width: width*1,
                decoration: BoxDecoration(
                    color:  Color(0xffFFEA9D),
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(40))
                ),
                child: Column(

                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [

                        SizedBox(width: width*0.05,),
                        InkWell(
                          onTap: (){
                         },
                          child: Container(
                            width: width*0.75,
                            height: height*0.06,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)
                            ),
                          child: TextField(
onTap: (){
  Navigator.of(context).pushNamed(SearchPage.routename);

},
                            decoration: InputDecoration(
                            hintText: "Search",
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.search,color: Colors.blue,)
                            ),
                          ),
                          ),
                        ),
                        SizedBox(width: width*0.025,),
                        InkWell(
                            onTap: (){
                              Navigator.of(context).pushNamed(CartScreen.routename);

                            },
                            child: Image.asset('images/cart.png',))
                      ],
                    ),
                    SizedBox(height: height*0.025,),
                    Container(
                      margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
                      height: height*0.25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("images/homeproduct.jpg")
                        )
                      ),
                    ),

                    SizedBox(height: height*0.03,),
                  ],
                ),

              ),

SizedBox(height: height*0.025,),
              Container(
                margin: EdgeInsets.only(right: width*0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(""),
                    Text("Category",style: _const.poppin_light_brown(20, FontWeight.w600  ),)
                  ,
                    InkWell(
                        onTap: (){
                          Navigator.of(context).pushNamed(CategoriesScreen.routename);

                        },
                        child: Text("See all",style: _const.poppin_dark_brown(10, FontWeight.w600),))

                  ],
                ),
              ),
              SizedBox(height: height*0.025,),
              Container(

                height: height*0.14,
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(categ.length, (index) =>  InkWell(
                      onTap: (){
                        Navigator.of(context).pushNamed(Shirts_Screen.routename,arguments: categ[index]['title']);
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: width*0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: height*0.1,
                              width: width*0.15,
                              decoration: BoxDecoration(
                                  color: Color(0xffF9F6EC),
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: AssetImage(categ[index]['image'])
                                  )
                              ),
                            ),
                            Text(categ[index]['title'],style: _const.poppin_dark_brown(10, FontWeight.w600),)
                          ],
                        ),
                      ),
                    ),)
                ),
              )
          ,SizedBox(height: height*0.02,),
              Container(
                  margin: EdgeInsets.only(left: width*0.05),

                  child: Text("My Likes",style: _const.poppin_dark_brown(20, FontWeight.w600  ),))
              ,SizedBox(height: height*0.01,),


              Container(
                height: height*0.2,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(8, (index) => InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed(MyLikes.routename);
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: width*0.025),
                      width: width*0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:Color(0xffEFB546),


                      ),
                      child: Column(
                        children: [
                          Expanded(

                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage('images/categ.png')
                                  )
                              ),

                            ),
                            flex: 3,
                          ),
                          Expanded(

                            child: Container(
                              margin: EdgeInsets.only(left: width*0.025,right: width*0.025),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("\$20",style: _const.poppin_Regualr(12, FontWeight.w700),),
                                  Icon(Icons.favorite_border,size: 14,)
                                ],

                              ),
                            ),

                            flex: 1,
                          )

                        ],
                      ),
                      height: height*0.2,

                    ),
                  ),),
                ),
              ),

          SizedBox(height: height*0.02,),
        Container(
            margin: EdgeInsets.only(left: width*0.05),

            child: Text("Recently Viewed",style: _const.poppin_dark_brown(20, FontWeight.w600  ),))
        ,SizedBox(height: height*0.01,),


        Container(
          height: height*0.2,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(8, (index) => Container(
              margin: EdgeInsets.only(left: width*0.025),
              width: width*0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color:Color(0xffEFB546),


              ),
              child: Column(
                children: [
                  Expanded(

                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('images/categ.png')
                          )
                      ),

                    ),
                    flex: 3,
                  ),
                  Expanded(

                    child: Container(
                      margin: EdgeInsets.only(left: width*0.025,right: width*0.025),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("\$20",style: _const.poppin_Regualr(12, FontWeight.w700),),
                          Icon(Icons.favorite_border,size: 14,)
                        ],

                      ),
                    ),

                    flex: 1,
                  )

                ],
              ),
              height: height*0.2,

            ),),
          ),
        ),

              //newest
          SizedBox(height: height*0.02,),
        Container(
            margin: EdgeInsets.only(left: width*0.05),

            child: Text("Newest",style: _const.poppin_dark_brown(20, FontWeight.w600  ),))
        ,SizedBox(height: height*0.01,),


        Container(
          height: height*0.2,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(8, (index) => InkWell(
              onTap: (){
                Navigator.of(context).pushNamed(NewestPage.routename);

              },
              child: Container(
                margin: EdgeInsets.only(left: width*0.025),
                width: width*0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color:Color(0xffEFB546),


                ),
                child: Column(
                  children: [
                    Expanded(

                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('images/categ.png')
                            )
                        ),

                      ),
                      flex: 3,
                    ),
                    Expanded(

                      child: Container(
                        margin: EdgeInsets.only(left: width*0.025,right: width*0.025),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("\$20",style: _const.poppin_Regualr(12, FontWeight.w700),),
                            Icon(Icons.favorite_border,size: 14,)
                          ],

                        ),
                      ),

                      flex: 1,
                    )

                  ],
                ),
                height: height*0.2,

              ),
            ),),
          ),
        ),



        ],
          ),
        ),
      ),
    bottomNavigationBar: Home_Bottom_Navigation_Bar(),
    );
  }
}
