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
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart' as Path;

import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';

class Edit_Request_Item extends StatefulWidget {
  static const routename = "Edit_Request_Item";

  @override
  State<Edit_Request_Item> createState() => _Edit_Request_ItemState();
}

class _Edit_Request_ItemState extends State<Edit_Request_Item> {
  Constants _const = Constants();


  bool isloading = false;
  String restuarent_name = '';
  double ? _latitide;
  double ? prodheight=0;
  double ? prodwidth=0;
  double ? weight=0;
  double ? length=0;
  String? rent_duration='Weeks';
  double ? rent_fare =0;
  List<String> rent_duration_list=["Weeks","Days","Months"];
  double? _longitude;
  String _loc = '';
  Database database = Database();
  Future<void> _submit() async {
    print("step1");
    if (!_formKey.currentState!.validate()) {
      print("step2");
      return;
    }
    print("step3");
    _formKey.currentState!.save();
    print("step4");
    setState(() {
      isloading=true;
    });
    print("step5");


    if(selectedoption=="Tool for rent"){
      setState(() {
        isloading=false;
      });
      if(rent_duration!.isEmpty){
        _showErrorDialog(context, "Please Enter rent Duration");
      }
      else{

      }

    }
    if(title!.isEmpty){
      setState(() {
        isloading=false;
      });
      _showErrorDialog(context, "Please Enter  title");
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
      print("step6");
      try{
        ProductDatabase _database = ProductDatabase();

        await uploadFile().then((value)async {
          await _database.update_product(
              product: Product(
                  id: currentproduct!.id.toString(),
                  price: double.parse(price!),
                  title:title!,
                  quantity:1,
                  status: true,
                  rent_fare: rent_fare,
                  rent_duration: rent_duration,
                  date: DateTime.now(),
                  product_status: currentproduct!.product_status,
                  rent:selectedoption=="Tool for rent"?true:false ,
                  category: categ,
                  photos: currentproduct!.photos,
                  product_doc_id: currentproduct!.product_doc_id.toString(),
                  sellerid: user_id,
                  sellername: currentuser!.username,
                  sales: 0,
                  description: description,
                  total: 0,
                  views: currentproduct!.views
              )).then((value) {

            Navigator.of(context).pop();


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

  Future getfile({int? choice, int? index}) async {
    if (choice == 1) {
      final image =
      await ImagePicker.platform.getImage(source: ImageSource.camera);
      setState(() {
        if (index == 0) {
          image_file1 = File(image!.path);
        } else if (index == 1) {
          image_file2 = File(image!.path);
        } else {
          image_file3 = File(image!.path);
        }
      });
    } else {
      final image =
      await ImagePicker.platform.getImage(source: ImageSource.gallery);
      setState(() {
        if (index == 0) {
          image_file1 = File(image!.path);
        } else if (index == 1) {
          image_file2 = File(image!.path);
        } else {
          image_file3 = File(image!.path);
        }
      });
    }
  }
  Future uploadFile() async {

    if(image_file1!=null){
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('${title!}/${Path.basename(image_file1!.path)}');
      await ref!.putFile(image_file1!).whenComplete(() async {
        await ref!.getDownloadURL().then((imageurl) {
          if(currentproduct!.photos!.length<1){
            currentproduct!.photos!.add(imageurl);
          }
          else{

            currentproduct!.photos!.removeAt(0);
            currentproduct!.photos!.add(imageurl);
          }

        });
      });

    }

    if(image_file2!=null){
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('${title!}/${Path.basename(image_file2!.path)}');
      await ref!.putFile(image_file2!).whenComplete(() async {
        await ref!.getDownloadURL().then((imageurl) {
          if(currentproduct!.photos!.length<2){
            currentproduct!.photos!.add(imageurl);
          }
          else{

            currentproduct!.photos!.removeAt(1);
            currentproduct!.photos!.add(imageurl);
          }
        });
      });
    }

    if(image_file3!=null){
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('${title!}/${Path.basename(image_file3!.path)}');
      await ref!.putFile(image_file3!).whenComplete(() async {
        await ref!.getDownloadURL().then((imageurl) {




          if(currentproduct!.photos!.length>2){

            currentproduct!.photos!.removeAt(2);
            currentproduct!.photos!.add(imageurl);
          }
          else{
            currentproduct!.photos!.add(imageurl);
          }
        });
      });
    }


    try {

    } catch (error) {

      setState(() {
        isloading = false;
      });
      _showErrorDialog(context, error.toString());
    }
  }


  void _show_my_Dialog(int index) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
            content: Container(
              height: MediaQuery.of(context).size.height * 0.17,
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      if (index == 0) {
                        getfile(choice: 1, index: 0).then((value) {
                          Navigator.of(context).pop();
                        });
                      } else if (index == 1) {
                        getfile(choice: 1, index: 1).then((value) {
                          Navigator.of(context).pop();
                        });
                      } else {
                        getfile(choice: 1, index: 2).then((value) {
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
                    onTap: () {
                      if (index == 0) {
                        getfile(choice: 2, index: 0).then((value) {
                          Navigator.of(context).pop();
                        });
                      } else if (index == 1) {
                        getfile(choice: 2, index: 1).then((value) {
                          Navigator.of(context).pop();
                        });
                      } else {
                        getfile(choice: 2, index: 2).then((value) {
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
  }
  String ? title='';
  String ? description='';
  String ? price ='';
  String? categ;
  String ? selectedoption;
  String? brand;
  String? condition;


  bool uploading = false;
  double val = 0;

  List<File> _image = [];
  final picker = ImagePicker();

  File? image_file1;
  File? image_file2;
  File? image_file3;

  CollectionReference? imgRef;
  firebase_storage.Reference? ref;

  List<String> category_list=["Electronics and media","Home and Garden","Art","Chainsaw",'Hammer'];

  List<String> optionlist=["Item to sell","Tool for rent"];


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
  bool gotdata=false;
  Product ? currentproduct;
  @override
  Widget build(BuildContext context) {
    currentproduct=ModalRoute.of(context)!.settings.arguments as Product;
    if(gotdata==false){
      selectedoption=currentproduct!.rent!?"Tool for rent":"Item to sell";
      categ=currentproduct!.category;
      title=currentproduct!.title.toString();
      description=currentproduct!.description.toString();
      price=currentproduct!.price.toString();
      rent_duration=currentproduct!.rent!?currentproduct!.rent_duration:rent_duration;
      rent_fare=currentproduct!.rent_fare;
      gotdata=true;
    }

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
        title: Text("Edit Item",style: _const.manrope_regular263238(20, FontWeight.w800)),
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
      body:

      gotdata?

      ListView(
        children: [

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
                    borderRadius: BorderRadius.circular(20)),
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
              onTap: () {
                _show_my_Dialog(0);
              },
              child:    image_file1!=null?
              Container(
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
              ):
              (currentproduct!.photos!.length==0 )
                  ?
              Container(
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

                  :Container(
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
                        image: NetworkImage(currentproduct!.photos![0]))),
              ),
            ),
            InkWell(
              onTap: () {
                _show_my_Dialog(1);
              },
              child:
              image_file2!=null?
              Container(
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
              ):
              (currentproduct!.photos!.length<2 )
                  ?
                  Container(
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

                  :Container(
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
                        image: NetworkImage(currentproduct!.photos![1]))),
              ),
            ),
            InkWell(
              onTap: () {
                _show_my_Dialog(2);
              },
              child:    image_file3!=null?
              Container(
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
              ):
              (currentproduct!.photos!.length<3 )
                  ?
              Container(
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

                  :Container(
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
                        image: NetworkImage(currentproduct!.photos![2]))),
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
                  initialValue: title,
                  validator: (value){
                    if(value!.isEmpty){
                      return "invalid";
                    }
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
                  initialValue: description,
                  validator: (value){
                    if(value!.isEmpty){
                      return "invalid";
                    }
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
                  margin: EdgeInsets.only(left: width * 0.15,right: width*0.15),
                  decoration: BoxDecoration(
                      color: blackbutton,
                      borderRadius: BorderRadius.circular(20)),
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
                    margin: EdgeInsets.only(left: width * 0.15,right: width*0.15),
                    padding: EdgeInsets.only(left: width * 0.05,right: width*0.05),
                    decoration: BoxDecoration(
                        color: blackbutton,
                        borderRadius: BorderRadius.circular(20)),
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

              if(selectedoption!="Tool for rent")
                SizedBox(
                  height: height * 0.01,
                ),


              if(selectedoption=="Tool for rent")
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: width*0.1,right: width*0.05),
                  child: Text("Buyer Deposit",
                    style: _const.raleway_regular_bold(15 , FontWeight.w900),
                  ),
                ),


              if(selectedoption=="Tool for rent")
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: width*0.1,right: width*0.05),
                  child: Text(  "(In case the tool arrives back damaged or doesn’t get returned back. This will be public to the buyer.)",
                    style: _const.raleway_263238(10 , FontWeight.w600),

                  ),
                ),


              if(selectedoption=="Tool for rent")
                SizedBox(
                  height: height * 0.025,
                ),

              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: width*0.1),
                child: Text("Price",
                  style: _const.poppin_BlackBold(15, FontWeight.w400),
                ),
              ),

              SizedBox(
                height: height * 0.01,
              ),

              Container(
                margin: EdgeInsets.only(left: width * 0.1, right: width * 0.1),
                height: height * 0.06,
                width: width * 1,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Color.fromRGBO(41, 49, 47, 0.51)
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  initialValue: price,
                  validator: (value){
                    if(value!.isEmpty){
                      return "invalid";
                    }
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

                      contentPadding: EdgeInsets.only(left: width * 0.05,bottom: height*0.015),
                      hintStyle: TextStyle(
                          color: Color.fromRGBO(41, 49, 47, 0.51),
                          fontFamily: 'Raleway-SemiBold',
                          fontWeight: FontWeight.w600,
                          fontSize: 16)),
                ),
              ),






              if(selectedoption=="Tool for rent")
                SizedBox(
                  height: height * 0.025,
                ),
              if(selectedoption=="Tool for rent")
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: width*0.1,right: width*0.05),
                  child: Text("Price per ${rent_duration}",
                    style: _const.raleway_regular_bold(15 , FontWeight.w900),
                  ),
                ),

              if(selectedoption=="Tool for rent")
                Container(
                  margin: EdgeInsets.only(left: width * 0.1, right: width * 0.1),
                  height: height * 0.06,
                  width: width * 1,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromRGBO(41, 49, 47, 0.51)
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    initialValue: currentproduct!.rent_fare!.toString(),
                    validator: (value){
                      if(value!.isEmpty){
                        return "invalid";
                      }
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

                        contentPadding: EdgeInsets.only(left: width * 0.05,bottom: height*0.015),
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

              if(selectedoption=="Tool for rent")

                Container(
                    height: height * 0.055,
                    width: width * 1,
                    margin: EdgeInsets.only(left: width * 0.15,right: width*0.15),
                    decoration: BoxDecoration(
                        color: blackbutton,
                        borderRadius: BorderRadius.circular(20)),
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
                          child: Text("Select Rent Duration",style:  _const.raleway_SemiBold_white(16, FontWeight.w600))),
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



            ]),
          ),




          Container(
            margin: EdgeInsets.only(right: width*0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isloading? Container(
                  margin: EdgeInsets.only(left: width * 0.1),
                  child: SpinKitRotatingCircle(
                    color: mycolor,
                    size: 50.0,
                  ),
                ):
                InkWell(
                  onTap: () async {

                    _submit();

                  },
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
                          "Edit Request",
                          style: _const.raleway_SemiBold_white(14, FontWeight.w600),
                          textAlign: TextAlign.center,
                        )),
                  ),
                ),


              ],
            ),
          ),



          SizedBox(
            height: height * 0.05,
          ),
        ],
      ):

      Center(child: SpinKitChasingDots(color: mycolor,))
      ,

    );
  }
}
