import 'package:ecommerce_app/layout/cubit/cubit.dart';
import 'package:ecommerce_app/layout/cubit/states.dart';
import 'package:ecommerce_app/shared/components/components.dart';
import 'package:ecommerce_app/shared/components/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) 
      {
      },
      builder: (context, state) {
        var nameController = TextEditingController();
        var phoneController = TextEditingController();

        var cubit = AppCubit.get(context);

        var userModel = cubit.userModel!;

        nameController.text = userModel.name!;
        phoneController.text = userModel.phone!;

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if(state is UpdateProfileUploadState)
                  LinearProgressIndicator(),
                  if(state is UpdateProfileUploadState)
                  SizedBox(height: 20,),
                  Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      cubit.imageProfile != null ?
                      CircleAvatar(
                        radius: 104,
                        backgroundColor: defaultColor,
                        child: CircleAvatar(
                          radius: 100,
                          backgroundImage:  FileImage(cubit.imageProfile!) 
                        ),
                      )
                      : 
                      CircleAvatar(
                        radius: 104,
                        backgroundColor: defaultColor,
                        child: CircleAvatar(
                          radius: 100,
                          backgroundImage: NetworkImage(userModel.image!),
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: defaultColor,
                        radius: 22,
                        child: IconButton(
                          icon: Icon(Icons.camera_alt,color: Colors.white,size: 25,),
                          onPressed: ()
                          {
                            cubit.pickprofile();
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  textField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'name must not be empty';
                        }
                        return null;
                      },
                      text: 'Name',
                      prefixIcon: Icons.person),
                  SizedBox(
                    height: 20,
                  ),
                  textField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'phone must not be empty';
                        }
                        return null;
                      },
                      text: 'Phone',
                      prefixIcon: Icons.phone),
            
                      SizedBox(height: 30,),
                      if(cubit.imageProfile != null)
                      defaultButton(
                      text: 'Update profile And Image', 
                      backcolor: defaultColor,
                      radius: 20,
                      function: ()
                      {
                        cubit.uploadProfileImage(name: nameController.text, phone: phoneController.text);
                      }),
                      if(cubit.imageProfile == null)
                      defaultButton(
                      text: 'Update profile', 
                      backcolor: defaultColor,
                      radius: 20,
                      function: ()
                      {
                        cubit.updateProfile(name: nameController.text, phone: phoneController.text);
                      }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
