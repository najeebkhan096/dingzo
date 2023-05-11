import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
const String BACKEND_HOST = 'http://localhost:3000';
class Constants{
  TextStyle poppin_SemiBold(double size,FontWeight weight){
   return TextStyle(
       color: Color(0xff000000),
       fontSize:size,
     fontWeight: weight,
     fontFamily: 'Poppins-SemiBold'
   );
  }
  TextStyle poppin_BlackBold(double size,FontWeight weight){
    return TextStyle(
        color: Color(0xff000000),
        fontSize:size,
        fontWeight: weight,
        fontFamily: 'Poppins-Bold'
    );
  }
  TextStyle poppin_black_rgb(double size,FontWeight weight){
    return TextStyle(
        color: Color.fromRGBO(0, 0, 0, 0.8),
        fontSize:size,
        fontWeight: weight,
        fontFamily: 'Poppins-Bold'
    );
  }
  TextStyle poppin_SemiBoldB6995F(double size,FontWeight weight){
    return TextStyle(
        color: Color(0xffB6995F),
        fontSize:size,
        fontWeight: weight,
        fontFamily: 'Poppins-SemiBold'
    );
  }



//regular
  TextStyle poppin_Regualr(double size,FontWeight weight){
    return TextStyle(
        color: Color(0xff000000),
        fontSize:size,
        fontWeight: weight,
        fontFamily: 'Poppins-Regular'
    );
  }


//regular
  TextStyle poppin_Regualr_2C2C2C(double size,FontWeight weight){
    return TextStyle(
        color: Color(0xff2C2C2C),
        fontSize:size,
        fontWeight: weight,
        fontFamily: 'Poppins-Regular'
    );
  }



  TextStyle poppin_orange(double size,FontWeight weight){
    return TextStyle(
        color: Color(0xffEFB546),
        fontSize:size,
        fontWeight: weight,
        fontFamily: 'Poppins-SemiBold'
    );
  }
  TextStyle poppin_mycolor(double size,FontWeight weight){
    return TextStyle(
        color: mycolor,
        fontSize:size,
        fontWeight: weight,
        fontFamily: 'Poppins-Regular'
    );
  }

  TextStyle poppin_brown(double size,FontWeight weight){
    return TextStyle(
        color: Color(0xff8B6824),
        fontSize:size,
        fontWeight: weight,
        fontFamily: 'Poppins-SemiBold'
    );
  }

  TextStyle poppin_white(double size,FontWeight weight){
    return TextStyle(
        color: Colors.white,
        fontSize:size,
        fontWeight: weight,
        fontFamily: 'Poppins-SemiBold'
    );
  }

  TextStyle poppin_brown_textfield(double size,FontWeight weight){
    return TextStyle(
        color: Color.fromRGBO(41, 49, 47, 0.51),
        fontSize:size,
        fontWeight: weight,
        fontFamily: 'Raleway-Regular'
    );
  }
  TextStyle poppin_dark_brown(double size,FontWeight weight){
    return TextStyle(
        color: Color(0xff9E772A),
        fontSize:size,
        fontWeight: weight,
        fontFamily: 'Poppins-SemiBold'
    );
  }

  TextStyle poppin_light_brown(double size,FontWeight weight){
    return TextStyle(
        color: Color(0xffD7C6A7),
        fontSize:size,
        fontWeight: weight,
        fontFamily: 'Poppins-SemiBold'
    );
  }


  //raleway regular
  TextStyle raleway_regular_darkbrown(double size,FontWeight weight){
    return TextStyle(
        color: const Color(0xff8B6824),
        fontSize:size,
        fontWeight: weight,
        fontFamily: 'Raleway-Regular'
    );
  }


  //raleway bold
  TextStyle raleway_regular_bold(double size,FontWeight weight){
    return TextStyle(
        color: const Color(0xff000000),
        fontSize:size,
        fontWeight: weight,
        fontFamily: 'Poppins-Regular'
    );
  }

  //raleway bold
  TextStyle raleway_regular_black(double size,FontWeight weight){
    return TextStyle(
        color: const Color(0xff000000),
        fontSize:size,
        fontWeight: weight,
        fontFamily: 'Raleway-Regular'
    );
  }

  //raleway light
  TextStyle raleway_light_darkbrown(double size,FontWeight weight){
    return TextStyle(
        color: const Color(0xff8B6824),
        fontSize:size,
        fontWeight: weight,
        fontFamily: 'Raleway-Light'
    );
  }


