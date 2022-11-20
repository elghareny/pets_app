import 'package:ecommerce_app/layout/hidden_drawer_menu.dart';
import 'package:ecommerce_app/modules/register/cubit/cubit.dart';
import 'package:ecommerce_app/modules/register/cubit/states.dart';
import 'package:ecommerce_app/shared/components/components.dart';
import 'package:ecommerce_app/shared/components/constant.dart';
import 'package:ecommerce_app/shared/network/local/cacheHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
   RegisterScreen({super.key});

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context, state) 
        {
          if(state is CreateUserSuccessState)
          {
            showToast('Register Success', ToastStates.SUCCESS);
            // CacheHelper.saveData(key: 'uId', value: state.uId);
            navigatTo(context, HiddenDrawer());
            
          }else if(state is RegisterErrorState)
          showToast(state.toString(), ToastStates.ERROR);
        },
        builder: (context, state) { 
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            
          body: Container(
            height: double.infinity,
            color: Colors.grey[200],
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: AlignmentDirectional.topCenter,
                        
                        decoration: BoxDecoration(
                          color: defaultColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(80), 
                            bottomRight: Radius.circular(80), 
                          )
                        ),
                      ),
                    ),
                    Expanded(
                  flex: 2,
                  child: Container(
                    alignment: AlignmentDirectional.topCenter,
                    
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                    ),
                  ),
                ),
                  ],
                ),
                
                Center(
                  child: Container(
                    width: 400,
                    alignment: AlignmentDirectional.center,
                    height: 640,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            SizedBox(height: 25,),
                            Text('Make a new account',
                            style: TextStyle(
                              color: defaultColor,
                              fontSize: 25,
                              fontWeight: FontWeight.w400,
                            ),
                            ),
                            SizedBox(height: 25,),
                            textField(
                              controller: nameController, 
                              type: TextInputType.name,
                            validate: (value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'Name not be empty';
                              }return null;
                            }, 
                            text: 'Name', 
                            prefixIcon: Icons.person
                            ),
                            SizedBox(height: 20,),
                            textField(
                              controller: emailController, 
                              type: TextInputType.emailAddress,
                            validate: (value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'Email not be empty';
                              }return null;
                            }, 
                            text: 'Email', 
                            prefixIcon: Icons.email
                            ),
                            SizedBox(height: 20,),
                            textField(
                              controller: phoneController, 
                              type: TextInputType.phone,
                            validate: (value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'Phone not be empty';
                              }return null;
                            }, 
                            text: 'Phone', 
                            prefixIcon: Icons.phone
                            ),
                            SizedBox(height: 20,),
                            textField(
                              controller: passwordController, 
                              type: TextInputType.visiblePassword,
                            validate: (value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'Password not be empty';
                              }return null;
                            }, 
                            text: 'Password', 
                            prefixIcon: Icons.password,
                            isPassword: true,
                            ),
                            SizedBox(height: 20,),
                            textField(
                              controller: confirmPasswordController, 
                              type: TextInputType.visiblePassword,
                            validate: (value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'Confirm password not equal password';
                              }return null;
                            }, 
                            text: 'Confirm Password', 
                            prefixIcon: Icons.password,
                            isPassword: true,
                            ),
                            SizedBox(height: 20,),
                            defaultButton(
                              text: 'Register',
                              height: 50,
                              radius: 20,
                              backcolor: defaultColor,
                              function: ()
                              {
                                if(formKey.currentState!.validate() && passwordController.text == confirmPasswordController.text)
                                {
                                  cubit.userRegister(
                                    email: emailController.text, 
                                    password: passwordController.text, 
                                    name: nameController.text, phone: 
                                    phoneController.text);
                                }
                              }
                              
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );}
      ),
    );
  }
}