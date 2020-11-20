import 'package:flutter/material.dart';
import 'package:flutter_beerrecord/model/beer_model.dart';
import 'package:flutter_beerrecord/screen/info_screen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ListViewBeer extends StatelessWidget {
  final List<Beer> beers;
  Color cBackground;
  double dOpacity;
  double dOpacityBorder;
  double dCountryImage;
  String strCountryName;
  String strCountryImage;
  String strCountrySubName;
  double dMarginLR;
  double dMarginTop;
  double dMarginBottom;
  ListViewBeer({this.beers, this.cBackground, this.dOpacity, this.dOpacityBorder, this.dCountryImage,
  this.strCountryName, this.strCountryImage, this.strCountrySubName, this.dMarginLR, this.dMarginTop, this.dMarginBottom});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double dWidth = screenSize.width;
    double dHeight = screenSize.height;
    return Container(
      height: dHeight * 0.5,
      margin: EdgeInsets.only(left: dWidth * dMarginLR, right: dWidth * dMarginLR, top: dHeight * dMarginTop, bottom: dHeight * dMarginBottom),
      decoration: BoxDecoration(
        color: cBackground.withOpacity(dOpacity),
        border: Border.all(color: Colors.transparent.withOpacity(dOpacityBorder)),
        borderRadius: BorderRadius.all(Radius.circular(20.0))
      ),
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              SizedBox(height: dHeight * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: dWidth * 0.07, child: Image.asset(strCountryImage)),
                  SizedBox(width: dWidth * 0.02),
                  Text(strCountryName, style: TextStyle(fontSize: dWidth * 0.045)),
                ],
              ),
              SizedBox(height: dHeight * 0.005),
              Text(strCountrySubName, style: TextStyle(fontSize: dWidth * 0.025, color: Colors.white60))
            ],
          ),
          Column(
            children: [
              Container(
                height: dHeight * 0.35,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: makeBeerImages(context, beers),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

//가로 리스트뷰 만듬
List<Widget> makeBeerImages(BuildContext context, List<Beer> beers) {
  Size screenSize = MediaQuery.of(context).size;
  double dWidth = screenSize.width;
  double dHeight = screenSize.height;
  List<Widget> results = [];
  for (var i = 0; i < beers.length; i++) {
    results.add(
      InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute<Null>(
            fullscreenDialog: true,
            builder: (BuildContext context) {
              return InfoScreen(
                beer: beers[i],
              );
            },
          ));
        },
        child: Container(
              margin: EdgeInsets.only(left: dWidth * 0.01, right: dWidth * 0.01),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: dHeight * 0.02),
                  Container(height: dHeight * 0.2, child: Image.asset('assets/images/' + beers[i].photo)),
                  SizedBox(height: dHeight * 0.01),
                  Text(beers[i].title, style: TextStyle(fontFamily: 'Stylish', fontSize: dWidth * 0.04)),
                  Container(width: dWidth * 0.25, child: Text(beers[i].keyword, maxLines: 2, overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center, style: TextStyle(fontSize: dWidth * 0.025, color: Colors.white60))),
                  RatingBar.builder(
                    initialRating: beers[i].rating.toDouble(),
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemSize: 15,
                    itemCount: 5,
                    updateOnDrag: true,
                    itemBuilder: (context, index) => Icon(Icons.star, color: Colors.amber),
                    onRatingUpdate: null,
                  ),
                ],
              ),
            ),
      )
    );
  }
  return results;
}