  //raleway  black
  TextStyle raleway_black_darkbrown(double size,FontWeight weight){
    return TextStyle(
        color: const Color(0xff8B6824),
        fontSize:size,
        fontWeight: weight,
        fontFamily: 'Raleway-Black'
    );
  }

  //raleay medium
  TextStyle raleway_medium_9E772A(double size,FontWeight weight){
    return TextStyle(
        color: const Color(0xff9E772A),
        fontSize:size,
        fontWeight: weight,
        fontFamily: 'Raleway-Medium'
    );
  }

  //raleay medium
  TextStyle raleway_medium_darkbrown(double size,FontWeight weight){
    return TextStyle(
        color: const Color(0xff8B6824),
        fontSize:size,
        fontWeight: weight,
        fontFamily: 'Raleway-Medium'
    );
  }

  //raleay black medium
  TextStyle raleway_semi_black(double size,FontWeight weight){
    return TextStyle(
        color:  Colors.black,
        fontSize:size,
        fontWeight: weight,
        fontFamily: 'Raleway-SemiBold'
    );
  }
  TextStyle raleway_semi_444444(double size,FontWeight weight){
    return TextStyle(
        color:  Color(0xff444444),
        fontSize:size,
        fontWeight: weight,
        fontFamily: 'Raleway-SemiBold'
    );
  }


  //raleay black medium
  TextStyle raleway_medium_black(double size,FontWeight weight){
    return TextStyle(
        color:  Colors.black,
        fontSize:size,
        fontWeight: weight,
        fontFamily: 'Raleway-Medium'
    );
  }

  //raleay semibold
  TextStyle raleway_SemiBold_darkbrown(double size,FontWeight weight){
    return TextStyle(
        color: const Color(0xff8B6824),
        fontSize:size,
        fontWeight: weight,
        fontFamily: 'Raleway-SemiBold'
    );
  }


  TextStyle raleway_regular_333333(double size,FontWeight weight){
    return TextStyle(
        color: const Color(0xff333333),
        fontSize:size,
        fontWeight: weight,
        fontFamily: 'Raleway-Regular'
    );
  }
//light raleway brown

  //raleway regular
  TextStyle raleway_regular_brown(double size,FontWeight weight){
    return TextStyle(
        color: const Color(0xffD7C6A7),
        fontSize:size,
        fontWeight: weight,
        fontFamily: 'Raleway-Regular'
    );
  }

  //raleway light
  TextStyle raleway_light_brown(double size,FontWeight weight){
    return TextStyle(
        color: const Color(0xffD7C6A7),
        fontSize:size,
        fontWeight: weight,
        fontFamily: 'Raleway-Light'
    );
  }


  //raleway  black
  TextStyle raleway_black_brown(double size,FontWeight weight){
    return TextStyle(
        color: const Color(0xffD7C6A7),
        fontSize:size,
        fontWeight: weight,
        fontFamily: 'Raleway-Black'
    );
  }


  //raleay medium
  TextStyle raleway_medium_brown(double size,FontWeight weight){
    return TextStyle(
        color: const Color(0xffD7C6A7),
        fontSize:size,
        fontWeight: weight,
        fontFamily: 'Raleway-Medium'
    );
  }

  //raleay semibold
  TextStyle raleway_SemiBold_brown(double size,FontWeight weight){
    return TextStyle(
        color: const Color(0xffEFB546),
        fontSize:size,
        fontWeight: weight,
        fontFamily: 'Raleway-SemiBold'
    );

  }



  TextStyle raleway_050509(double size,FontWeight weight){
    return TextStyle(
        color:  Color(0xff050509),
        fontSize:size,
        fontWeight: weight,
        fontFamily: 'Raleway-SemiBold'
    );

  }
  //raleay semibold
  TextStyle raleway_SemiBold_white(double size,FontWeight weight){
    return TextStyle(
        color:  Colors.white,
        fontSize:size,
        fontWeight: weight,
        fontFamily: 'Raleway-SemiBold'
    );

  }
  TextStyle raleway_CCCCCC(double size,FontWeight weight){
    return TextStyle(
        color:  Color(0xffCCCCCC),
        fontSize:size,
        fontWeight: weight,
        fontFamily: 'Raleway-SemiBold'
    );

  }


  //raleay semibold
  TextStyle raleway_SemiBold_9E772A(double size,FontWeight weight){
    return TextStyle(
        color:  const Color(0xff9E772A),
        fontSize:size,
        fontWeight: weight,
        fontFamily: 'Raleway-SemiBold'
    );

  }

