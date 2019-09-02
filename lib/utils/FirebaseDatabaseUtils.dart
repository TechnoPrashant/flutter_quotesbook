import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quotebook/model/QuoteBean.dart';
import 'package:flutter_quotebook/model/UserBean.dart';
import 'package:flutter_quotebook/utils/StringConst.dart' as Const;
import 'package:flutter_quotebook/utils/UtilsImporter.dart';

class FirebaseDatabaseUtils {
  final firbaseUserRefereance =
      FirebaseDatabase.instance.reference().child(Const.StringConst.TBL_USER);
  final firbaseQuoteCategoryRefereance = FirebaseDatabase.instance
      .reference()
      .child(Const.StringConst.TBL_CATEGORY);
  final firbaseAllQuoteRefereance = FirebaseDatabase.instance
      .reference()
      .child(Const.StringConst.TBL_CATEGORY)
      .child('All')
      .child('quotes');
  final firbaseCategoryQuoteRefereance = FirebaseDatabase.instance
      .reference()
      .child(Const.StringConst.TBL_CATEGORY);

  bool addContact(UserBean covariant, BuildContext context) {
    bool isAdded = true;
    firbaseUserRefereance.child(covariant.uid).set({
      Const.StringConst.KEY_NAME: covariant.fullname,
      Const.StringConst.KEY_EMAIL: covariant.emailAddress,
      Const.StringConst.KEY_PROFILE_PIC: covariant.profilPic,
      Const.StringConst.KEY_UID: covariant.uid,
      Const.StringConst.KEY_PROVIDER: covariant.loginProvide,
      Const.StringConst.KEY_NICK_NAME: covariant.nickname
    }).then((value) {
      isAdded = true;
      // Run extra code here
    }, onError: (error) {
      isAdded = false;
      UtilsImporter().commanUtils.showToast('', context);
      print(error);
    });
    return isAdded;
  }

  bool isAlreadyRegistered(UserBean userBean) {
    bool isExist = false;
    firbaseUserRefereance.child(userBean.uid).once().then((DataSnapshot snap) {
      if (snap.value != null) {
        isExist = true;
      } else {
        isExist = false;
      }
    });
    return isExist;
  }

  void addBookmark(
      QuoteBean quoteBean, UserBean userBean, BuildContext context) {
    firbaseUserRefereance
        .child(userBean.uid)
        .child('favourite')
        .child(quoteBean.quoteKey)
        .set({
      Const.StringConst.KEY_Q_AUTHERPIC: quoteBean.autherImage,
      Const.StringConst.KEY_Q_AUTHERNAME: quoteBean.autherName,
      Const.StringConst.KEY_Q_AUTHERID: quoteBean.autherID,
      Const.StringConst.KEY_Q_LIKE: quoteBean.like,
      Const.StringConst.KEY_Q_QUOTE: quoteBean.qoute,
      Const.StringConst.KEY_Q_KEY: quoteBean.quoteKey,
    }).catchError(((error) {
      UtilsImporter().commanUtils.showToast(error.toString(), context);
    })).then((data) {
      UtilsImporter().commanUtils.showToast('Added to Bookmark', context);
    });
  }

  void removeBookmark(
      QuoteBean quoteBean, UserBean userBean, BuildContext context) {
    firbaseUserRefereance
        .child(userBean.uid)
        .child('favourite')
        .child(quoteBean.quoteKey)
        .remove()
        .catchError(((error) {
      UtilsImporter().commanUtils.showToast(error.toString(), context);
    })).then((data) {
      UtilsImporter().commanUtils.showToast('Removed from bookmark', context);
    });
  }
}
