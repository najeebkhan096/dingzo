import 'package:dingzo/Database/database.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:flutter/material.dart';
class UserInformation extends StatelessWidget {
final desired_userid;
UserInformation({required this.desired_userid});
Constants _const=Constants();
double calAverage(List<double> ratings){
  double aver=0;
  double sum=0;
if(ratings.length>0){
  ratings.forEach((element) {
    sum=sum+element;
  });
  aver=sum/ratings.length;
}
else{
  aver=5;
}


  return aver;
}

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return  FutureBuilder(
        future: database.fetchprofiledata(DesiredUserID:desired_userid),
        builder: (context,AsyncSnapshot<MyUser?> snapshot){
          return snapshot.hasData?
          Container(
            margin: EdgeInsets.only(left: width * 0.05,right: width * 0.025),
            width: width * 1,
            child: Row(
              children: [
                snapshot.data!.imageurl!.isEmpty?
                CircleAvatar(
                  radius: 25,
             child: Text("No Image",style: _const.manrope_regularwhite(10, FontWeight.w500)),
                ):
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(snapshot.data!.imageurl!),
                ),


                Container(
                  width: width*0.7,
                  margin: EdgeInsets.only(left: width * 0.025),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Text(snapshot.data!.username.toString(),
                                style: _const.raleway_535F5B(
                                    15, FontWeight.w600)),
                          ),

                          Row(
                            children: List.generate(
                                calAverage(snapshot.data!.rating!).toInt(),
                                    (index) => Icon(
                                  Icons.star,
                                  color: Color(0xff535F5B),
                                )),
                          ),
                          Text(
                            calAverage(snapshot.data!.rating!).toStringAsFixed(1),
                            style: _const.raleway_535F5B(
                                17, FontWeight.w600),
                          )
                        ],
                      ),

                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const  Color(0xff535F5B))
                        ),
                        padding: EdgeInsets.only(left: width*0.025,right: width*0.025,bottom: height*0.01,top: height*0.01),
                        child:   Text("Follow",style: _const.raleway_535F5B(15, FontWeight.w600)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
              :Text('');
        });
  }
}
