import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dingzo/Database/database.dart';
import 'package:dingzo/Database/product_database.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/model/product.dart';
import 'package:dingzo/screens/cart.dart';
import 'package:dingzo/screens/checkout.dart';
import 'package:dingzo/screens/editaddress.dart';
import 'package:dingzo/screens/home.dart';
import 'package:dingzo/screens/live_item.dart';
import 'package:dingzo/screens/onboarding.dart';
import 'package:dingzo/screens/sellerAccountCreation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart' as Path;

import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class SellItem extends StatefulWidget {
  static const routename = "SellItem";

  @override
  State<SellItem> createState() => _SellItemState();
}

class _SellItemState extends State<SellItem> {
  Constants _const = Constants();


  bool isloading = false;
  bool both_service = false;
  String restuarent_name = '';
  double ? _latitide;
  double ? prodheight=0;
  double ? prodwidth=0;
  double ? weight=0;
  double ? length=0;
  double? _longitude;
  String _loc = '';
  Database database = Database();

double percentage_progress=0;

  Future<void> _submit() async {

    if (!_formKey.currentState!.validate()) {

      return;
    }

    _formKey.currentState!.save();

    setState(() {
      isloading=true;
    });

     if(selectedoption=="Tool for rent" || both_service){
    setState(() {
    isloading=false;
    });
    if(rent_duration!.isEmpty){
    _showErrorDialog(context, "Please Enter Rent interval");
    }
    else{

    }

    }
       if(image_file1==null || image_file2==null || image_file3==null ){
        setState(() {
          isloading=false;
        });

        _showErrorDialog(context, "Please Select Product Images");
      }
      else if(title!.isEmpty){
        setState(() {
          isloading=false;
        });
        _showErrorDialog(context, "Please Enter title");
      }
      else if(description!.isEmpty){
        setState(() {
          isloading=false;
        });
        _showErrorDialog(context, "Please Enter Description");
      }
      else if(categ==null){
        setState(() {
          isloading=false;
        });
        _showErrorDialog(context, "Please Select Category");
      }
      else if(selectedoption==null){
        setState(() {
          isloading=false;
        });
        _showErrorDialog(context, "Please Select Option");
      }

      else if(price!.isEmpty){
        setState(() {
          isloading=false;
        });
        _showErrorDialog(context, "Please Enter Price");
      }

      else{
        setState(() {
          isloading=true;
        });

        try{
          ProductDatabase _database = ProductDatabase();

setState(() {
  percentage_progress=0.2;
});
            await   uploadFile(0, image_file1!).then((image1) async{

              photos.add(image1);
              setState(() {
                percentage_progress=0.5;
              });
              await   uploadFile(1, image_file1!).then((image2) async{
                photos.add(image2);
                setState(() {
                  percentage_progress=0.7;
                });
                await   uploadFile(2, image_file1!).then((image3) {
                  photos.add(image3);
                  setState(() {
                    percentage_progress=0.95;
                  });
                });

              });

            }).then((value) async {
              await _database.uploadProduct(
                  product: Product(
                      both_service: both_service,
                      views: 0,
                      id: "",
                      rent_fare: rent_fare,
                      rent_duration: rent_duration,
                      price: double.parse(price!),
                      title:title!,
                      quantity:1,
                      status: true,
                      date: DateTime.now(),
                      product_status: 'listed',
                      rent:selectedoption=="Tool for rent"?true:false ,

                      category: categ,
                      photos: photos,
                      product_doc_id: '',
                      sellerid: user_id,
                      sellername: currentuser!.username,
                      sales: 0,
                      description: description,
                      total: 0

                  )).then((value) {
                setState(() {
                  percentage_progress=1;
                });
                Navigator.of(context).pushNamedAndRemoveUntil(LiveItem.routename ,

                     (route) => false,
                    arguments: Product(
                        both_service: both_service,
                        views: 0,
                        id: value,
                        rent_fare: rent_fare,
                        rent_duration: rent_duration,
                        price: double.parse(price!),
                        title:title!,
                        quantity:1,
                        status: true,
                        date: DateTime.now(),
                        product_status: 'listed',
                        rent:selectedoption=="Tool for rent"?true:false ,
                        category: categ,
                        photos: photos,
                        product_doc_id: '',
                        sellerid: user_id,
                        sellername: currentuser!.username,
                        sales: 0,
                        description: description,
                        total: 0

                    )
                );


              });
            });




        }catch(error){
          print("step10");
          setState(() {
            isloading=false;
          });
          _showErrorDialog(context, error.toString());
        }

      }





  }
  final GlobalKey<FormState> _formKey = GlobalKey();

