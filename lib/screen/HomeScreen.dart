import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_quotebook/utils/UtilsImporter.dart';
import 'package:flutter_quotebook/model/QuoteBean.dart';
import 'package:flutter_quotebook/utils/StringConst.dart' as Const;
import 'package:random_color/random_color.dart';
import 'package:flutter_quotebook/screen/QuoteDetailsScreen.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  List<QuoteBean> _listQuote = [];
  bool isLoading = true;
  AnimationController controller;
  Animation<double> animation;
  RandomColor _randomColor = RandomColor();
  int currentOPage = 1;
  String nextKey;
  bool isReach = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllQuoteList();
    controller = new AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: quoteGridList(),
    );
  }

  void getAllQuoteList() {
    Future<bool> result = UtilsImporter().commanUtils.checkConnection();
    result.then((data) {
      if (data) {
        UtilsImporter()
            .firebaseDatabaseUtils
            .firbaseAllQuoteRefereance
            .once()
            .then((DataSnapshot snap) {
          var keys = snap.value.keys;
          var data = snap.value;
          setState(() {
            for (var key in keys) {
              QuoteBean quoteBean = new QuoteBean(
                data[key][Const.StringConst.KEY_Q_QUOTE],
                data[key][Const.StringConst.KEY_Q_LIKE],
                data[key][Const.StringConst.KEY_Q_AUTHERID],
                key,
                data[key][Const.StringConst.KEY_Q_AUTHERNAME],
                data[key][Const.StringConst.KEY_Q_AUTHERPIC],
              );
              nextKey = key;
              _listQuote.add(quoteBean);
            }
            _listQuote.shuffle();
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

  Widget quoteGridList() {
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
        itemCount: _listQuote.length,
        staggeredTileBuilder: (int index) =>
            new StaggeredTile.count(2, index.isEven ? 3 : 2),
        itemBuilder: (BuildContext context, int index) => new Container(
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16))),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(26.0),
              child: FadeTransition(
                opacity: animation,
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return QuoteDetailsScreen(_listQuote, index);
                    }));
                  },
                  child: AutoSizeText(
                    _listQuote[index].qoute,
                    style: UtilsImporter()
                        .styleUtils
                        .home2TextFieldStyle(_randomColor.randomColor()),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}
