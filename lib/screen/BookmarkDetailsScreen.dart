import 'package:auto_size_text/auto_size_text.dart';
import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quotebook/model/QuoteBean.dart';
import 'package:flutter_quotebook/utils/UtilsImporter.dart';
import 'package:random_color/random_color.dart';
import 'package:share/share.dart';

class BookmarkDetailsScreen extends StatefulWidget {
  List<QuoteBean> _listQuote = [];
  int _clickIndex;
  @override
  _BookmarkDetailsScreenState createState() =>
      _BookmarkDetailsScreenState(this._listQuote, this._clickIndex);

  BookmarkDetailsScreen(this._listQuote, this._clickIndex);
}

class _BookmarkDetailsScreenState extends State<BookmarkDetailsScreen> {
  List<QuoteBean> _listQuote = [];
  int _clickIndex;
  _BookmarkDetailsScreenState(this._listQuote, this._clickIndex);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          UtilsImporter().stringUtils.strQuote,
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
      body: Bookmark(_listQuote, _clickIndex),
    );
  }
}

class Bookmark extends StatefulWidget {
  List<QuoteBean> _listQuote = [];
  int _clickIndex;
  @override
  _BookmarkState createState() =>
      _BookmarkState(this._listQuote, this._clickIndex);

  Bookmark(this._listQuote, this._clickIndex);
}

class _BookmarkState extends State<Bookmark>
    with SingleTickerProviderStateMixin {
  List<QuoteBean> _listQuote = [];
  int _clickIndex;
  RandomColor _randomColor = RandomColor();
  AnimationController controller;
  Animation<double> animation;
  _BookmarkState(this._listQuote, this._clickIndex);

  @override
  void initState() {
    // TODO: implement initState

    controller = new AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.forward();
    super.initState();
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
      child: PageView.builder(
          controller: PageController(initialPage: _clickIndex),
          itemCount: _listQuote.length,
          onPageChanged: (index) {
            setState(() {
              controller.reset();
              controller.forward();
            });
          },
          itemBuilder: (context, position) {
            return Padding(
              padding: const EdgeInsets.only(
                  left: 26, right: 26, top: 30, bottom: 80),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(36))),
                color: Colors.white,
                elevation: 10,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: autherWidget(position),
                      flex: 1,
                    ),
                    Expanded(flex: 8, child: quoteTextWidget(position)),
                    Expanded(
                      child: bottomMenu(position),
                      flex: 1,
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget quoteTextWidget(int position) {
    return Center(
      child: FadeTransition(
        opacity: animation,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: AutoSizeText(
            _listQuote[position].qoute,
            style: UtilsImporter()
                .styleUtils
                .home2TextFieldStyle(_randomColor.randomColor()),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget autherWidget(int position) {
    return Container(
      padding: EdgeInsets.only(left: 20),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(_listQuote[position].autherImage),
          ),
          UtilsImporter().widgetUtils.spacehorizontal(6),
          AutoSizeText(
            _listQuote[position].autherName,
            style: UtilsImporter().styleUtils.homeTextFieldStyleFontSizeColors(
                10, Colors.black87.withOpacity(.50)),
          )
        ],
      ),
    );
  }

  Widget bottomMenu(int position) {
    return Container(
      margin: EdgeInsets.all(2),
      width: double.maxFinite,
      child: Container(
          child: Padding(
        padding: EdgeInsets.only(left: 30, right: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(
              onTap: () {
                UtilsImporter().firebaseDatabaseUtils.removeBookmark(
                    _listQuote[position],
                    UtilsImporter().commanUtils.getCurrentUser(),
                    context);
                setState(() {
                  _listQuote.removeAt(position);
                });
              },
              child: UtilsImporter().widgetUtils.quoteDetailsBottmItem(
                  UtilsImporter().stringUtils.btnRemoveBookmark,
                  Icons.bookmark_border),
            ),
            InkWell(
              onTap: () {
                ClipboardManager.copyToClipBoard(_listQuote[position].qoute)
                    .then((result) {
                  final snackBar = SnackBar(
                    content: Text(
                      'Copied',
                      style: UtilsImporter()
                          .styleUtils
                          .homeTextFieldStyleFontSizeColors(16, Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(45))),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.black87,
                    duration: Duration(seconds: 1),
                  );
                  Scaffold.of(context).showSnackBar(snackBar);
                });
              },
              child: UtilsImporter().widgetUtils.quoteDetailsBottmItem(
                  UtilsImporter().stringUtils.btnCopy, Icons.content_copy),
            ),
            InkWell(
              onTap: () {
                Share.share(_listQuote[position].qoute);
              },
              child: UtilsImporter().widgetUtils.quoteDetailsBottmItem(
                  UtilsImporter().stringUtils.btnShare, Icons.share),
            ),
          ],
        ),
      )),
    );
  }
}
