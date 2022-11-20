
import 'package:ecommerce_app/layout/cubit/states.dart';
import 'package:ecommerce_app/layout/home.dart';
import 'package:ecommerce_app/models/model.dart';
import 'package:ecommerce_app/modules/profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:hidden_drawer_menu/model/screen_hidden_drawer.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  List<PetsModel>petsList = 
  [
    PetsModel(
      name: 'Sola', 
      type: 'cat', 
      age: '8 months', 
      distance: '3.6 Km', 
      gender: Icons.female,
      image: 'https://img.freepik.com/free-photo/red-white-cat-i-white-studio_155003-13189.jpg?w=360&t=st=1668893476~exp=1668894076~hmac=0614695804a4245892816c0192e39a12abe9f97388f09f7b93fdcf7d72f6587f'),
    PetsModel(
      name: 'Lucky', 
      type: 'dog', 
      age: '10 months', 
      distance: '2.2 Km', 
      gender: Icons.female,
      image: 'https://img.freepik.com/premium-photo/pomeranian-dog-cute-pet-happy-smile-playing-nature_106368-70.jpg?w=826'),
    PetsModel(
      name: 'Max', 
      type: 'dog', 
      age: '8 years', 
      distance: '1.5 Km', 
      gender: Icons.male,
      image: 'https://img.freepik.com/free-photo/adorable-brown-white-basenji-dog-smiling-giving-high-five-isolated-white_346278-1657.jpg?w=826&t=st=1668893727~exp=1668894327~hmac=4805a7dc70f5f897e9d2613750e60bc6789adc9736e6c747140516fb59fe72b8'),
    PetsModel(
      name: 'Jinx', 
      type: 'dog', 
      age: '1 years', 
      distance: '0.5 Km', 
      gender: Icons.male,
      image: 'https://img.freepik.com/premium-photo/pomeranian-spitz_1472-11020.jpg?w=826'),
    PetsModel(
      name: 'Chloe', 
      type: 'cat', 
      age: '2 years', 
      distance: '6.6 Km',
      gender: Icons.male, 
      image: 'https://img.freepik.com/free-photo/grey-cat-lying-looking-up_176474-6827.jpg?w=826&t=st=1668893758~exp=1668894358~hmac=1631b3d970740191726902bca0329f5400dcebc511136880b279186168166b9c'),
    PetsModel(
      name: 'Cody', 
      type: 'dog', 
      age: '3 years', 
      distance: '4.3 Km', 
      gender: Icons.male,
      image: 'https://img.freepik.com/free-photo/cute-puppy-maltipoo-dog-posing-isolated-white-background_155003-46004.jpg?w=826&t=st=1668893770~exp=1668894370~hmac=2d24574c9ae259d926a8b2d26b3fb4b2791e72111eaffcf2e3354c83fbb062c4'),
  ];









  List<CatogeryModel> catogeryList = 
  [
    CatogeryModel(
      name: 'Dogs', 
      image: 'https://cdn-icons-png.flaticon.com/512/1247/1247352.png?w=740&t=st=1668897685~exp=1668898285~hmac=38b938a63e762a9ba861847bdfeba48326f2589087a7f13379ec1291f7c94d5d'),
    CatogeryModel(
      name: 'Cats', 
      image: 'https://cdn-icons-png.flaticon.com/512/1152/1152454.png?w=740&t=st=1668897686~exp=1668898286~hmac=8d48301d1906be1faacce5c19dd85ce71c1ad55b93dcbd4e7a23851816bf183d'),
    CatogeryModel(
      name: 'Rabbits', 
      image: 'https://cdn-icons-png.flaticon.com/512/1255/1255053.png?w=740&t=st=1668897699~exp=1668898299~hmac=7422efe74080d51ec84c879eb95d2781cdd605e29a2cd53f1a31eb0fdf7fabf6'),
    CatogeryModel(
      name: 'Fish', 
      image: 'https://cdn-icons-png.flaticon.com/512/1226/1226789.png?w=740&t=st=1668897743~exp=1668898343~hmac=542c137e3265fd8ae50878f4187671f859bd34fe8983ba0793ca4ba722a7e3f8'),
    CatogeryModel(
      name: 'Birds', 
      image: 'https://cdn-icons-png.flaticon.com/512/1230/1230839.png?w=740&t=st=1668897780~exp=1668898380~hmac=48b6a67c9d26732360818c94b9ec001ddf99451d5cbc722a4935800642cf3ba8'),
  ];
}