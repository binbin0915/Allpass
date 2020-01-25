import 'package:flutter/material.dart';

import 'package:allpass/params/params.dart';
import 'package:allpass/utils/allpass_ui.dart';
import 'package:allpass/utils/screen_util.dart';
import 'package:allpass/pages/classification/favorite_page.dart';
import 'package:allpass/pages/classification/classification_details_page.dart';

class ClassificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "分类",
            style: AllpassTextUI.titleBarStyle,
          ),
          centerTitle: true,
          elevation: 0,
          brightness: Brightness.light,
          backgroundColor: AllpassColorUI.mainBackgroundColor,
          automaticallyImplyLeading: false,
        ),
        backgroundColor: AllpassColorUI.mainBackgroundColor,
        body: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: AllpassScreenUtil.setWidth(40),
            crossAxisSpacing: AllpassScreenUtil.setWidth(40),
          ),
          padding: AllpassEdgeInsets.listInset,
          children: getClassWidgets(context),
        )
    );
  }

  List<Widget> getClassWidgets(BuildContext context) {
    List<Widget> list  = List();
    list.add(
        InkWell(
          child: Card(
            color: Colors.redAccent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Center(
              child: Text("收藏",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          onTap: () => Navigator.push(context, MaterialPageRoute(
            builder: (context) => FavoritePage()
          )),
        )
    );
    list.addAll(Params.folderList.map((folder) =>
        InkWell(
          child: Card(
            color: getRandomColor(folder.hashCode),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Center(
              child: Text(folder,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => ClassificationDetailsPage(folder)
            ));
          },
        )
    ));
    return list;
  }
}