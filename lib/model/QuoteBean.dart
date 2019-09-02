class QuoteBean {
  String _qoute;
  String _like;
  String _autherID;
  String _quoteKey;
  String _autherName;
  String _autherImage;
  String get autherName => _autherName;

  set autherName(String value) {
    _autherName = value;
  }

  String get qoute => _qoute;

  set qoute(String value) {
    _qoute = value;
  }

  String get quoteKey => _quoteKey;

  set quoteKey(String value) {
    _quoteKey = value;
  }

  String get autherID => _autherID;

  set autherID(String value) {
    _autherID = value;
  }

  String get like => _like;

  set like(String value) {
    _like = value;
  }

  QuoteBean(this._qoute, this._like, this._autherID, this._quoteKey,
      this._autherName, this._autherImage);

  QuoteBean.name(this._qoute, this._like, this._autherID, this._quoteKey,
      this._autherName, this._autherImage);

  String get autherImage => _autherImage;

  set autherImage(String value) {
    _autherImage = value;
  }
}
