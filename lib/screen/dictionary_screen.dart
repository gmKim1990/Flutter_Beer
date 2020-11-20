import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beerrecord/model/beer_model.dart';
import 'package:flutter_beerrecord/widget/listview_beer.dart';
import 'package:flutter_beerrecord/widget/top_bar.dart';

class DictionaryScreen extends StatefulWidget {
  @override
  _DictionaryScreenState createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  //Firebase 정보 받아오기
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot> streamDeutschland;  //독일 맥주 쿼리
  Stream<QuerySnapshot> streamDataFavorite; //즐겨찾기, 좋아요 맥주 쿼리
  Stream<QuerySnapshot> streamNederland;  //네덜란드 맥주 쿼리
  Stream<QuerySnapshot> streamCzech;  //체코 맥주 쿼리
  Stream<QuerySnapshot> streamBel;    //벨기에 맥주 쿼리

  @override
  void initState() {
    super.initState();
    streamDeutschland = firebaseFirestore.collection('beer').where('country', isEqualTo: '독일').snapshots();
    streamDataFavorite = firebaseFirestore.collection('beer').where('like', isEqualTo: true).snapshots();
    streamNederland = firebaseFirestore.collection('beer').where('country', isEqualTo: '네덜란드').snapshots();
    streamCzech = firebaseFirestore.collection('beer').where('country', isEqualTo: '체코').snapshots();
    streamBel = firebaseFirestore.collection('beer').where('country', isEqualTo: '벨기에').snapshots();
  }

  //즐겨찾기
  Widget _fetchFavoriteData(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: streamDataFavorite,
      builder: (context, snapshot) {
        if(!snapshot.hasData) return LinearProgressIndicator();
        return _buildBodyFavorite(context, snapshot.data.docs);
      },
    );
  }

  Widget _buildBodyFavorite(BuildContext context, List<DocumentSnapshot> snapshot) {
    List<Beer> beers = snapshot.map((d) => Beer.fromSnapShot(d)).toList();
    return ListViewBeer(beers: beers, cBackground: Colors.transparent, dOpacity: 0.0, dOpacityBorder: 0.0,
        dCountryImage: 0.05, strCountryName: '내가 좋아하는 맥주', strCountryImage: 'assets/images/heart.png',
        strCountrySubName: '내가 좋아하는 맥주들을 채워보세요.', dMarginLR: 0.035, dMarginTop: 0.05, dMarginBottom: 0.0);
  }

  //독일
  Widget _fetchDeutschlandData(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: streamDeutschland,
      builder: (context, snapshot) {
        if(!snapshot.hasData) return LinearProgressIndicator();
        return _buildDeutschlandBody(context, snapshot.data.docs);
      },
    );
  }

  Widget _buildDeutschlandBody(BuildContext context, List<DocumentSnapshot> snapshot) {
    List<Beer> beers = snapshot.map((d) => Beer.fromSnapShot(d)).toList();
    return ListViewBeer(beers: beers, cBackground: Colors.amber, dOpacity: 0.6, dOpacityBorder: 0.5,
        dCountryImage: 0.06, strCountryName: '독일', strCountryImage: 'assets/images/ge.png',
        strCountrySubName: '전 세계의 맥주 애호가들이 모이는 \'옥토퍼페스트\'의 나라 독일!',
        dMarginLR: 0.035, dMarginTop: 0.05, dMarginBottom: 0.0);
  }

  //네덜란드
  Widget _fetchNederlandData(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: streamNederland,
      builder: (context, snapshot) {
        if(!snapshot.hasData) return LinearProgressIndicator();
        return _buildBodyNederland(context, snapshot.data.docs);
      },
    );
  }

  Widget _buildBodyNederland(BuildContext context, List<DocumentSnapshot> snapshot) {
    List<Beer> beers = snapshot.map((d) => Beer.fromSnapShot(d)).toList();
    return ListViewBeer(beers: beers, cBackground: Colors.deepOrange, dOpacity: 0.8, dOpacityBorder: 0.5,
        dCountryImage: 0.06, strCountryName: '네덜란드', strCountryImage: 'assets/images/ne.png',
        strCountrySubName: '전 세계에서 엄청난 인지도를 가진 하이네켄의 나라 네덜란드!',
        dMarginLR: 0.035, dMarginTop: 0.05, dMarginBottom: 0.0);
  }

  //체코
  Widget _fetchCzechData(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: streamCzech,
      builder: (context, snapshot) {
        if(!snapshot.hasData) return LinearProgressIndicator();
        return _buildBodyCzech(context, snapshot.data.docs);
      },
    );
  }

  Widget _buildBodyCzech(BuildContext context, List<DocumentSnapshot> snapshot) {
    List<Beer> beers = snapshot.map((d) => Beer.fromSnapShot(d)).toList();
    return ListViewBeer(beers: beers, cBackground: Colors.indigoAccent, dOpacity: 0.8, dOpacityBorder: 0.5,
        dCountryImage: 0.06, strCountryName: '체코', strCountryImage: 'assets/images/ch.png',
        strCountrySubName: '전 세계에서 1인당 맥주 소비량 1위의 나라 체코!',
        dMarginLR: 0.035, dMarginTop: 0.05, dMarginBottom: 0.0);
  }

  //벨기에
  Widget _fetchBelData(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: streamBel,
      builder: (context, snapshot) {
        if(!snapshot.hasData) return LinearProgressIndicator();
        return _buildBodyBel(context, snapshot.data.docs);
      },
    );
  }

  Widget _buildBodyBel(BuildContext context, List<DocumentSnapshot> snapshot) {
    List<Beer> beers = snapshot.map((d) => Beer.fromSnapShot(d)).toList();
    return ListViewBeer(beers: beers, cBackground: Colors.teal, dOpacity: 0.8, dOpacityBorder: 0.5,
        dCountryImage: 0.06, strCountryName: '벨기에', strCountryImage: 'assets/images/belgie.png',
        strCountrySubName: '전 세계에서 가장 다양하고 특색 있는 맥주를 생산하고 있는 나라 벨기에!',
        dMarginLR: 0.035, dMarginTop: 0.05, dMarginBottom: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        TopBar().topBar(context, strTitle: '맥주도감', strSubTitle: '오늘은 어떤 맥주를 마셨나요?'),
        _fetchFavoriteData(context),
        _fetchDeutschlandData(context),
        _fetchNederlandData(context),
        _fetchCzechData(context),
        _fetchBelData(context),
      ],
    );
  }
}