  //raleay semibold
  TextStyle raleway_SemiBold_F0BD5C(double size,FontWeight weight){
    return TextStyle(
        color:  const Color(0xffF0BD5C),
        fontSize:size,
        fontWeight: weight,
        fontFamily: 'Raleway-SemiBold'
    );

  }
  //raleay semibold
  TextStyle raleway_EFB546(double size,FontWeight weight) {
    return TextStyle(
        color: const Color(0xffEFB546),
        fontSize: size,
        fontWeight: weight,
        fontFamily: 'Raleway-Regular'
    );
  }
  //raleay semibold
  TextStyle raleway_2E2E2E(double size,FontWeight weight) {
    return TextStyle(
        color: const Color(0xff2E2E2E),
        fontSize: size,
        fontWeight: weight,
        fontFamily: 'Raleway-Regular'
    );
  }
  //raleay semibold
  TextStyle raleway_263238(double size,FontWeight weight) {
    return TextStyle(
        color: const Color(0xff263238),
        fontSize: size,
        fontWeight: weight,
        fontFamily: 'Raleway-Regular'
    );
  }
  TextStyle raleway_black_rgb(double size,FontWeight weight){
    return TextStyle(
        color: Color.fromRGBO(0, 0, 0, 0.8),
        fontSize:size,
        fontWeight: weight,
        fontFamily: 'Raleway-Regular'
    );
  }
  //raleay semibold
  TextStyle raleway_rgb_textfield(double size,FontWeight weight) {
    return TextStyle(
        color: Color.fromRGBO(83, 95, 91, 0.62),

        fontSize: size,
        fontWeight: weight,
        fontFamily: 'Raleway-Regular'
    );
  }

  //raleay semibold
  TextStyle raleway_1A5A47(double size,FontWeight weight) {
    return TextStyle(
        color: const Color(0xff1A5A47),
        fontSize: size,
        fontWeight: weight,
        fontFamily: 'Raleway-Regular'
    );
  }

  //raleay semibold
  TextStyle raleway_535F5B(double size,FontWeight weight) {
    return TextStyle(
        color: const Color(0xff535F5B),
        fontSize: size,
        fontWeight: weight,
        fontFamily: 'Raleway-Regular'
    );
  }

  //raleay extrabold
  TextStyle raleway_extrabold(double size,FontWeight weight) {
    return TextStyle(
        color: const Color(0xffEFB546),
        fontSize: size,
        fontWeight: weight,
        fontFamily: 'Raleway-ExtraBold'
    );
  }

  //raleway regular
  TextStyle manrope_regular263238(double size,FontWeight weight){
    return TextStyle(
        color: const Color(0xff263238),
        fontSize:size,
        fontWeight: weight,
        fontFamily: 'Manrope-Regular'
    );

  }

  //raleway regular
  TextStyle manrope_regular546E7A(double size,FontWeight weight){
    return TextStyle(
        color: const Color(0xff546E7A),
        fontSize:size,
        fontWeight: weight,
        fontFamily: 'Manrope-Regular'
    );
  }


  TextStyle manrope_regular78909C(double size,FontWeight weight){
    return TextStyle(
        color: const Color(0xff78909C),
        fontSize:size,
        fontWeight: weight,
        fontFamily: 'Manrope-Regular'
    );
  }
  TextStyle manrope_regular607D8B(double size,FontWeight weight){
    return TextStyle(
        color: const Color(0xff607D8B),
        fontSize:size,
        fontWeight: weight,
        fontFamily: 'Manrope-Regular'
    );
  }

  TextStyle manrope_regular_20C997(double size,FontWeight weight){
    return TextStyle(
        color:  Color(0xff20C997),
        fontSize:size,
        fontWeight: weight,
        fontFamily: 'Manrope-Regular'
    );
  }

  TextStyle manrope_regular_087F5B(double size,FontWeight weight){
    return TextStyle(
        color:  Color(0xff087F5B),
        fontSize:size,
        fontWeight: weight,
        fontFamily: 'Manrope-Regular'
    );
  }

  TextStyle manrope_regularwhite(double size,FontWeight weight){
    return TextStyle(
        color:  Colors.white,
        fontSize:size,
        fontWeight: weight,
        fontFamily: 'Manrope-Regular'
    );
  }
}
double distance_filter=100;
Color mycolor=Color(0xff20C997);
Color bgcolor=Color(0xffFFFFFF);
Color mylightcolor=Color(0xff2EF4BA);
Color rgbcolor=Color.fromRGBO(32, 201, 151, 0.27);
Color blackbutton=Color(0xff242C29);
