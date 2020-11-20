import 'package:flutter/material.dart';

//바텀메뉴바
class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double dWidth = screenSize.width;
    double dHeight = screenSize.height;
    return Container(
      height: dHeight * 0.07,
      child: TabBar(
        labelColor: Colors.amber,
        unselectedLabelColor: Colors.white60,
        indicatorColor: Colors.amber,
        tabs: [
          Tab(icon: Icon(Icons.home, size: dWidth * 0.04), child: Text('홈', style: TextStyle(fontSize: dWidth * 0.025))),
          Tab(icon: Icon(Icons.menu_book, size: dWidth * 0.04), child: Text('맥주도감', style: TextStyle(fontSize: dWidth * 0.025))),
          Tab(icon: Icon(Icons.search_outlined, size: dWidth * 0.04), child: Text('검색', style: TextStyle(fontSize: dWidth * 0.025))),
          Tab(icon: Icon(Icons.menu, size: dWidth * 0.04), child: Text('더보기', style: TextStyle(fontSize: dWidth * 0.025))),
        ],
      ),
    );
  }
}
