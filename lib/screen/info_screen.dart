import 'package:flutter/material.dart';
import 'package:flutter_beerrecord/model/beer_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class InfoScreen extends StatefulWidget {
  final Beer beer;
  InfoScreen({this.beer});
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  //즐겨찾기
  bool like = false;
  //별점
  num rating = 0;

  @override
  void initState() {
    super.initState();
    like = widget.beer.like;
    rating = widget.beer.rating;
    print(rating);
    print(like);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double dWidth = screenSize.width;
    double dHeight = screenSize.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            child: Icon(Icons.arrow_back_ios),
          ),
        )
      ),
      body: Container(
        margin: EdgeInsets.only(top: dHeight * 0.02),
        child: SafeArea(
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Container(
                child: Image.asset('assets/images/' + widget.beer.photo),
                height: dHeight * 0.3,
              ),
              SizedBox(height: dHeight * 0.03),
              Container(
                margin: EdgeInsets.only(left: dWidth * 0.045, right: dWidth * 0.045),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(child: Text(widget.beer.title, style: TextStyle(fontSize: dWidth * 0.08, fontFamily: 'Stylish'))),
                        Container(child: Text(widget.beer.keyword, style: TextStyle(fontSize: dWidth * 0.03, color: Colors.white30))),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: dHeight * 0.01),
              Center(
                child: RatingBar.builder( //별점 그리기
                  initialRating: rating.toDouble(),
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemSize: 30,
                  itemCount: 5,
                  updateOnDrag: true,
                  itemBuilder: (context, index) => Icon(Icons.star, color: Colors.amber),
                  onRatingUpdate: (rating) {
                    print(rating);
                    setState(() {
                      widget.beer.reference.update({'rating': rating}); //별점 업데이트
                    });
                  },
                ),
              ),
              SizedBox(height: dHeight * 0.03),
              Container(
                margin: EdgeInsets.symmetric(horizontal: dWidth * 0.045),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Container(
                            width: dWidth * 0.06,
                            child: Image.asset('assets/images/' + widget.beer.countryImage),  //나라 이미지
                          ),
                          SizedBox(width: dWidth * 0.02),
                          Container(
                            //나라 이름
                            child: Text(widget.beer.country, style: TextStyle(fontSize: dWidth * 0.04, color: Colors.white70)),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          like = !like;
                          widget.beer.reference.update({'like': like}); //즐겨찾기 업데이트
                        });
                      },
                      child: Column(
                        children: <Widget>[
                          like ? Icon(Icons.favorite, color: Colors.red) : Icon(Icons.favorite),
                          SizedBox(height: dHeight * 0.01),
                          Text('즐겨찾기')
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: dHeight * 0.05),
              Container(
                margin: EdgeInsets.only(left: dWidth * 0.045, right: dWidth * 0.045),
                child: Text(widget.beer.info),  //맥주 설명
              ),
            ],
          ),
        ),
      )
    );
  }
}
