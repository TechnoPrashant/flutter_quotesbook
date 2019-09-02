import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quotebook/screen/Login.dart';
import 'package:flutter_quotebook/utils/UtilsImporter.dart';
import 'package:flutter_quotebook/model/UserBean.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          UtilsImporter().stringUtils.bottomMenuSetting,
          style: UtilsImporter().styleUtils.OTPTextFieldStyle(),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      backgroundColor: Colors.white,
      body: Profile(),
    );
  }
}

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var _bookmarkCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    getBookmarkCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 8, bottom: 8),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 6, right: 6),
                  margin: EdgeInsets.only(top: 40),
                  width: double.maxFinite,
                  height: 180,
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50))),
                  ),
                ),
                profileInfoWidget(),
              ],
            ),
            quoteCount(),
            logoutButton()
          ],
        ),
      ),
    );
  }

  Widget quoteCount() {
    return Container(
      padding: EdgeInsets.only(left: 6, right: 6),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50))),
        elevation: 3,
        child: Padding(
          padding: EdgeInsets.only(top: 30, bottom: 30),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'Bookmark Quotes\n' + _bookmarkCount.toString(),
                  textAlign: TextAlign.center,
                  style: UtilsImporter()
                      .styleUtils
                      .homeTextFieldStyleFontSizeColors(30, Colors.black87),
                ),
                flex: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget logoutButton() {
    return Container(
      margin: EdgeInsets.all(20),
      child: InkWell(
        child: UtilsImporter()
            .widgetUtils
            .buttonVerification('Logout', Colors.red),
        onTap: () {
          UtilsImporter().preferencesUtils.clearSharedPreferences();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Login()),
              (Route<dynamic> route) => false);
        },
      ),
    );
  }

  Widget profileInfoWidget() {
    if (UtilsImporter().commanUtils.getCurrentUser() != null &&
        UtilsImporter().commanUtils.getCurrentUser().fullname.length != 0) {
      return Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.black.withOpacity(0.60),
                      blurRadius: 4.0,
                    ),
                  ],
                  border: Border.all(
                      width: 1,
                      color: Colors.white70,
                      style: BorderStyle.solid),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(UtilsImporter()
                          .commanUtils
                          .getCurrentUser()
                          .profilPic),
                      fit: BoxFit.fill)),
            ),
            UtilsImporter().widgetUtils.spaceVertical(10),
            Text(
              UtilsImporter().commanUtils.getCurrentUser().fullname,
              style: UtilsImporter()
                  .styleUtils
                  .homeTextFieldStyleFontSizeColors(20, Colors.black87),
            ),
            Text(
              UtilsImporter().commanUtils.getCurrentUser().emailAddress,
              style: UtilsImporter()
                  .styleUtils
                  .homeTextFieldStyleFontSizeColors(14, Colors.grey),
            )
          ],
        ),
      );
    } else {
      return CircularProgressIndicator();
    }
  }

  void getBookmarkCount() {
    if (UtilsImporter().commanUtils.getCurrentUser() != null &&
        UtilsImporter().commanUtils.getCurrentUser().uid.length > 0) {
      UtilsImporter()
          .firebaseDatabaseUtils
          .firbaseUserRefereance
          .child(UtilsImporter().commanUtils.getCurrentUser().uid)
          .child('favourite')
          .once()
          .then((DataSnapshot snap) {
        Map data = snap.value;
        setState(() {
          _bookmarkCount = data.length;
        });
      }).catchError((data) {});
    }
  }
}
