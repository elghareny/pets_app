import 'package:flutter/cupertino.dart';

class PetsModel{
  String? ownerId;
  String? petName;
  String? type;
  String? age;
  // String? distance;
  String? petImage;
  String? gender;
  String? description;
  String? date;
  String? petType;

  PetsModel
  ({
    required this.ownerId,
    required this.petName,
    required this.type,
    required this.age,
    // this.distance,
    required this.petImage,
    required this.gender,
    required this.description,
    required this.date,
    required this.petType,
  });

  PetsModel.fromjson(Map<String, dynamic>json)
  {
    ownerId = json['ownerId'];
    petName = json['petName'];
    type = json['type'];
    age = json['age'];
    petImage = json['petImage'];
    gender = json['gender'];
    description = json['description'];
    date = json['date'];
    petType = json['petType'];
  }


  Map<String, dynamic>toMap()
  {
    return
    {
      'ownerId' : ownerId,
      'petName' : petName,
      'type' : type,
      'age' : age,
      'petImage' : petImage,
      'gender' : gender,
      'description' : description,
      'date' : date,
      'petType' : petType,
    };
  }

}




class CatogeryModel{
  String? name;
  String? image;


  CatogeryModel
  ({
    required this.name,
    required this.image,
  });

}