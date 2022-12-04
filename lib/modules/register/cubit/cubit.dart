import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/user_model.dart';
import 'package:ecommerce_app/modules/register/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);


  bool? isPassword = true;
  IconData? suffixIcon = Icons.lock_open;

  void changePassword()
  {
    isPassword = !isPassword!;
    suffixIcon = isPassword! ? Icons.lock_open : Icons.lock;
    emit(ChangePasswordState());
  }



void userRegister({
  @required String? email,
  @required String? password,
  @required String? name,
  @required String? phone,
})
{
  emit(RegisterLoadingState());
  FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email!, 
    password: password!)
    .then((value) 
  {
    userCreate(
      uId: value.user!.uid,
      email: email,
      name: name,
      phone: phone,
      );

  }).catchError((error)
  {
    emit(RegisterErrorState(error.toString()));
  });
}



void userCreate 
({
  @required String? uId,
  @required String? name,
  @required String? phone,
  @required String? email,
  @required String? image = 'https://img.freepik.com/free-photo/no-problem-concept-bearded-man-makes-okay-gesture-has-everything-control-all-fine-gesture-wears-spectacles-jumper-poses-against-pink-wall-says-i-got-this-guarantees-something_273609-42817.jpg?w=826&t=st=1668746339~exp=1668746939~hmac=0254eb6b267ca6106835e31ec803146a453dae42c817320d1d7bdbe12ae6e651',
})
{
  UserModel userModel = UserModel(
    uId: uId, 
    name: name, 
    phone: phone, 
    email: email, 
    image: image);

  FirebaseFirestore.instance
  .collection('users')
  .doc(uId)
  .set(userModel.toMap())
  .then((value) 
  {
    emit(CreateUserSuccessState(uId));
  }).catchError((error)
  {
    emit(CreateUserErrorState(error.toString()));
  });

  FirebaseFirestore.instance
  .collection('pets');

  FirebaseFirestore.instance
  .collection('users').doc(uId).collection('myPets');

}



}