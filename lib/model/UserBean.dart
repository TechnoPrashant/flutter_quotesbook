class UserBean {
  String _fullname;
  String _emailAddress;
  String _profilPic;
  bool _isSuccess;
  String _uid;
  String _loginProvide;
  String _nickname;

  UserBean.name(this._fullname, this._emailAddress, this._profilPic,
      this._isSuccess, this._uid, this._loginProvide, this._nickname);

  UserBean(this._fullname, this._emailAddress, this._profilPic, this._isSuccess,
      this._uid, this._loginProvide, this._nickname);

  String get fullname => _fullname;

  String get loginProvide => _loginProvide;

  set loginProvide(String value) {
    _loginProvide = value;
  }

  String get uid => _uid;

  set uid(String value) {
    _uid = value;
  }

  bool get isSuccess => _isSuccess;

  set isSuccess(bool value) {
    _isSuccess = value;
  }

  String get profilPic => _profilPic;

  set profilPic(String value) {
    _profilPic = value;
  }

  String get emailAddress => _emailAddress;

  set emailAddress(String value) {
    _emailAddress = value;
  }

  set fullname(String value) {
    _fullname = value;
  }

  String get nickname => _nickname;

  set nickname(String value) {
    _nickname = value;
  }
}
