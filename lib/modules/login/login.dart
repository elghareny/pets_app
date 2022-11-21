import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce_app/layout/hidden_drawer_menu.dart';
import 'package:ecommerce_app/modules/login/cubit/cubit.dart';
import 'package:ecommerce_app/modules/login/cubit/states.dart';
import 'package:ecommerce_app/modules/register/register.dart';
import 'package:ecommerce_app/shared/components/components.dart';
import 'package:ecommerce_app/shared/components/constant.dart';
import 'package:ecommerce_app/shared/network/local/cacheHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context, state) 
        {
          if(state is LoginSuccessState)
          {
            showToast('Login Success', ToastStates.SUCCESS);
            CacheHelper.saveData(key: 'uId', value: state.uId);
            navigatTo(context, HiddenDrawer());
          }  else if(state is LoginErrorState)
          showToast(state.error, ToastStates.ERROR);
        },
        builder: (context, state) { 
          var cubit = LoginCubit.get(context);
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
                    height: 420,
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
                            Text('Welcome To Ecommerce App',
                            style: TextStyle(
                              color: defaultColor,
                              fontSize: 25,
                              fontWeight: FontWeight.w400,
                            ),
                            ),
                            SizedBox(height: 25,),
                            textField(
                              controller: emailController, 
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
                              controller: passwordController, 
                            validate: (value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'Password not be empty';
                              }return null;
                            }, 
                            text: 'Password', 
                            prefixIcon: Icons.password,
                            isPassword: cubit.isPassword!,
                            suffixIcon: cubit.suffixIcon,
                            suffixPressed: ()
                            {
                              cubit.changePassword();
                            }
                            ),
                            SizedBox(height: 20,),
                            ConditionalBuilder(
                              condition: state is !LoginLoadingState ,
                              fallback: (context) => Center(child: CircularProgressIndicator(),),
                              builder: (context) {
                                return defaultButton(
                                text: 'Sign in',
                                height: 50,
                                radius: 20,
                                backcolor: defaultColor,
                                function: ()
                                {
                                  if(formKey.currentState!.validate())
                                  {
                                    cubit.userLogin(email: emailController.text, password: passwordController.text);
                                  }
                                }
                                
                              );
                              },
                            ),
                            SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Don\'t have an account ?',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                TextButton(
                                    onPressed: () 
                                    {
                                      navigatTo(context, RegisterScreen());
                                    },
                                    child: Text(
                                      'Register',
                                      style: TextStyle(fontSize: 22),
                                    ))
                              ],
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