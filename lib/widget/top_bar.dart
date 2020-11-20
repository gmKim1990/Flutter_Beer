import 'package:flutter/material.dart';

class TopBar {
  topBar(BuildContext context, {String strTitle = '비어기록', String strSubTitle = '오늘의 짜릿함을 기록해보세요.',
  double dMarginLeft = 0.075, double dMarginTop = 0.025}) {
    Size screenSize = MediaQuery.of(context).size;
    double dWidth = screenSize.width;
    double dHeight = screenSize.height;
    return Container(
      padding: EdgeInsets.only(left: dWidth * dMarginLeft, top: dHeight * dMarginTop),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(strTitle, style: TextStyle(fontSize: dWidth * 0.075, color: Colors.amber)),
          Text(strSubTitle, style: TextStyle(fontSize: dWidth * 0.03, color: Colors.white60)),
        ],
      ),
    );
  }
}