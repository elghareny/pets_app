import 'package:flutter/cupertino.dart';

class PetsModel{
  String? name;
  String? type;
  String? age;
  String? distance;
  String? image;
  IconData? gender;

  PetsModel
  ({
    required this.name,
    required this.type,
    required this.age,
    required this.distance,
    required this.image,
    required this.gender,
  }){}

}
class CatogeryModel{
  String? name;
  String? image;


  CatogeryModel
  ({
    required this.name,
    required this.image,
  }){}

}