import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce_app/layout/cubit/cubit.dart';
import 'package:ecommerce_app/layout/cubit/states.dart';
import 'package:ecommerce_app/shared/components/pet_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyPets extends StatelessWidget {
   MyPets({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) 
      {
      },
      builder: (context, state) {
        return  Scaffold(
          backgroundColor: Colors.grey[100],
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: 800,
              child: ConditionalBuilder(
                  condition: AppCubit.get(context).myPets.length > 0,
                  fallback: (context) => Center(child: CircularProgressIndicator()),
                  builder: (context) {
                    return ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return PetItem(
                              context: context,
                              model: AppCubit.get(context).myPets[index],
                              onTap: () {
                                AppCubit.get(context).itemDetails(
                                    context: context,
                                    model: AppCubit.get(context).myPets[index]);
                              },
                            );},
                        separatorBuilder: (context, index) => SizedBox(
                              height: 10,
                            ),
                        itemCount: AppCubit.get(context).myPets.length
                        );
                  },
                ),
            ),
            
          ),
        );
        
      },
    );
  }
}
