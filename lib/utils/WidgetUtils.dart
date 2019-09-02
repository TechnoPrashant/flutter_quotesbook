import 'package:flutter/material.dart';
import 'package:flutter_quotebook/utils/UtilsImporter.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:random_color/random_color.dart';

class WidgetUtils {
  RandomColor _randomColor = RandomColor();

  Widget button(String buttonName) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))),
      color: Colors.black,
      child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: Center(
            child: Text(
              buttonName,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: UtilsImporter().stringUtils.fontRoboto),
            ),
          )),
    );
  }

  Widget buttonVerification(String buttonName, Color color) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))),
      color: color,
      child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: Center(
            child: Text(
              buttonName,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: UtilsImporter().stringUtils.fontRoboto),
            ),
          )),
    );
  }

  Widget socialButton(String imageName, Color color) {
    return Container(
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(90)),
          boxShadow: [
            new BoxShadow(
              color: color.withOpacity(0.40),
              blurRadius: 5.0,
            ),
          ]),
      child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(80))),
          child: Image.asset(
            imageName,
            height: 48,
            width: 48,
          )),
    );
  }

  Widget spaceVertical(double height) {
    return SizedBox(
      height: height,
    );
  }

  Widget spacehorizontal(double width) {
    return SizedBox(
      width: width,
    );
  }

  BubbleBottomBarItem bottomItem(String name, IconData icon) {
    return BubbleBottomBarItem(
        backgroundColor: Colors.redAccent,
        icon: Icon(
          icon,
          color: Colors.black,
        ),
        activeIcon: Icon(
          icon,
          color: Colors.redAccent,
        ),
        title: Text(name));
  }

  Widget quoteDetailsBottmItem(String name, IconData iconData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          iconData,
          color: _randomColor.randomColor(),
        ),
        Text(
          name,
          style: UtilsImporter()
              .styleUtils
              .homeTextFieldStyleFontSizeColors(10, Colors.black87),
        )
      ],
    );
  }
}
