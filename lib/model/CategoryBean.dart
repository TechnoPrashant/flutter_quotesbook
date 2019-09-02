class CategoryBean {
  String _name;
  String _image;

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  CategoryBean.name(this._name, this._image);

  CategoryBean(this._name, this._image);
}
