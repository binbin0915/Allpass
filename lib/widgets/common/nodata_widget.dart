import 'package:flutter/material.dart';

import 'package:allpass/ui/allpass_ui.dart';
import 'package:allpass/ui/icon_resource.dart';
import 'package:allpass/utils/screen_util.dart';

class NoDataWidget extends StatelessWidget {

  final String additionalInfo;

  NoDataWidget(this.additionalInfo);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: AllpassScreenUtil.setHeight(400)),
        ),
        Padding(
          child: Center(
            child: Icon(
              CustomIcons.noData,
              size: AllpassScreenUtil.setWidth(100),
            ),
          ),
          padding: AllpassEdgeInsets.smallTBPadding,
        ),
        Padding(
          child: Center(child: Text("什么也没有，赶快添加吧"),),
          padding: AllpassEdgeInsets.forCardInset,
        ),
        Padding(
          padding: AllpassEdgeInsets.smallTBPadding,
        ),
        additionalInfo == null ?
            Container() :
            Padding(
              child: Center(
                child: Text(
                  additionalInfo,
                  textAlign: TextAlign.center,
                ),
              ),
              padding: AllpassEdgeInsets.forCardInset,
        )
      ],
    );
  }
}