import 'package:dingzo/Database/database.dart';
import 'package:dingzo/Database/product_database.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/hometesting.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/model/product.dart';
import 'package:dingzo/screens/SellItem.dart';
import 'package:dingzo/screens/detailscreen.dart';
import 'package:dingzo/screens/profile.dart';
import 'package:dingzo/screens/selling/SellingHome/SellingHomePage.dart';
import 'package:dingzo/screens/viewprofile.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SellingBottomBar extends StatefulWidget {

  static const routename="SellingBottomBar";

  @override
  State<SellingBottomBar> createState() => _SellingBottomBarState();
}

class _SellingBottomBarState extends State<SellingBottomBar> {
TextEditingController search_controller=TextEditingController();
  List<Product> myproducts=[];
List<Product> searched_products=[];
  List<Product> allproducts=[];
  bool fetched=false;
  int index=0;
  @override
  void dispose() {
    // TODO: implement dispose
    search_controller.dispose();
    super.dispose();
  }
  @override
  Future<void> didChangeDependencies() async {
    // TODO: implement didChangeDependencies

if(fetched==false){
  await productdatabase.fetch_all_requested_products().then((value) {

    allproducts=value;

    myproducts=allproducts;
if(mounted)
    setState(() {

      fetched=true;

    });

  });
}

    super.didChangeDependencies();
  }

@override
  void initState() {
    // TODO: implement initState
  bottom_index=2;
  super.initState();
  }
  Constants _const=Constants();

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return ListView(
      children: [



        SizedBox(height: height*0.025,),
        Container(
          margin: EdgeInsets.only(left: width*0.075,right: width*0.075),


          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: (){

                },
                child: Row(
                  children: [
                    Image.asset("images/location.png",width: width*0.15,height: height*0.035,),


                    Text(currentuser!.home_address!.first.address1! ,style: _const.raleway_regular_black(18, FontWeight.w600),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),



            ],
          ),
        ),

        SizedBox(height: height*0.03,),

        Row(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            InkWell(
              onTap: (){

                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return SellItem();
                }));
              },
              child: Container(
                height: height*0.075,
                width: width*0.65,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xff1A5A47)
                ),
                child: Center(
                  child: Text("Sell Now",
                    style: _const.poppin_white(20, FontWeight.w600),
                  ),
                ),
              ),
            ),

            SizedBox(width: width*0.025,),

            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return SocialProfile(currentuser!.uid);
                }));
              },
              child: Column(
                children: [
                  Image.asset("images/store.png",height: height*0.065,),
                  Text("View My shop",
                    style: TextStyle(
                        fontSize: 7,
                        color: Color(0xff3A4651)
                    ),
                  )
                ],
              ),
            )
          ],
        ),


        SizedBox(height: height*0.025,),
        Container(
          margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: height*0.06,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: blackbutton
                  ),
                  child: Center(
                    child: Text("View Drafts",
                      style: _const.poppin_white(13, FontWeight.w600),
                    ),
                  ),
                ),
              ),

              SizedBox(width: width*0.025,),

              Expanded(
                child: Container(
                  height: height*0.06,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: blackbutton
                  ),

                  child: InkWell(
                    onTap: (){

                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return SellingHomePage();
                      }));
                    },
                    child: Center(
                      child: Text("View my listing",
                        style: _const.poppin_white(13, FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: height*0.015,),
        Container(
          margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: height*0.06,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: blackbutton
                  ),
                  child: Center(
                    child: Text("View funds",
                      style: _const.poppin_white(13, FontWeight.w600),
                    ),
                  ),
                ),
              ),

              SizedBox(width: width*0.025,),

              Expanded(
                child: Container(
                  height: height*0.06,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: blackbutton
                  ),
                  child: Center(
                    child: Text("View my sales",
                      style: _const.poppin_white(13, FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: height*0.025,),

        Center(
          child: Text("Item Requests",
            style: _const.raleway_black_rgb(20, FontWeight.w700),
          ),

        ),
        SizedBox(height: height*0.025,),

        Center(
          child: Container(
            width: width*0.75,
            height: height*0.06,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Color(0xff2B2B2B),
                    width: 1
                ),
                borderRadius: BorderRadius.circular(20)
            ),
            child: TextField(

              keyboardType: TextInputType.multiline,
              onChanged: (item){
                List<Product> temp_prodsucts=searched_products.where((element) =>
                element.title!.toLowerCase().startsWith(item)
                    ||
                    element.description!.toLowerCase().startsWith(item)
                    ||
                    element.price!.toString().toLowerCase().startsWith(item)

                ).toList();
                if(item.isEmpty){
                  if(index==0){
                    setState(() {
                      myproducts=allproducts;
                    });
                  }
                  else if(index==1){
                    List<Product> newproducts=[];
                    allproducts.forEach((element) {
                      if(element.rent==true){
                        newproducts.add(element);
                      }
                    });
                    setState(() {
                      myproducts=newproducts;
                    });
                  }
                  else{
                    List<Product> newproducts=[];
                    allproducts.forEach((element) {
                      if(element.rent==false){
                        newproducts.add(element);
                      }
                    });
                    setState(() {
                      myproducts=newproducts;
                    });
                  }

                }
                else{
                  setState(() {
                    myproducts=temp_prodsucts;
                  });
                }
              },
              controller: search_controller,
              decoration: InputDecoration(
                  hintStyle: TextStyle(
                      color: Color(0xffCCCCCC),
                      fontSize: 16
                  ),
                  hintText: "Search for any request...",
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search,color: Color(0xff2B2B2B),)
              ),
            ),
          ),
        ),
        SizedBox(height: height*0.025,),

        Center(
            child: Text("Recent Item Requests",
              style: _const.raleway_regular_black(19, FontWeight.w700),
            )),
        SizedBox(height: height*0.015,),

        Center(
            child: Container(
              width: width*0.8,
              child: Text("Do you have this item? If you do, you can rent it or sell it to make money!",
                style: _const.raleway_regular_black(12, FontWeight.w700),
                textAlign: TextAlign.center,
              ),
            )),

        SizedBox(height: height*0.025,),
        Container(
          margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Expanded(
                child: InkWell(
                  onTap: (){
                    setState(() {
                      index=0;
                      myproducts=allproducts;

                    });
                    searched_products=myproducts;
                  },
                  child: Container(
                    height: height*0.04,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: index==0?mycolor:Color.fromRGBO(235, 235, 235, 0.8)
                    ),
                    child: Center(child: Text("All",style:     index==0?
                    _const.raleway_SemiBold_white(10, FontWeight.w600):
                    _const.raleway_rgb_textfield(10, FontWeight.w600),
                    )),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: (){
                    List<Product> newproducts=[];
                    allproducts.forEach((element) {
                      if(element.rent==true){
                        newproducts.add(element);
                      }
                    });

                    setState(() {
                      index=1;
                      myproducts=newproducts;

                    });
                    searched_products=myproducts;
                  },
                  child: Container(
                    height: height*0.04,
                    margin: EdgeInsets.only(left: width*0.015),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: index==1?mycolor:Color.fromRGBO(235, 235, 235, 0.8)
                    ),
                    child: Center(child: Text("Items for Rent",
                      style:     index==1?
                      _const.raleway_SemiBold_white(10, FontWeight.w600):
                      _const.raleway_rgb_textfield(10, FontWeight.w600),
                    )),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: (){
                    List<Product> newproducts=[];
                    allproducts.forEach((element) {
                      if(element.rent==false){
                        newproducts.add(element);
                      }
                    });

                    setState(() {
                      index=2;
                      myproducts=newproducts;
                      searched_products=myproducts;
                    });
                  },
                  child: Container(
                    height: height*0.04,
                    margin: EdgeInsets.only(left: width*0.015),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: index==2?mycolor:Color.fromRGBO(235, 235, 235, 0.8)
                    ),
                    child: Center(child: Text("Items for Sale",
                      style:
                      index==2?
                      _const.raleway_SemiBold_white(10, FontWeight.w600):
                      _const.raleway_rgb_textfield(10, FontWeight.w600),
                    )),
                  ),
                ),
              ),

            ],
          ),
        ),

        SizedBox(height: height*0.025,),
        fetched?



        Container(
          height: height*0.6,
          child:   GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: height*0.025,
                  crossAxisCount: 3,
                  mainAxisExtent: height*0.15

              ),

              itemCount: myproducts.length,
              itemBuilder: (context,index){

                return


                  Container(
                    margin: EdgeInsets.only(left: width*0.025),
                    width: width*0.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),

                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(

                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10)
                                ),
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(

                                        myproducts[index].photos!.length==0?
                                        "https://static1.anpoimages.com/wordpress/wp-content/uploads/2020/02/Our-5-favorite-universal-USB-C-Power-Delivery-chargers-for-all-your-gadgets-Hero.png"
                                            :
                                        myproducts[index].photos![0])
                                )
                            ),

                          ),
                          flex: 3,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: width*0.025,right: width*0.025),
                          child: Text(myproducts[index].title!.toString(),style: _const.poppin_black_rgb(12, FontWeight.w700),),
                        ),
                        Expanded(

                          child: Container(
                            margin: EdgeInsets.only(left: width*0.025,right: width*0.025),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(myproducts[index].price!.toString(),style: _const.poppin_black_rgb(12, FontWeight.w700),),
                                Icon(Icons.favorite_border,size: 14,color: Colors.black,)

                              ],

                            ),
                          ),

                          flex: 1,
                        )

                      ],
                    ),
                    height: height*0.05,

                  );

              }),
        ):

        Container(
            height: height*0.5,
            width: width*1,
            child: Center(child: Text("No Product ")))
        ,

        SizedBox(height: height*0.025,),

      ],
    );
  }
}
