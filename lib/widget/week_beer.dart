import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beerrecord/model/beer_model.dart';
import 'package:flutter_beerrecord/screen/info_screen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

//이번주 추천 맥주
class WeekBeer extends StatefulWidget {
  final List<Beer> beers;
  WeekBeer({this.beers});

  @override
  _WeekBeerState createState() => _WeekBeerState();
}

class _WeekBeerState extends State<WeekBeer> {
  List<Beer> beers;
  List<String> titles;
  List<String> keywords;
  List<Widget> photos;
  List<String> countrys;
  List<bool> likes;
  List<String> alcohols;
  List<String> logos;
  List<num> ratings;

  int _currentPage = 0; //현재 페이지
  String _currentTitle; //현재 타이틀
  String _currentKeyword; //현재 키워드
  num _currentRatings = 0;

  List<Color> titleColor = [Colors.orange, Colors.blueAccent, Colors.green];
  Color _currentColor;

  @override
  void initState() {
    super.initState();
    //리스트로 넣어줌
    beers = widget.beers;
    titles = beers.map((b) => b.title).toList();
    keywords = beers.map((b) => b.keyword).toList();
    photos = beers.map((b) => Image.asset('./assets/images/' + b.photo)).toList();
    countrys = beers.map((b) => b.country).toList();
    likes = beers.map((b) => b.like).toList();
    alcohols = beers.map((b) => b.alcohol).toList();
    ratings = beers.map((b) => b.rating).toList();
    print(ratings);
    _currentTitle = titles[0];
    _currentKeyword = keywords[0];
    _currentColor = titleColor[0];
    _currentRatings = ratings[0];
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double dWidth = screenSize.width;
    double dHeight = screenSize.height;
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: dHeight * 0.02),
        width: dWidth * 0.9,
        height: dHeight * 0.65,
        decoration: BoxDecoration(
          color: Colors.grey[800].withOpacity(0.5),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: Colors.blueAccent.withOpacity(0.5), width: 2)
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(dWidth * 0.02),
            ),
            Container(
              child: Text('이번주 추천 맥주', style: TextStyle(color: Colors.amber, fontSize: dWidth * 0.05)),
            ),
            Container(
              child: Text('이번주는 이 맥주 한잔 어떠세요?', style: TextStyle(color: Colors.white60, fontSize: dWidth * 0.03)),
            ),
            Container(
              padding: EdgeInsets.all(dWidth * 0.02),
            ),
            Container(
              width: dWidth * 0.7,
              child: CarouselSlider(
                items: photos,
                options: CarouselOptions(
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentPage = index;
                        _currentTitle = titles[_currentPage];
                        _currentKeyword = keywords[_currentPage];
                        _currentColor = titleColor[_currentPage];
                        _currentRatings = ratings[_currentPage];
                        print(_currentRatings);
                      });
                    }
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  child: Text(_currentTitle, style: TextStyle(fontSize: dWidth * 0.07, color: _currentColor, fontFamily: 'Stylish')),
                ),
                Container(
                  child: Text(_currentKeyword, style: TextStyle(fontSize: dWidth * 0.027, color: Colors.white60)),
                ),
                Center(
                  child: RatingBar.builder(
                    initialRating: _currentRatings.toDouble(),
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemSize: 25,
                    itemCount: 5,
                    updateOnDrag: true,
                    itemBuilder: (context, index) => Icon(Icons.star, color: Colors.amber),
                    onRatingUpdate: null,
                  ),
                ),
                SizedBox(
                  height: dHeight * 0.005,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: makeIndicator(context, likes, _currentPage),
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            likes[_currentPage]
                                ? IconButton(icon: Icon(Icons.favorite, color: Colors.red), onPressed: () {
                              setState(() {
                                likes[_currentPage] = !likes[_currentPage];
                                beers[_currentPage].reference.update({'like': likes[_currentPage]});
                              });
                            })
                                : IconButton(icon: Icon(Icons.favorite), onPressed: () {
                              setState(() {
                                likes[_currentPage] = !likes[_currentPage];
                                beers[_currentPage].reference.update({'like': likes[_currentPage]});
                              });
                            }),
                            Text('즐겨찾기', style: TextStyle(fontSize: dWidth * 0.025)),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            IconButton(icon: Icon(Icons.info), onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute<Null>(
                                fullscreenDialog: true,
                                builder: (BuildContext context) {
                                  return InfoScreen(
                                    beer: beers[_currentPage],
                                  );
                                },
                              ));
                            }),
                            Text('정보', style: TextStyle(fontSize: dWidth * 0.025)),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

//페이지 수 표시하는 점 만들기
List<Widget> makeIndicator(BuildContext context, List list, int _currentPage) {
  Size screenSize = MediaQuery.of(context).size;
  double dWidth = screenSize.width;
  double dHeight = screenSize.height;
  List<Widget> results = [];
  for (var i = 0; i < list.length; i++) {
    results.add(
      Container(
        width: dWidth * 0.02, height: dHeight * 0.02,
        margin: EdgeInsets.symmetric(vertical: dHeight * 0.01, horizontal: dWidth * 0.005),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _currentPage == i
            ? Color.fromRGBO(255, 255, 255, 0.9)
            : Color.fromRGBO(255, 255, 255, 0.4)
        ),
      )
    );
  }
  return results;
}
