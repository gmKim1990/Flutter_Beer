import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beerrecord/model/beer_model.dart';
import 'package:flutter_beerrecord/widget/ale_beer.dart';
import 'package:flutter_beerrecord/widget/top_bar.dart';
import 'package:flutter_beerrecord/widget/week_beer.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //파이어베이스 연동
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot> streamData;

  @override
  void initState() {
    super.initState();
    print('master 추가');
    //beer 테이블 title 조건 'Heineken', 'Hoegaarden', '1664 Blanc'
    streamData = firebaseFirestore.collection('beer').where('title', whereIn: ['Heineken', 'Hoegaarden', '1664 Blanc']).snapshots();
  }

  Widget _fetchData(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: streamData,
      builder: (context, snapshot) {
        if(!snapshot.hasData) return LinearProgressIndicator();
        return _buildBody(context, snapshot.data.docs);
      },
    );
  }

  Widget _buildBody(BuildContext context, List<DocumentSnapshot> snapshot) {
    List<Beer> beers = snapshot.map((d) => Beer.fromSnapShot(d)).toList();
    return WeekBeer(beers: beers);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        TopBar().topBar(context),
        _fetchData(context),
        AleBeer(strImage: 'assets/images/ale.png', strName: 'Ale', strSubName: '에일(Ale)에 대해 궁금하신가요?'),
        AleBeer(strImage: 'assets/images/lager.png', strName: 'Lager', strSubName: '라거(Lager)가 무엇인지 알려드릴께요.')
      ],
    );
  }
}
