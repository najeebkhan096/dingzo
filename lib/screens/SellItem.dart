import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dingzo/Database/database.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/model/product.dart';
import 'package:dingzo/screens/home.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart' as Path;

import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';

class SellItem extends StatefulWidget {
  static const routename = "SellItem";

  @override
  State<SellItem> createState() => _SellItemState();
}

class _SellItemState extends State<SellItem> {
  Constants _const = Constants();
  bool isloading = false;
  String restuarent_name = '';
  double? _latitide;
  double? _longitude;
  String _loc = '';
  Database database = Database();

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

  TextEditingController? title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  String? categ;
  String? brand;
  String? condition;
  bool freeshipment = true;

  bool uploading = false;
  double val = 0;

  List<File> _image = [];
  final picker = ImagePicker();

  File? image_file1;
  File? image_file2;
  File? image_file3;

  CollectionReference? imgRef;
  firebase_storage.Reference? ref;
  List<String> photos = [];
  List<String> category_list=["Memorabilla","Music"];
  List<String> condition_list=["New","Used"];
  List<String> brand_list=["Nike"];

  Future uploadFile() async {
    List<File> fileslist = [image_file1!, image_file2!, image_file3!];
    photos = [];

    try {
      for (int i = 0; i <= 2; i++) {
        ref = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('${title!.text}/${Path.basename(fileslist[i].path)}');
        await ref!.putFile(fileslist[i]).whenComplete(() async {
          await ref!.getDownloadURL().then((imageurl) {
            photos.add(imageurl);
          });
        });
      }
    } catch (error) {

      setState(() {
        isloading = false;
      });
    _showErrorDialog(context, error.toString());
    }
  }

