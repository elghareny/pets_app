import 'package:ecommerce_app/modules/login/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);


  bool? isPassword = true;
  IconData? suffixIcon = Icons.lock_open;

  void changePassword()
  {
    isPassword = !isPassword!;
    suffixIcon = isPassword! ? Icons.lock_open : Icons.lock;
    emit(ChangePasswordState());
  }



void userLogin({
  @required email,
  @required password,
})
{
  emit(LoginLoadingState());
  FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email, 
    password: password)
    .then((value) 
  {
    emit(LoginSuccessState(value.user!.uid));
  }).catchError((error)
  {
    emit(LoginErrorState(error.toString()));
  });
}




}