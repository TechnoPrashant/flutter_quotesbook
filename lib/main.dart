import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_quotebook/model/UserBean.dart';
import 'package:flutter_quotebook/screen/Home.dart';

import 'package:flutter_quotebook/screen/Login.dart';
import 'package:flutter_quotebook/utils/UtilsImporter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

void main() {
  runApp(MyApp());
}

final ThemeData kIOSTheme = ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light,
);

final ThemeData kDefaultTheme = ThemeData(
  primarySwatch: Colors.purple,
  accentColor: Colors.orangeAccent[400],
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      theme: defaultTargetPlatform == TargetPlatform.iOS
          ? kIOSTheme
          : kDefaultTheme,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  bool isUserLogin = false;
  Future<List<String>> userProfile;
  UserBean userBean;
  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  @override
  void initState() {
    super.initState();
    Future<bool> isLogin = UtilsImporter().preferencesUtils.getisLogin();
    isLogin.then((data) {
      isUserLogin = data;
    });
    controller = new AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.forward();
    startTime();
  }

  void navigationPage() {
    if (isUserLogin) {
      moveToHome();
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return Login();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FadeTransition(
            opacity: animation,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Image.asset(
                UtilsImporter().stringUtils.logo,
                height: 120,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ],
      ),
    );
  }

  moveToHome() {
    userProfile = UtilsImporter().preferencesUtils.getUserData();
    userProfile.then((data) {
      userProfile.then((data) {
        userBean =
            new UserBean(data[0], data[1], data[2], true, data[3], '', data[4]);
        UtilsImporter().commanUtils.setCurrentUser(userBean);
      }).whenComplete(() {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return Home();
        }));
      });
    });
  }
}
