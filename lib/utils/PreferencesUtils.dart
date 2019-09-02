import 'package:flutter_quotebook/model/UserBean.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_quotebook/utils/StringConst.dart' as Const;
import 'dart:async';

import 'UtilsImporter.dart';

class PreferencesUtils {
  UserBean userBean;
  Future setisLogin() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(Const.StringConst.KEY_P_ISLOGIN, true);
  }

  Future<bool> getisLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(Const.StringConst.KEY_P_ISLOGIN) ?? false;
  }

  Future setUserData(List<String> listUserdata) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(Const.StringConst.KEY_P_USERDATA, listUserdata);
  }

  Future<List<String>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(Const.StringConst.KEY_P_USERDATA) ?? [];
  }

  Future clearSharedPreferences() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
  }
}
