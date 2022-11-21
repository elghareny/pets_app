import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/MyBlocObserver%20.dart';
import 'package:ecommerce_app/firebase_options.dart';
import 'package:ecommerce_app/layout/cubit/cubit.dart';
import 'package:ecommerce_app/layout/cubit/states.dart';
import 'package:ecommerce_app/layout/hidden_drawer_menu.dart';
import 'package:ecommerce_app/layout/home.dart';
import 'package:ecommerce_app/modules/add_pet/add_pet.dart';
import 'package:ecommerce_app/modules/login/login.dart';
import 'package:ecommerce_app/shared/components/constant.dart';
import 'package:ecommerce_app/shared/network/local/cacheHelper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheHelper.init();

  Widget? widget;

  token = CacheHelper.getData(key: 'uId');

  if (token != null) {
    widget = HiddenDrawer();
  } else {
    widget = LoginScreen();
  }

  runApp(MyApp(
    statWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({this.statWidget, super.key});

  final Widget? statWidget;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getUser()..getPets(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) 
        {
        },
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primaryColor: defaultColor,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                elevation: 0,
                titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
                iconTheme: IconThemeData(color: Colors.black, size: 25),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarBrightness: Brightness.dark,
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.dark,
                ),
                backgroundColor: Colors.white,
                titleSpacing: 5,
              ),
              primarySwatch: primarySwatch,
            ),
            home: statWidget,
          );
        },
      ),
    );
  }
}
