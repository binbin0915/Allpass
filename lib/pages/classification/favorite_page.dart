import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:allpass/utils/allpass_ui.dart';
import 'package:allpass/provider/card_list.dart';
import 'package:allpass/provider/password_list.dart';
import 'package:allpass/pages/card/view_card_page.dart';
import 'package:allpass/pages/password/view_password_page.dart';

class FavoritePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "收藏",
          style: AllpassTextUI.titleBarStyle,
        ),
        centerTitle: true,
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: AllpassColorUI.mainBackgroundColor,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView(
        children: _getFavWidgets(context),
      ),
    );
  }

  List<Widget> _getFavWidgets(BuildContext context) {
    List<Widget> list = List();
    for (var passwordBean in Provider.of<PasswordList>(context).passwordList) {
      if (passwordBean.fav == 1) {
        try {
          list.add(Container(
            margin: AllpassEdgeInsets.listInset,
            //ListTile可以作为listView的一种子组件类型，支持配置点击事件，一个拥有固定样式的Widget
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: getRandomColor(passwordBean.uniqueKey),
                child: Text(
                  passwordBean.name.substring(0, 1),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              title: Text(passwordBean.name, overflow: TextOverflow.ellipsis,),
              subtitle: Text(passwordBean.username, overflow: TextOverflow.ellipsis,),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => ViewPasswordPage(passwordBean)
                )).then((bean) {
                  if (bean != null) {
                    if (bean.isChanged) {
                      Provider.of<PasswordList>(context).updatePassword(bean);
                    } else {
                      Provider.of<PasswordList>(context).deletePassword(passwordBean);
                    }
                  }
                });
              },
            ),
          ));
        } catch (e) {
          print(passwordBean.uniqueKey);
        }
      }
    }
    list.add(Container(
      child: Divider(thickness: 1.5,),
      padding: AllpassEdgeInsets.dividerInset,
    ));
    for (var cardBean in Provider.of<CardList>(context).cardList) {
      if (cardBean.fav == 1) {
        try {
          Color t = getRandomColor(cardBean.uniqueKey);
          list.add(Container(
            margin: AllpassEdgeInsets.listInset,
            child: ListTile(
              leading: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: t
                ),
                child: CircleAvatar(
                  backgroundColor: t,
                  child: Text(
                    cardBean.name.substring(0, 1),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              title: Text(cardBean.name),
              subtitle: Text(cardBean.ownerName),
              onTap: () => Navigator.push(context, MaterialPageRoute(
                  builder: (context) => ViewCardPage(cardBean)
              )).then((bean) {
                if (bean != null) {
                  // 改变了就更新，没改变就删除
                  if (bean.isChanged) {
                    Provider.of<CardList>(context).updateCard(bean);
                  } else {
                    Provider.of<CardList>(context).deleteCard(cardBean);
                  }
                }
              }),
            ),
          ));
        } catch (e) {
          print(e.toString());
        }
      }
    }
    if (list.length == 1) {
      list.add(Center(child: Text("什么也没有，赶快添加吧！"),));
    }
    return list;
  }

}