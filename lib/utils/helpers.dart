import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopflut_blocv1/widgets/toast_animation/achievement_view.dart';

class Helpers {
  static final Helpers _singleton = new Helpers._internal();

  factory Helpers() {
    return _singleton;
  }

  Helpers._internal();

  void showToast(BuildContext context, String title, String subTitle,
      [bool isCircle]) {
    isCircle ??= true;
    AchievementView(context,
        title: title,
        borderRadius: 0.5,
        color: Colors.blueGrey,
        alignment: Alignment.topCenter,
        duration: Duration(seconds: 1),
        subTitle: subTitle,
        isCircle: isCircle, listener: (status) {
      print(status);
    })
      ..show();
  }
}
