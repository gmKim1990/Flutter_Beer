import 'package:cloud_firestore/cloud_firestore.dart';

//맥주 모델
class Beer {
  final String title; //이름
  final String keyword; //키워드
  final String photo; //맥주사진
  final String country; //나라
  final String info;  //맥주정보
  final bool like;  //즐겨찾기
  final String alcohol; //알콜도수
  final num rating; //별점
  final String write; //내 기록
  final String logo;  //맥주로고
  final String countryImage;  //나라 국기
  final DocumentReference reference;

  Beer.fromMap(Map<String, dynamic> map, {this.reference})
  : title = map['title'],
    keyword = map['keyword'],
    photo = map['photo'],
    country = map['country'],
    info = map['info'],
    like = map['like'],
    alcohol = map['alcohol'],
    rating = map['rating'],
    write = map['write'],
    logo = map['logo'],
    countryImage = map['countryImage'];

  Beer.fromSnapShot(DocumentSnapshot snapshot)
  : this.fromMap(snapshot.data(), reference: snapshot.reference);

}