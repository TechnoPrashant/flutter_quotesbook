import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quotebook/utils/UtilsImporter.dart';
import 'package:flutter_quotebook/model/CategoryBean.dart';
import 'package:flutter_quotebook/utils/StringConst.dart' as Const;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:random_color/random_color.dart';
import 'package:flutter_quotebook/screen/CategoryDetailScreen.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  List<CategoryBean> _listQuoteCategoery = [];
  bool isLoading = true;
  RandomColor _randomColor = RandomColor();
  AnimationController controller;
  Animation<double> animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.forward();
    getCategoryList();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    deactivate();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      child: categoryGridList(),
    );
  }

  Widget categoryGridList() {
    if (isLoading) {
      return Container(
          child: Center(
        child: CircularProgressIndicator(),
      ));
    } else {
      return StaggeredGridView.countBuilder(
        scrollDirection: Axis.vertical,
        primary: false,
        crossAxisCount: 4,
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
        staggeredTileBuilder: (int index) =>
            new StaggeredTile.count(2, index.isEven ? 1 : 1),
        itemCount: _listQuoteCategoery.length,
        itemBuilder: (BuildContext context, int index) => new Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: _randomColor.randomColor().withOpacity(0.90),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              elevation: 8,
              child: FadeTransition(
                opacity: animation,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 30),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CategoryDetailScreen(_listQuoteCategoery[index]);
                      }));
                    },
                    child: AutoSizeText(
                      _listQuoteCategoery[index].name,
                      style: UtilsImporter()
                          .styleUtils
                          .home2TextFieldStyle(Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  void getCategoryList() {
    Future<bool> result = UtilsImporter().commanUtils.checkConnection();
    result.then((data) {
      if (data) {
        if (_listQuoteCategoery.length > 0) _listQuoteCategoery.clear();
        UtilsImporter()
            .firebaseDatabaseUtils
            .firbaseQuoteCategoryRefereance
            .once()
            .then((DataSnapshot snap) {
          var keys = snap.value.keys;
          var data = snap.value;
          setState(() {
            for (var key in keys) {
              CategoryBean categoryBean = new CategoryBean(
                  data[key][Const.StringConst.KEY_C_NAME],
                  data[key][Const.StringConst.KEY_C_IMAGE]);
              _listQuoteCategoery.add(categoryBean);
            }
            isLoading = false;
          });
        });
      } else {
        UtilsImporter()
            .commanUtils
            .showToast(UtilsImporter().stringUtils.messgeNoInternet, context);
      }
    });
  }
}
