import 'package:dingzo/Database/database.dart';
import 'package:dingzo/Database/product_database.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/model/product.dart';
import 'package:dingzo/screens/searchpage.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';


class SearchProducts_Screen extends StatefulWidget {
  static const routename = "SearchProducts_Screen";

  @override
  State<SearchProducts_Screen> createState() => _SearchProducts_ScreenState();
}

class _SearchProducts_ScreenState extends State<SearchProducts_Screen> {
  final GlobalKey<ScaffoldState> _scaffoldKey2 = GlobalKey<ScaffoldState>();



Constants _const=Constants();
  bool fetcheddata=false;

  List<Product> myproducts=[];
  List<String> suggestedproducts=[];
  List<String> recentproducts=[];
bool temp=false;
  List<String> savedproducts=[];
  int currentindex=0;
  @override
  Future<void> didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    if(fetcheddata==false){
      suggestedproducts=[];
      await productdatabase.fetch_requested_products().then((value) async{
        myproducts=[];
      myproducts=value;
      print("randi "+myproducts.length.toString());
      savedproducts=await database.fetch_saerch_history(DesiredUserID: currentuser!.uid);
      recentproducts=await database.fetch_recent_saerch_history(DesiredUserID: currentuser!.uid);
      suggestedproducts=[];
      myproducts.forEach((element) {

        if(!suggestedproducts.contains(element.title)){
          suggestedproducts.add(element.title!);
        }
      });

      setState((){

        fetcheddata=true;

      } );
      });



    }
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
print("data is "+recentproducts.toString());
    return GestureDetector(

      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(

        appBar: AppBar(
          elevation: 0,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          leadingWidth: width*0.18,
          leading: Container(

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(onPressed: (){
                  Navigator.of(context).pop();

                }, icon: Icon(Icons.arrow_back_ios,color: Color(0xff3A4651),)),
              ],
            ),
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: Colors.white,

            // Status bar brightness (optional)
            statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          title:  Container(

            child: Container(
              width: width*1,
              height: height*0.05,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: Colors.black,
                      width: 0.5
                  ),
                  borderRadius: BorderRadius.circular(20)),
alignment: Alignment.centerLeft,
              child: TextField(
                textAlignVertical: TextAlignVertical.center,
                  style: TextStyle(
                      color: Colors.black
                  ),
                  onChanged: (value){
                    setState((){
                      if(value.length>0){
                        temp=true;
                        List<Product> tempprods=myproducts.where((element) =>
                        (
                            element.title!.toLowerCase().startsWith(value)

                        ||
                                element.price!.toString().toLowerCase().startsWith(value)

                        ||
                                element.description!.toLowerCase().startsWith(value)
                        )

                        ).toList();
                        suggestedproducts=[];
                        tempprods.forEach((element) {
                          if(element.title.toString().startsWith(value)){
                            suggestedproducts.add(element.title!);
                          }
                          else if(element.description.toString().startsWith(value)){
                            suggestedproducts.add(element.description!);
                          }

                        });
                      }
                      else{
                        temp=false;
                        if(currentindex==0){
                          suggestedproducts=[];
                          myproducts.forEach((element) {
                            if(element.title.toString().startsWith(value)){
                              suggestedproducts.add(element.title!);
                            }
                            else if(element.description.toString().startsWith(value)){
                              suggestedproducts.add(element.description!);
                            }
                          });

                        }else if(currentindex==1){
                          suggestedproducts=recentproducts;
                        }
                        else{
                          suggestedproducts=savedproducts;
                        }
                      }

                    });
                  },

                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search, color: Color(0xff2B2B2B),),
                    hintStyle:
                    TextStyle(fontSize: 14,color: Color(0xffCCCCCC),),
                  )
              ),
            ),
          ),
          centerTitle: false,

          actions: [

          ],
        ),

        backgroundColor: Colors.white,
        body:
        fetcheddata==false?
        SpinKitCircle(
          color: mycolor,
        )

            :

        ListView(

          children: [

            SizedBox(height: height*0.015,),
            Container(
              margin: EdgeInsets.only(left: width*0.025,right: width*0.075),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  InkWell(
                    onTap: (){
                      setState(() {
                        currentindex=0;
                        suggestedproducts=[];
                        myproducts.forEach((element) {
                          suggestedproducts.add(element.title!);
                        });

                      });
                    },
                    child: Container(
                      height: height*0.03,
width: width*0.15,
                      child: Center(child: Text("All",style:
                      _const.raleway_CCCCCC(10, FontWeight.w600)
                      )),
                    ),
                  ),
                  Text("|",
                  style:     _const.raleway_CCCCCC(10, FontWeight.w600),
                  ),

                  Expanded(
                    child: InkWell(
                      onTap: (){

                        setState(() {
                          currentindex=1;
suggestedproducts=recentproducts;
                        });
                      },
                      child: Container(
                        height: height*0.03,

                        child: Center(child: Text("Recent Searches",
                          style:      _const.raleway_CCCCCC(10, FontWeight.w600)
                        )),
                      ),
                    ),
                  ),
                  Text("|",
                    style:     _const.raleway_CCCCCC(10, FontWeight.w600),
                  ),

                  Expanded(
                    child: InkWell(
                      onTap: (){
                setState(() {
                  currentindex=2;
                  suggestedproducts=savedproducts;
                });
                      },
                      child: Container(
                        height: height*0.03,

                        child: Center(child: Text("Saved Searches",
                          style:
                          _const.raleway_CCCCCC(10, FontWeight.w600)
                        )),
                      ),
                    ),
                  ),

                ],
              ),
            ),

            SizedBox(height: height*0.025,),
            Container(
              height: height * 1,
              child:

              suggestedproducts.length==0?

              Column(
                children: [
                  Container(
                      height: height*0.5,
                      child: Center(
                        child: Text(
                          "No item found",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black
                          ),
                        ),
                      )),
                ],
              )
                  :
              ListView.builder(
                  itemCount: suggestedproducts.length,
                  itemBuilder: (context, index) {

                    return Center(

                      child: Container(
                       margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
                        child: ListTile(

                          trailing:

                          ((currentindex==1 && temp==false ) || (currentindex==2 && temp==false ))?

                          InkWell(

                            onTap: () async {

                              if(currentindex==1){

                                setState(() {
                                  recentproducts.removeWhere((element) => element==suggestedproducts[index]);
                                });

                                await database.update_recent_search_products_history(user_id, savedproducts, context);

                              }
                              else if(currentindex==2){
                                setState(() {
                                  savedproducts.removeWhere((element) => element==suggestedproducts[index]);
                                });

                                await database.update_saved_search_products_history(user_id, savedproducts, context);

                              }

                            },
                            child:   Icon(
                              Icons.close,
                              color: Color(0xff2B2B2B),
                            ),
                          ):Text(""),
                          leading: Icon(Icons.search,color: Color(0xffCCCCCC)),
                          title: InkWell(
                            onTap: ()async{
                              if(!recentproducts.contains(suggestedproducts[index])){
                               recentproducts.add(suggestedproducts[index]);
                                await     database.update_recent_search_products_history(user_id, recentproducts, context);

                              }
List<Product> desired_products=[];
                              myproducts.forEach((element) {
                                if(
                                element.title==suggestedproducts[index]
                                ||
                                    element.description==suggestedproducts[index]
||
                                element.price.toString()==suggestedproducts[index]
                                ){
                                  desired_products.add(element);
                                }
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context)=>SearchPage(
                                    desiredcategory: suggestedproducts[index],
                                    history: savedproducts,
                                    desired_products: desired_products,
                                  ))
                              );
                            print("length is "+desired_products.length.toString());
                            },
                            child: Text(suggestedproducts[index]
                                .toString(),style: TextStyle(
                                color: Colors.black
                            )),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
