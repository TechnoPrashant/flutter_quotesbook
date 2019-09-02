import 'package:flutter/material.dart';
import 'package:flutter_quotebook/utils/StringUtils.dart';

import 'StringUtils.dart';

class StyleUtils {
  List<Shadow> textShadow() {
    double shadowsOffset = 2.0;
    return <Shadow>[
      Shadow(
        offset: Offset(shadowsOffset, shadowsOffset),
        blurRadius: 2.0,
        color: Colors.white,
      ),
      Shadow(
        offset: Offset(shadowsOffset, shadowsOffset),
        blurRadius: 4.0,
        color: Colors.grey,
      ),
    ];
  }

  InputDecoration textFieldDecoration(String hint) {
    return InputDecoration(
      contentPadding: EdgeInsets.all(16),
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(26)),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(26)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(26)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(26)),
      ),
    );
  }

  TextStyle loginTextFieldStyle() {
    return TextStyle(
        color: Colors.black,
        fontFamily: StringUtils().fontRoboto,
        fontSize: 14);
  }

  TextStyle OTPTextFieldStyle() {
    return TextStyle(
        color: Colors.black,
        fontFamily: StringUtils().fontRoboto,
        fontSize: 22);
  }

  TextStyle homeTextFieldStyle() {
    return TextStyle(
        color: Colors.black, fontFamily: StringUtils().fontLogin, fontSize: 36);
  }

  TextStyle homeTextFieldStyleFontSize(double fontSize) {
    return TextStyle(
        color: Colors.black,
        fontFamily: StringUtils().fontLogin,
        fontSize: fontSize);
  }

  TextStyle home2TextFieldStyle(Color color) {
    return TextStyle(
        color: color, fontFamily: StringUtils().fontLogin, fontSize: 36);
  }

  TextStyle homeTextFieldStyleFontSizeColors(double fontSize, Color color) {
    return TextStyle(
        color: color, fontFamily: StringUtils().fontLogin, fontSize: fontSize);
  }
}
