import 'package:flutter/material.dart';

//홈스크린에 Ale, Lager 컨테이너
class AleBeer extends StatelessWidget {
  String strImage;
  String strName;
  String strSubName;
  AleBeer({this.strImage, this.strName, this.strSubName});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double dWidth = screenSize.width;
    double dHeight = screenSize.height;
    return Center(
      child: GestureDetector(
        onTap: () {},
        child: Container(
          margin: EdgeInsets.only(top: dHeight * 0.02),
          width: dWidth * 0.9,
          height: dHeight * 0.3,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(strImage),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.grey[800].withOpacity(0.7), BlendMode.dstATop)
              ),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: Colors.blueAccent.withOpacity(0.5), width: 2)
          ),
          child: Container(
            margin: EdgeInsets.only(left: dWidth * 0.06, top: dHeight * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(strName, style: TextStyle(fontSize: dWidth * 0.07, color: Colors.amber)),
                Text(strSubName, style: TextStyle(fontSize: dWidth * 0.03, color: Colors.white70)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
