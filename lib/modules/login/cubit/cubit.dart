import 'package:ecommerce_app/modules/login/cubit/states.dart';
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
}