  Future<File?> getfile({int? choice, int? index}) async {
    File ? selectedfile;
    if (choice == 1) {
      final image =
          await ImagePicker.platform.getImage(source: ImageSource.camera);

      if(image!=null){

        if (index == 0) {
          setState(() {
            image_file1 = File(image.path);
            selectedfile=image_file1;
          });

        } else if (index == 1) {
          setState(() {
            image_file2 = File(image.path);
            selectedfile=image_file2;
          });

        } else {
          setState(() {
            image_file3 = File(image.path);
            selectedfile=image_file3;
          });

        }
      }


    } else {
      final image =
          await ImagePicker.platform.getImage(source: ImageSource.gallery);

      if(image!=null){
        if (index == 0) {
          setState(() {
            image_file1 = File(image.path);
            selectedfile=image_file1;
          });

        } else if (index == 1) {
          setState(() {
            image_file2 = File(image.path);
            selectedfile=image_file2;
          });

        } else {
          setState(() {
            image_file3 = File(image.path);
            selectedfile=image_file3;
          });

        }
      }

    }
  return selectedfile;
  }

  Future<String > uploadFile(int index,File _file001) async {
String downlaodedimageurl='';


      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('${'Posts'}/${Path.basename(_file001.path)}');
      await ref!.putFile(_file001).whenComplete(() async {

        await ref!.getDownloadURL().then((imageurl) {

     downlaodedimageurl=imageurl;
        });
      });

return downlaodedimageurl;
  }


