import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beerrecord/model/beer_model.dart';
import 'package:flutter_beerrecord/screen/info_screen.dart';
import 'package:flutter_beerrecord/widget/top_bar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _filter = TextEditingController();
  FocusNode focusNode = FocusNode();
  String _searchText = '';

  _SearchScreenState() {
    _filter.addListener(() {
      setState(() {
        _searchText = _filter.text;
      });
    });
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot> (
      stream: FirebaseFirestore.instance.collection('beer').snapshots(),
      builder: (context, snapshot) {
        if(!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data.docs);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    List<DocumentSnapshot> searchResults = [];
    for (DocumentSnapshot d in snapshot) {
      if (d.data().toString().contains(_searchText)) {
        searchResults.add(d);
      }
    }
    return Expanded(
        //그리드뷰로 맥주 리스트 표시
        child: GridView.count(
          physics: BouncingScrollPhysics(),
          crossAxisCount: 3,
          childAspectRatio: 1 / 1.5,
          padding: EdgeInsets.all(3),
          children: searchResults.map((data) => _buildListItem(context, data)).toList(),
        )
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final beer = Beer.fromSnapShot(data);
    return InkWell(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('./assets/images/' + beer.photo),
          Container(width: MediaQuery.of(context).size.width * 0.3, child:
          Center(child: Text(beer.title, overflow: TextOverflow.ellipsis))),
          RatingBar.builder(
            initialRating: beer.rating.toDouble(),
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemSize: 14,
            itemCount: 5,
            updateOnDrag: true,
            itemBuilder: (context, index) => Icon(Icons.star, color: Colors.amber),
            onRatingUpdate: null,
          ),
        ],
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute<Null>(
            fullscreenDialog: true,
            builder: (BuildContext context) {
              return InfoScreen(beer: beer);
            }
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double dWidth = screenSize.width;
    double dHeight = screenSize.height;
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopBar().topBar(context, strTitle: '맥주검색', strSubTitle: '원하는 맥주를 찾아보세요.', dMarginTop: 0.065),
            Container(
              color: Colors.transparent,
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: TextField(
                      focusNode: focusNode,
                      style: TextStyle(
                        fontSize: dWidth * 0.04
                      ),
                      autofocus: true,
                      controller: _filter,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white12,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.white60,
                          size: dWidth * 0.04,
                        ),
                        suffixIcon: focusNode.hasFocus
                          ? IconButton(icon: Icon(Icons.cancel, size: dWidth * 0.04), onPressed: () {
                            setState(() {
                              _filter.clear();
                              _searchText = '';
                            });})
                          : Container(),
                        hintText: '검색',
                        labelStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                      ),
                    ),
                  ),
                  focusNode.hasFocus
                    ? Expanded(child: FlatButton(
                        child: Text('취소', style: TextStyle(fontSize: dWidth * 0.03),),
                        onPressed: () {
                          setState(() {
                            _filter.clear();
                            _searchText = '';
                            focusNode.unfocus();
                          });},
                        ),
                      )
                    : Expanded(flex: 0, child: Container())
                ],
              ),
            ),
            _buildBody(context)
          ],
        ),
    );
  }
}
