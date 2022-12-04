import 'package:ecommerce_app/layout/cubit/cubit.dart';
import 'package:ecommerce_app/layout/cubit/states.dart';
import 'package:ecommerce_app/layout/home.dart';
import 'package:ecommerce_app/modules/login/login.dart';
import 'package:ecommerce_app/modules/my_pets/my_pets.dart';
import 'package:ecommerce_app/modules/profile/profile.dart';
import 'package:ecommerce_app/shared/components/components.dart';
import 'package:ecommerce_app/shared/components/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

class HiddenDrawer extends StatelessWidget {
  HiddenDrawer({super.key});

  List<ScreenHiddenDrawer> screens = [
    ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Home',
          baseStyle: TextStyle(
              color: Colors.grey[400],
              fontSize: 25,
              fontWeight: FontWeight.w400),
          selectedStyle: const TextStyle(
              color: Colors.white, fontSize: 35, fontWeight: FontWeight.w400),
        ),
        HomeScreen()),
    ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'My Pets',
          baseStyle: TextStyle(
              color: Colors.grey[400],
              fontSize: 25,
              fontWeight: FontWeight.w400),
          selectedStyle: const TextStyle(
              color: Colors.white, fontSize: 35, fontWeight: FontWeight.w400),
        ),
        MyPets()),
    ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Profile',
          baseStyle: TextStyle(
              color: Colors.grey[400],
              fontSize: 25,
              fontWeight: FontWeight.w400),
          selectedStyle: const TextStyle(
              color: Colors.white, fontSize: 35, fontWeight: FontWeight.w400),
        ),
        ProfileScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) 
      {
      },
      builder: (context, state) {
        return HiddenDrawerMenu(
          enableCornerAnimation: true,
          enableScaleAnimation: true,
          enableShadowItensMenu: true,
          elevationAppBar: 0,
          isTitleCentered: true,
          actionsAppBar: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: IconButton(onPressed: 
                ()
                {
                  AppCubit.get(context).logout();
                  navigatTo(context, LoginScreen());
                }, 
                icon: const Icon(Icons.logout,size: 25,)),
              // child: CircleAvatar(
              //   backgroundColor: Colors.grey[500],
              //   radius: 23,
              //   child: CircleAvatar(
              //     radius: 21,
              //     backgroundImage: NetworkImage(
              //       // '${AppCubit.get(context).userModel!.image}'),
              //         'https://img.freepik.com/free-photo/no-problem-concept-bearded-man-makes-okay-gesture-has-everything-control-all-fine-gesture-wears-spectacles-jumper-poses-against-pink-wall-says-i-got-this-guarantees-something_273609-42817.jpg?w=826&t=st=1668746339~exp=1668746939~hmac=0254eb6b267ca6106835e31ec803146a453dae42c817320d1d7bdbe12ae6e651'),
              //   ),
              // ),
            ),
          ],
          backgroundColorMenu: defaultColor,
          screens: screens,
          initPositionSelected: 0,
        );
      },
    );
  }
}