  Future<File?> _show_my_Dialog(int index) async{
    File ? choosedfile;
   await  showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
            content: Container(
              height: MediaQuery.of(context).size.height * 0.17,
              child: Column(
                children: [
                  ListTile(
                    onTap: () async {
                      if (index == 0) {
                       await  getfile(choice: 1, index: 0).then((value) async{
                                    choosedfile=value;
                                    Navigator.of(context).pop();
                        });
                      } else if (index == 1) {
                       await  getfile(choice: 1, index: 1).then((value) async{
                        choosedfile=value;

                        });
                      } else {
                       await  getfile(choice: 1, index: 2).then((value) async{
                      choosedfile=value;
                      Navigator.of(context).pop();
                        });
                      }
                    },
                    leading: Icon(
                      Icons.camera,
                      color: Colors.green,
                    ),
                    title: Text("Camera"),
                  ),
                  ListTile(
                    onTap: () async {

                      if (index == 0) {
                       await  getfile(choice: 2, index: 0).then((value) async{

                       if(value!=null){
                         choosedfile=value;
Navigator.of(context).pop();
                       }

                        });

                      } else if (index == 1) {
                       await  getfile(choice: 2, index: 1).then((value) async{
                        choosedfile=value;
                        Navigator.of(context).pop();
                        });
                      } else {
                        await getfile(choice: 2, index: 2).then((value)async {
                         choosedfile=value;
                         Navigator.of(context).pop();
                        });
                      }
                    },
                    leading: Icon(
                      Icons.image,
                      color: Colors.green,
                    ),
                    title: Text("Gallery"),
                  )
                ],
              ),
            )));
  return choosedfile;
  }
  String ? title='';
  String ? description='';
  String ? price ='';

  String? categ;
  String? rent_duration='Weeks';
  double ? rent_fare =0;
  List<String> rent_duration_list=["Hours","Weeks","Days","Months"];
  String ? selectedoption;
  String? brand;
  String? condition;
  Address ? selleraddress;


  bool uploading = false;
  double val = 0;
  List<String> photos = [];
  List<String> category_list=["Electronics and media","Home and Garden","Art","Chainsaw",'Hammer'];
  List<String> optionlist=["Item to sell","Tool for rent"];
  List<File> _image = [];
  final picker = ImagePicker();

  File? image_file1;
  File? image_file2;
  File? image_file3;

  CollectionReference? imgRef;
  firebase_storage.Reference? ref;

  String? _showQuestionMarkDialog({required BuildContext?  context,required  String ? title,required String ? description}) {
    showDialog(
        context: context!,
        builder: (ctx) => AlertDialog(
          backgroundColor: mycolor,
          title: Text(title!,
          style: _const.manrope_regularwhite(16, FontWeight.w800),
          ),
          content: Text(description!,
              style: _const.manrope_regularwhite(14, FontWeight.w500)
          ),

        ));
  }

  String? _showErrorDialog(BuildContext context, String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Alert'),
          content: Text(msg),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ));
  }
  String? _show_stripe_dialogue(BuildContext context, String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Alert'),
          content: Text(msg),
          actions: <Widget>[
            TextButton(
              child: Text('Not Right Now',
                  style: TextStyle(
                      color: Colors.black
                  )
              ),
              onPressed: () {
                Navigator.of(ctx).pop();

              },
            ),
            Container(
              decoration: BoxDecoration(
                color: mycolor,
                borderRadius: BorderRadius.circular(10)
              ),
              child: TextButton(
                child: Text('Onboard',style: TextStyle(
                  color: Colors.white
                )),
                onPressed: () {

                  Navigator.of(context).pushNamed(Onboarding.routename).then((value) {
                    Navigator.of(context).pop();
                  });
                },
              ),
            )
          ],
        ));
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.8,
        leadingWidth: width*0.3
        ,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Post A Item To Sell",style: _const.manrope_regular263238(20, FontWeight.w800)),
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();

        }, icon: Icon(Icons.arrow_back_ios,color: Color(0xff3A4651),)),
        actions: [

          InkWell(
            onTap: (){
              Navigator.of(context).pushNamed(Checkout.routename);
            },
            child: Container(
              child: Image.asset('images/cart.png',color: Color(0xff263238)),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * 0.025,
          ),
         Container(
           margin: EdgeInsets.only(left: width*0.15,right: width*0.15),
           child: Text("What Will You List?",style: _const.poppin_BlackBold(40, FontWeight.w700),
           textAlign: TextAlign.center,
           ),
         ),
          SizedBox(
            height: height * 0.025,
          ),

          Container(

            child: Container(
                height: height * 0.055,
                width: width * 0.65,
                margin: EdgeInsets.only(left: width * 0.1,right: width*0.1),
                decoration: BoxDecoration(
                    color: blackbutton,
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButton(
                  value: selectedoption,
                  dropdownColor: Color(0xff1A5A47),
                  onChanged: (value) {
                    setState(() {
                      selectedoption = value as String;
                    });
                  },
                  underline: DropdownButtonHideUnderline(child: Text("")),
                  icon: Icon(Icons.arrow_drop_down,color: blackbutton),
                  isExpanded: true,

                  hint: Container(
                      alignment: Alignment.center,
                      child: Text("Select Option",style:  _const.raleway_SemiBold_white(16, FontWeight.w600))),
                  items: optionlist
                      .map((e) => DropdownMenuItem(

                      value: e, child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        alignment: Alignment.center,
                        child: Text(e,style:  _const.raleway_SemiBold_white(16, FontWeight.w600))),
                  )))
                      .toList(),
                )
            ),
          ),
          SizedBox(
            height: height * 0.025,
          ),

          Row(children: [
            InkWell(
              onTap: () async{
               await  _show_my_Dialog(0).then((value) async {

      //             if(value!=null){
      // await   uploadFile(0, value);
      //             }
                });
              },
              child: image_file1 != null
                  ? Container(
                      margin: EdgeInsets.only(
                        left: width * 0.05,
                      ),
                      height: height * 0.15,
                      width: width * 0.28,
                      decoration: BoxDecoration(
                          color: Color(0xffE7E7E7),
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(File(image_file1!.path)))),
                    )
                  : Container(
                      margin: EdgeInsets.only(
                        left: width * 0.05,
                      ),
                      height: height * 0.15,
                      width: width * 0.28,
                      decoration: BoxDecoration(
                          color: Color(0xffE7E7E7),
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: CircleAvatar(
                          radius: 23,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.add,
                              color: Color(0xffCCD2E3), size: 24),
                        ),
                      ),
                    ),
            ),
            InkWell(
              onTap: () async{
                await  _show_my_Dialog(1).then((value) async {

                  // if(value!=null){
                  //   await   uploadFile(1, value);
                  // }
                });

              },
              child: image_file2 == null
                  ? Container(
                      margin: EdgeInsets.only(
                        left: width * 0.05,
                      ),
                      height: height * 0.15,
                      width: width * 0.28,
                      decoration: BoxDecoration(
                          color: Color(0xffE7E7E7),
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: CircleAvatar(
                          radius: 23,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.add,
                              color: Color(0xffCCD2E3), size: 24),
                        ),
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(
                        left: width * 0.05,
                      ),
                      height: height * 0.15,
                      width: width * 0.28,
                      decoration: BoxDecoration(
                          color: Color(0xffE7E7E7),
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(File(image_file2!.path)))),
                    ),
            ),
            InkWell(
              onTap: () async{
                await  _show_my_Dialog(2).then((value) async {

                  // if(value!=null){
                  //   await   uploadFile(2, value);
                  // }
                });
                },
              child: image_file3 == null
                  ? Container(
                      margin: EdgeInsets.only(
                        left: width * 0.05,
                      ),
                      height: height * 0.15,
                      width: width * 0.28,
                      decoration: BoxDecoration(
                          color: Color(0xffE7E7E7),
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: CircleAvatar(
                          radius: 23,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.add,
                              color: Color(0xffCCD2E3), size: 24),
                        ),
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(
                        left: width * 0.05,
                      ),
                      height: height * 0.15,
                      width: width * 0.28,
                      decoration: BoxDecoration(
                          color: Color(0xffE7E7E7),
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(File(image_file3!.path)))),
                    ),
            ),
          ]),

          SizedBox(
            height: height * 0.025,
          ),
 Form(
   key: _formKey,
   child: Column(children: [
     Container(
       margin: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
       height: height * 0.065,
       width: width * 1,
       decoration: BoxDecoration(
           color: Color(0xffF6F6F6),
           borderRadius: BorderRadius.circular(15)),
       child: TextFormField(
         validator: (value){

         },
         onSaved: (val){
           setState((){
             title=val;
           });
         },
         onFieldSubmitted: (val){
           setState((){
             title=val;
           });

         },

         decoration: InputDecoration(
             hintText: "Title...",
             border: InputBorder.none,
             contentPadding: EdgeInsets.only(left: width * 0.05),
             hintStyle: TextStyle(
                 color: Color.fromRGBO(0, 0, 0, 0.26),
                 fontFamily: 'Raleway-SemiBold',
                 fontWeight: FontWeight.w600,
                 fontSize: 16)),
       ),
     ),

     SizedBox(
       height: height * 0.025,
     ),





     Container(
       margin: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
       height: height * 0.2,
       width: width * 1,
       decoration: BoxDecoration(
           color: Color(0xffF6F6F6),
           borderRadius: BorderRadius.circular(15)),
       child: TextFormField(
         validator: (value){

         },
         onSaved: (val){
           setState((){
             description=val.toString();
           });
         },
         onFieldSubmitted: (val){
           description=val;
         },

         decoration: InputDecoration(
             hintText: "Add Details...",
             border: InputBorder.none,
             contentPadding: EdgeInsets.only(left: width * 0.05),
             hintStyle: TextStyle(
                 color: Color.fromRGBO(0, 0, 0, 0.26),
                 fontFamily: 'Raleway-SemiBold',
                 fontWeight: FontWeight.w600,
                 fontSize: 16)),
       ),
     ),

     SizedBox(
       height: height * 0.025,
     ),
     Container(
         height: height * 0.055,
         width: width * 1,
       margin: EdgeInsets.only(left: width * 0.125, right: width * 0.125),
         decoration: BoxDecoration(
             color: blackbutton,
             borderRadius: BorderRadius.circular(10)),
         child: DropdownButton(
           value: categ,
           dropdownColor: Color(0xff1A5A47),
           onChanged: (value) {
             setState(() {
               categ = value as String;
             });
           },
           underline: DropdownButtonHideUnderline(child: Text("")),
           icon: Icon(Icons.arrow_drop_down,color: blackbutton),
           isExpanded: true,

           hint: Container(
               alignment: Alignment.center,
               child: Text("Select Category",style:  _const.raleway_SemiBold_white(16, FontWeight.w600))),
           items: category_list
               .map((e) => DropdownMenuItem(

               value: e, child: Padding(
             padding: const EdgeInsets.all(8.0),
             child: Container(
                 alignment: Alignment.center,
                 child: Text(e,style:  _const.raleway_SemiBold_white(16, FontWeight.w600))),
           )))
               .toList(),
         )
     ),



     SizedBox(
       height: height * 0.025,
     ),

     if(selectedoption=="Tool for rent")

     Container(
         height: height * 0.055,
         width: width * 1,
       margin: EdgeInsets.only(left: width * 0.125, right: width * 0.125),
         padding: EdgeInsets.only(left: width * 0.05,right: width*0.05),
         decoration: BoxDecoration(
             color: blackbutton,
             borderRadius: BorderRadius.circular(10)),
         child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [

             Text(currentuser!.home_address!.first.address1!,
             style: TextStyle(
               color: Colors.white
             ),
             ),

             InkWell(
               onTap: (){
                 Navigator.of(context).pushNamed(EditAddress.routename);
               },
               child: Text("Edit",
                 style: TextStyle(
                     color: Color(0xff1A5A47)
                 ),
               ),
             ),
           ],

         )
     ),



     SizedBox(
       height: height * 0.025,
     ),
     Row(
       children: [
         Container(
           alignment: Alignment.centerLeft,
           margin: EdgeInsets.only(left: width*0.125,right: width*0.025),
           child: Text(
             selectedoption=="Tool for rent"?
             "Want To Sell This?":
             "Want To Rent This?"
             ,
             style: _const.raleway_regular_bold(15 , FontWeight.w900),
           ),
         ),

         InkWell(
           onTap: (){
             _showQuestionMarkDialog(context: context, title: 'Want To Sell This?', description:'By selecting this option, you are allowing the buyer the option to purchase this tool as well. The price will be the buyer deposit price. Once this item sells, it cannot be rented.)'
             );
           },
           child: CircleAvatar(
             radius: 10,
             backgroundColor: mycolor,
             child: CircleAvatar(
               radius: 9,
               backgroundColor: Colors.white,
               child: Icon(Icons.question_mark,color: mycolor,size: 11.5),
             ),
           ),
         )
       ],
     ),
     SizedBox(
       height: height * 0.025,
     ),
     Container(
       margin: EdgeInsets.only(left: width*0.15),
       alignment: Alignment.centerLeft,
       child: ToggleSwitch(
         minWidth: 90.0,
         cornerRadius: 20.0,
         activeBgColors: [[Color(0xff1A5A47)], [Color(0xff1A5A47)]],
         activeFgColor: Colors.white,
         inactiveBgColor: Color(0xff20C997),
         inactiveFgColor: Colors.white,
         initialLabelIndex: both_service?0:1,
         totalSwitches: 2,
         labels: ['YES', 'NO'],
         radiusStyle: true,
         onToggle: (index) {
           print('switched to: $index');

             if(index==0){

            setState(() {
              both_service=true;
            });
             }
             else{

             setState(() {
               both_service=false;
             });
             }

           },
       ),

     ),

     SizedBox(
       height: height * 0.025,
     ),
     if(selectedoption!="Tool for rent" || both_service==false)
       Container(
    alignment: Alignment.centerLeft,
    margin: EdgeInsets.only(left: width*0.1),
    child: Text("Price",
    style: _const.poppin_BlackBold(15, FontWeight.w400),
    ),
  ),

     if(selectedoption!="Tool for rent" || both_service)
     SizedBox(
       height: height * 0.01,
     ),


     if(selectedoption=="Tool for rent" || both_service)
      Row(
        children: [
          Container(
           alignment: Alignment.centerLeft,
           margin: EdgeInsets.only(left: width*0.125,right: width*0.025),
           child: Text("Buyer Deposit",
             style: _const.raleway_regular_bold(15 , FontWeight.w900),
           ),
     ),

          InkWell(
            onTap: (){
              _showQuestionMarkDialog(context: context, title: 'What is the buyer deposit?', description: 'The buyer depost will be charged on top of the item rent purchase ONLY if the buyer doesn’t get return the rented item back or if the rented item came with significant damage rendering it unusable .To ensure fast sales, please make sure the buyer depost price is a fair price. You can choose to not put a buyer depost price however, if the buyer doesn’t return the item, you will not recieve a deposit.');
            },
            child: CircleAvatar(
              radius: 10,
              backgroundColor: mycolor,
              child: CircleAvatar(
                radius: 9,
                backgroundColor: Colors.white,
                child: Icon(Icons.question_mark,color: mycolor,size: 11.5),
              ),
            ),
          )
        ],
      ),


     if(selectedoption=="Tool for rent" || both_service)
      Container(
       alignment: Alignment.centerLeft,
       margin: EdgeInsets.only(left: width*0.125,right: width*0.05),
       child: Text(  "(In case the tool arrives back damaged or doesn’t get returned back. This will be public to the buyer.)",
        style: _const.raleway_263238(10 , FontWeight.w600),

       ),
     ),


     if(selectedoption=="Tool for rent" || both_service)
     SizedBox(
       height: height * 0.025,
     ),


     Container(
       margin: EdgeInsets.only(left: width * 0.125, right: width * 0.125),
       padding:  EdgeInsets.only(left: width * 0.05,),
       alignment: Alignment.centerLeft,
       height: height * 0.06,
       width: width * 1,
       decoration: BoxDecoration(
         border: Border.all(
           color: Color.fromRGBO(41, 49, 47, 0.51)
         ),
          borderRadius: BorderRadius.circular(10)),
       child: TextFormField(
         validator: (value){

         },
         keyboardType: TextInputType.number,
         onSaved: (val){
           setState((){
             price=val;
           });
         },
         onFieldSubmitted: (val){
           setState((){
             price=val;
           });

         },

         decoration: InputDecoration(
             hintText: "Enter Price",
             border: InputBorder.none,

           hintStyle: TextStyle(
                 color: Color.fromRGBO(41, 49, 47, 0.51),
                 fontFamily: 'Raleway-SemiBold',
                 fontWeight: FontWeight.w600,
                 fontSize: 16)),
       ),
     ),

     if(selectedoption=="Tool for rent" || both_service)
       SizedBox(
         height: height * 0.025,
       ),


     SizedBox(
       height: height * 0.025,
     ),


     if(selectedoption=="Tool for rent" || both_service)

       Container(
           height: height * 0.055,
           width: width * 1,
           margin: EdgeInsets.only(left: width * 0.125, right: width * 0.125),
           decoration: BoxDecoration(
               color: blackbutton,
               borderRadius: BorderRadius.circular(10)),
           child: DropdownButton(
             value: rent_duration,
             dropdownColor: Color(0xff1A5A47),
             onChanged: (value) {
               setState(() {
                 rent_duration = value as String;
               });
             },
             underline: DropdownButtonHideUnderline(child: Text("")),
             icon: Icon(Icons.arrow_drop_down,color: blackbutton),
             isExpanded: true,

             hint: Container(
                 alignment: Alignment.center,
                 child: Text("Select Lending Interval",style:  _const.raleway_SemiBold_white(16, FontWeight.w600))),
             items: rent_duration_list
                 .map((e) => DropdownMenuItem(

                 value: e, child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Container(
                   alignment: Alignment.center,
                   child: Text(e,style:  _const.raleway_SemiBold_white(16, FontWeight.w600))),
             )))
                 .toList(),
           )
       ),
     SizedBox(
       height: height * 0.025,
     ),

     if(selectedoption=="Tool for rent" || both_service)
       Container(
         alignment: Alignment.centerLeft,
         margin: EdgeInsets.only(left: width * 0.125, right: width * 0.125),
         child: Text("Price per ${rent_duration}",
           style: _const.raleway_regular_bold(15 , FontWeight.w900),
         ),
       ),

     if(selectedoption=="Tool for rent" || both_service)
       Container(
         margin: EdgeInsets.only(left: width * 0.125, right: width * 0.125,top: height*0.015),
         padding:  EdgeInsets.only(left: width * 0.05,),
         alignment: Alignment.centerLeft,
         height: height * 0.06,
         width: width * 1,
         decoration: BoxDecoration(
             border: Border.all(
                 color: Color.fromRGBO(41, 49, 47, 0.51)
             ),
             borderRadius: BorderRadius.circular(10)),

         child: TextFormField(
           validator: (value){

           },
           keyboardType: TextInputType.number,
           onSaved: (val){
             setState((){
               rent_fare=double.parse(val.toString());
             });
           },
           onFieldSubmitted: (val){
             setState((){
               rent_fare=double.parse(val.toString());
             });

           },
           decoration: InputDecoration(
               hintText: "Enter Rent Price",
               border: InputBorder.none,

               hintStyle: TextStyle(
                   color: Color.fromRGBO(41, 49, 47, 0.51),
                   fontFamily: 'Raleway-SemiBold',
                   fontWeight: FontWeight.w600,
                   fontSize: 16)),
         ),
       ),









     SizedBox(
       height: height * 0.025,
     ),




   ]),
 ),




          isloading?
          Center(
            child: Container(

              height:  height*0.05,

              width: width*0.7,

              child: Stack(

                children: [

                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: percentage_progress,
                valueColor: AlwaysStoppedAnimation(blackbutton),
                      backgroundColor: mycolor,
                      color: mylightcolor,

                      minHeight: height*0.06,

                    ),
                  ),

                  Center(child: Text("Listing your Item...",
                    style: _const.raleway_SemiBold_white(14, FontWeight.w600),
                  ))

                ],
              ),
            ),
          ):
          InkWell(
            onTap: () async {

      if (currentuser!.accountcreated == false){
        _show_stripe_dialogue(context, "In order to list the item, you must onboard.");

    }
               else {
                 _submit();
               }
            },

            child: Center(
              child: Container(
                height: height * 0.06,
                width: width * 0.35,

                padding: EdgeInsets.only(
                    left: width * 0.025, right: width * 0.025),
                decoration: BoxDecoration(
                    color: mycolor,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                    child: Text(
                      "List Item",
                      style: _const.raleway_SemiBold_white(14, FontWeight.w600),
                      textAlign: TextAlign.center,
                    )),
              ),
            ),
          ),


          SizedBox(
            height: height * 0.025,
          ),

          // Center(
          //   child: Container(
          //     height: height * 0.055,
          //     width: width * 0.35,
          //
          //     padding: EdgeInsets.only(
          //         left: width * 0.025, right: width * 0.025),
          //     decoration: BoxDecoration(
          //         color: mycolor,
          //         borderRadius: BorderRadius.circular(20)),
          //     child: Center(
          //         child: Text(
          //       "Save as Draft",
          //       style: _const.raleway_SemiBold_white(14, FontWeight.w600),
          //       textAlign: TextAlign.center,
          //     )),
          //   ),
          // ),
          SizedBox(
            height: height * 0.025,
          ),
        ],
      ),

    );
  }
}