  String? _showErrorDialog(BuildContext context, String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('Alert'),
              content: Text(msg),
              actions: <Widget>[
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            ));
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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            height: height * 0.15,
            width: width * 1,
            decoration: BoxDecoration(
                color: Color(0xffFFEA9D),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(40))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.white,
                          child: SvgPicture.asset(
                            'images/back.svg',
                            height: height * 0.025,
                          )),
                    ),
                    Text(
                      "Sell an Item",
                      style: _const.raleway_extrabold(27, FontWeight.w800),
                    ),
                    Container(
                      height: height * 0.065,
                      width: width * 0.25,
                      margin: EdgeInsets.only(left: width * 0.05),
                      padding: EdgeInsets.only(
                          left: width * 0.025, right: width * 0.025),
                      decoration: BoxDecoration(
                          color: Color(0xffEFB546),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Text(
                        "My Saved Drafts (4)",
                        style:
                            _const.raleway_SemiBold_white(14, FontWeight.w600),
                        textAlign: TextAlign.center,
                      )),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.03,
                ),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.025,
          ),
          Container(
            margin: EdgeInsets.only(left: width * 0.065),
            child: Text("Add Photos ( Required )",
                style: _const.raleway_SemiBold_9E772A(20, FontWeight.w600)),
          ),
          SizedBox(
            height: height * 0.025,
          ),
          Row(children: [
            InkWell(
              onTap: () {
                _show_my_Dialog(0);
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
              onTap: () {
                _show_my_Dialog(1);
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
              onTap: () {
                _show_my_Dialog(2);
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
          Container(
            margin: EdgeInsets.only(left: width * 0.065),
            child: Text("Description",
                style: _const.raleway_SemiBold_9E772A(20, FontWeight.w600)),
          ),
          SizedBox(
            height: height * 0.025,
          ),
          Container(
            margin: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
            height: height * 0.065,
            width: width * 1,
            decoration: BoxDecoration(
                color: Color(0xffF6F6F6),
                borderRadius: BorderRadius.circular(15)),
            child: TextField(
              controller: title,
              decoration: InputDecoration(
                  hintText: "Title...",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: width * 0.05),
                  hintStyle: TextStyle(
                      color: Color(0xffEFB546),
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
            child: TextField(
              controller: description,
              decoration: InputDecoration(
                  hintText: "Add Details...",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: width * 0.05),
                  hintStyle: TextStyle(
                      color: Color(0xffEFB546),
                      fontFamily: 'Raleway-SemiBold',
                      fontWeight: FontWeight.w600,
                      fontSize: 16)),
            ),
          ),
          SizedBox(
            height: height * 0.025,
          ),
          Container(
            margin: EdgeInsets.only(left: width * 0.05),
            child: Text("Details (Required)",
                style: _const.raleway_SemiBold_9E772A(20, FontWeight.w600)),
          ),
          SizedBox(
            height: height * 0.025,
          ),
          Container(
            margin: EdgeInsets.only(left: width * 0.05),
            child: Row(
              children: [
                Container(
                    width: width * 0.24,
                    child: Text(
                      "Category:",
                      style:
                          _const.raleway_SemiBold_F0BD5C(19, FontWeight.w600),
                    )),
                Container(
                  height: height * 0.055,
                  width: width * 0.65,
                  decoration: BoxDecoration(
                      color: Color(0xffEFB546),
                      borderRadius: BorderRadius.circular(10)),
                  child: DropdownButton(
                    value: categ,
                    dropdownColor: Color(0xffEFB546),
                    onChanged: (value) {
                      setState(() {
                        categ = value as String;
                      });
                    },
                    icon: Icon(Icons.arrow_drop_down,color: Colors.white),
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
              ],
            ),
          ),
          SizedBox(
            height: height * 0.025,
          ),
          Container(
            margin: EdgeInsets.only(left: width * 0.05),
            child: Row(
              children: [
                Container(
                    width: width * 0.24,
                    child: Text(
                      "Brand:",
                      style:
                          _const.raleway_SemiBold_F0BD5C(19, FontWeight.w600),
                    )),
                Container(
                  height: height * 0.055,
                  width: width * 0.65,
                  decoration: BoxDecoration(
                      color: Color(0xffEFB546),
                      borderRadius: BorderRadius.circular(10)),
                  child: DropdownButton(
                    value: brand,
                    onChanged: (value) {
                      setState(() {
                        brand = value as String;
                      });
                    },
                    icon: Icon(Icons.arrow_drop_down,color: Colors.white),
                    isExpanded: true,
                    dropdownColor: Color(0xffEFB546),
                    hint: Container(
                        alignment: Alignment.center,
                        child: Text("Select Brand",style:  _const.raleway_SemiBold_white(16, FontWeight.w600))),
                    items: brand_list
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
              ],
            ),
          ),

          SizedBox(
            height: height * 0.025,
          ),
          Container(
            margin: EdgeInsets.only(left: width * 0.05),
            child: Row(
              children: [
                Container(
                    width: width * 0.24,
                    child: Text(
                      "Condition:",
                      style:
                          _const.raleway_SemiBold_F0BD5C(19, FontWeight.w600),
                    )),
                Container(
                    height: height * 0.055,
                    width: width * 0.65,
                    decoration: BoxDecoration(
                        color: Color(0xffEFB546),
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton(
                      value: condition,
                      onChanged: (value) {
                        setState(() {
                          condition = value as String;
                        });
                      },
                      icon: Icon(Icons.arrow_drop_down,color: Colors.white),
                      isExpanded: true,
dropdownColor: Color(0xffEFB546),
                      hint: Container(
                          alignment: Alignment.center,
                          child: Text("Select Condition",style:  _const.raleway_SemiBold_white(16, FontWeight.w600))),
                      items: condition_list
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
              ],
            ),
          ),
          SizedBox(
            height: height * 0.025,
          ),
          Divider(),
          SizedBox(
            height: height * 0.025,
          ),
          Container(
            margin: EdgeInsets.only(left: width * 0.05),
            child: Text("Shipping (Required)",
                style: _const.raleway_SemiBold_9E772A(20, FontWeight.w600)),
          ),
          SizedBox(
            height: height * 0.025,
          ),
          Container(
              margin: EdgeInsets.only(left: width * 0.05),
              child: Text("Who Pays For Shipping?",
                  style: _const.raleway_SemiBold_F0BD5C(13, FontWeight.w600))),
          SizedBox(
            height: height * 0.025,
          ),
          Container(
            child: Row(
              children: [
                InkWell(
                  onTap: (){
                    setState(() {
                      freeshipment=true;
                    });

                    },
                  child: Container(
                    height: height * 0.06,
                    width: width * 0.35,
                    margin: EdgeInsets.only(left: width * 0.05),
                    padding: EdgeInsets.only(
                        left: width * 0.025, right: width * 0.025),
                    decoration: BoxDecoration(
                        color: Color(0xffEFB546),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                      "I’ll Pay(Free Shipping)",
                      style: _const.raleway_SemiBold_white(14, FontWeight.w600),
                      textAlign: TextAlign.center,
                    )),
                  ),
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      freeshipment=false;
                    });
                  },
                  child: Container(
                    height: height * 0.06,
                    width: width * 0.35,
                    margin: EdgeInsets.only(left: width * 0.05),
                    padding: EdgeInsets.only(
                        left: width * 0.025, right: width * 0.025),
                    decoration: BoxDecoration(
                        color: Color(0xffEFB546),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                      "Buyer Pay",
                      style: _const.raleway_SemiBold_white(14, FontWeight.w600),
                      textAlign: TextAlign.center,
                    )),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.025,
          ),
          Divider(),
          SizedBox(
            height: height * 0.025,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: width * 0.05),
                child: Text("Pricing (Required)",
                    style: _const.raleway_SemiBold_9E772A(20, FontWeight.w600)),
              ),
              Container(
                  height: height * 0.06,
                  width: width * 0.2,
                  margin: EdgeInsets.only(right: width * 0.05),
                  padding: EdgeInsets.only(
                      left: width * 0.025, right: width * 0.025),
                  decoration: BoxDecoration(
                      color: Color(0xffF6F6F6),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: TextField(
                    controller: price,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Price",
                        hintStyle:
                            _const.raleway_SemiBold_brown(16, FontWeight.w600)),
                    style: _const.raleway_SemiBold_brown(16, FontWeight.w600),
                  ))),
            ],
          ),
          SizedBox(
            height: height * 0.025,
          ),
          Divider(),
          SizedBox(
            height: height * 0.025,
          ),
          Container(
            child: Row(

              children: [
                Container(
                  height: height * 0.055,
                  width: width * 0.35,
                  margin: EdgeInsets.only(left: width * 0.05),
                  padding: EdgeInsets.only(
                      left: width * 0.025, right: width * 0.025),
                  decoration: BoxDecoration(
                      color: Color(0xffEFB546),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Text(
                    "Save Draft",
                    style: _const.raleway_SemiBold_white(14, FontWeight.w600),
                    textAlign: TextAlign.center,
                  )),
                ),

                isloading? Container(
                  margin: EdgeInsets.only(left: width * 0.1),
                  child: SpinKitRotatingCircle(
                    color: Colors.black,
                    size: 50.0,
                  ),
                ):
                InkWell(
                  onTap: () async {

                    if(image_file1==null || image_file2==null || image_file3==null){
                      _showErrorDialog(context, "Please Select Product Images");
                    }
                    else if(title!.text.isEmpty){
                      _showErrorDialog(context, "Please Enter  title");
                    }
                    else if(description.text.isEmpty){
                      _showErrorDialog(context, "Please Enter Description");
                    }
                    else if(categ==null){
                      _showErrorDialog(context, "Please Select Category");
                    }
                    else if(brand==null){
                      _showErrorDialog(context, "Please Select Brand");
                    }
                    else if(condition==null){
_showErrorDialog(context, "Please Select Condition");
                    }
                    else if(price.text.isEmpty){
                      _showErrorDialog(context, "Please Enter Price");
                    }

                    else{
                      setState(() {
                        isloading=true;
                      });
try{
  Database _database = Database();
  await uploadFile().then((value)async {
    await _database.uploadProduct(
        product: Product(
            id: "",
            price: double.parse(price.text),
            title:title!.text,
            quantity:1,
            status: true,
            brand: brand,
            category: categ,
            condition: condition,
            freeshipment: freeshipment,
            photos: photos,
            product_doc_id: '',
            sellerid: user_id,
            sellername: currentuser!.username,
            sales: 0,
            description: description.text,
            total: 0

        )).then((value) {

      Navigator.of(context).pushReplacementNamed(HomeScreen.routename);


    });

  });
}catch(error){
  setState(() {
    isloading=false;
  });
  _showErrorDialog(context, error.toString());
}

                    }


                  },
                  child: Container(
                    height: height * 0.06,
                    width: width * 0.35,
                    margin: EdgeInsets.only(left: width * 0.05),
                    padding: EdgeInsets.only(
                        left: width * 0.025, right: width * 0.025),
                    decoration: BoxDecoration(
                        color: Color(0xffEFB546),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                      "List Item",
                      style: _const.raleway_SemiBold_white(14, FontWeight.w600),
                      textAlign: TextAlign.center,
                    )),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.025,
          ),
        ],
      ),

    );
  }
}
