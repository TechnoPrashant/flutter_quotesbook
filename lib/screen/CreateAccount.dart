import 'package:flutter/material.dart';
import 'package:flutter_quotebook/model/UserBean.dart';
import 'package:flutter_quotebook/screen/Login.dart';
import 'package:flutter_quotebook/utils/UtilsImporter.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

class CreateAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
      ),
      body: CreateAccountScreen(),
    );
  }
}

class CreateAccountScreen extends StatefulWidget {
  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  double cardElevation = 8;
  TextEditingController _textEditingControllerName =
      new TextEditingController();
  TextEditingController _textEditingControllerEmail =
      new TextEditingController();
  bool isLoginSuccess = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(UtilsImporter().stringUtils.lableCreateAccount,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: UtilsImporter().stringUtils.fontLogin,
                      fontWeight: FontWeight.w700,
                      fontSize: 40,
                      shadows: UtilsImporter().styleUtils.textShadow())),
              UtilsImporter().widgetUtils.spaceVertical(30),
              Card(
                elevation: cardElevation,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(26))),
                child: TextField(
                  controller: _textEditingControllerName,
                  maxLines: 1,
                  style: UtilsImporter().styleUtils.loginTextFieldStyle(),
                  decoration: UtilsImporter().styleUtils.textFieldDecoration(
                      UtilsImporter().stringUtils.hintFullname),
                ),
              ),
              UtilsImporter().widgetUtils.spaceVertical(20),
              Card(
                elevation: cardElevation,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(26))),
                child: TextField(
                  controller: _textEditingControllerEmail,
                  maxLines: 1,
                  style: UtilsImporter().styleUtils.loginTextFieldStyle(),
                  decoration: UtilsImporter().styleUtils.textFieldDecoration(
                      UtilsImporter().stringUtils.hintEmail),
                ),
              ),
              UtilsImporter().widgetUtils.spaceVertical(40),
              InkWell(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: UtilsImporter()
                    .widgetUtils
                    .button(UtilsImporter().stringUtils.btnCreateAccount),
                onTap: () {
                  if (!UtilsImporter()
                      .commanUtils
                      .validateName(_textEditingControllerName.text)) {
                    UtilsImporter().commanUtils.showToast(
                        UtilsImporter().stringUtils.retrunName, context);
                  } else if (!UtilsImporter()
                      .commanUtils
                      .validateEmail(_textEditingControllerEmail.text)) {
                    UtilsImporter().commanUtils.showToast(
                        UtilsImporter().stringUtils.retrunEmail, context);
                  } else {
                    Future<UserBean> userAuthData = UtilsImporter()
                        .firebaseAuthUtils
                        .signUpWithEmail(_textEditingControllerEmail.text,
                            '123456', context);
                    userAuthData.then((data) {
                      isLoginSuccess = data.isSuccess;
                      if (isLoginSuccess) {
                        UtilsImporter()
                            .firebaseAuthUtils
                            .resetPassword(_textEditingControllerEmail.text);
                        setState(() {
                          _textEditingControllerEmail.text = '';
                          _textEditingControllerName.text = '';
                        });
                        UtilsImporter().commanUtils.showToast(
                            UtilsImporter().stringUtils.messageSuccess,
                            context);
                        showSuccessDialog();
                      }
                    });
                  }
                },
                splashColor: Colors.black,
              ),
              UtilsImporter().widgetUtils.spaceVertical(40),
            ],
          ),
        ),
      ),
    );
  }

  void showSuccessDialog() {
    showDialog(
        context: context,
        builder: (_) => AssetGiffyDialog(
              title: Text(
                UtilsImporter().stringUtils.messageTitle,
                style: UtilsImporter().styleUtils.loginTextFieldStyle(),
              ),
              image: Image.asset('images/email.gif'),
              description: Text(
                UtilsImporter().stringUtils.messageSuccess,
                textAlign: TextAlign.center,
                style: UtilsImporter().styleUtils.OTPTextFieldStyle(),
              ),
              onlyOkButton: true,
              onOkButtonPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return Login();
                }));
              },
            ));
  }
}
