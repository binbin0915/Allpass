import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:allpass/params/params.dart';
import 'package:allpass/provider/password_list.dart';
import 'package:allpass/utils/allpass_ui.dart';
import 'package:allpass/utils/encrypt_util.dart';
import 'package:allpass/pages/password/view_password_page.dart';

class PasswordWidgetItem extends StatelessWidget {
  final int index;

  PasswordWidgetItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Consumer<PasswordList>(
      builder: (context, model, child) {
        return Container(
          margin: AllpassEdgeInsets.listInset,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: getRandomColor(model.passwordList[index].uniqueKey),
              child: Text(
                model.passwordList[index].name.substring(0, 1),
                style: TextStyle(color: Colors.white),
              ),
            ),
            title: Text(model.passwordList[index].name, overflow: TextOverflow.ellipsis,),
            subtitle: Text(model.passwordList[index].username, overflow: TextOverflow.ellipsis,),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => ViewPasswordPage(model.passwordList[index])
              )).then((bean) {
                if (bean != null) {
                  if (bean.isChanged) {
                    model.updatePassword(bean);
                  } else {
                    model.deletePassword(model.passwordList[index]);
                  }
                }
              });
            },
            onLongPress: () {
              if (Params.longPressCopy) {
                Clipboard.setData(ClipboardData(
                    text: EncryptUtil.decrypt(model.passwordList[index].password)
                ));
                Fluttertoast.showToast(msg: "已复制密码");
              }
            },
          ),
        );
      },
    );
  }
}

class MultiPasswordWidgetItem extends StatefulWidget {

  final int index;
  MultiPasswordWidgetItem(this.index);

  @override
  State<StatefulWidget> createState() {
    return _MultiPasswordWidgetItem(this.index);
  }

}

class _MultiPasswordWidgetItem extends State<StatefulWidget> {
  final int index;

  _MultiPasswordWidgetItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Consumer<PasswordList>(
      builder: (context, model, child) {
        return Container(
          margin: AllpassEdgeInsets.listInset,
          child: CheckboxListTile(
            value: Params.multiPasswordList.contains(model.passwordList[index]),
            onChanged: (value) {
              setState(() {
                if (value) {
                  Params.multiPasswordList.add(model.passwordList[index]);
                } else {
                  Params.multiPasswordList.remove(model.passwordList[index]);
                }
              });
            },
            secondary: CircleAvatar(
              backgroundColor: getRandomColor(model.passwordList[index].uniqueKey),
              child: Text(
                model.passwordList[index].name.substring(0, 1),
                style: TextStyle(color: Colors.white),
              ),
            ),
            title: Text(model.passwordList[index].name, overflow: TextOverflow.ellipsis,),
            subtitle: Text(model.passwordList[index].username, overflow: TextOverflow.ellipsis,),
          ),
        );
      },
    );
  }
}