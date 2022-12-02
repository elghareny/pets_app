import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce_app/layout/cubit/cubit.dart';
import 'package:ecommerce_app/layout/cubit/states.dart';
import 'package:ecommerce_app/models/pet_model.dart';
import 'package:ecommerce_app/models/user_model.dart';
import 'package:ecommerce_app/modules/add_pet/add_pet.dart';
import 'package:ecommerce_app/modules/pet_details/pet_details.dart';
import 'package:ecommerce_app/shared/components/components.dart';
import 'package:ecommerce_app/shared/components/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {

         int indexPet = AppCubit.get(context).indexPet;
         
        return Scaffold(
          backgroundColor: Colors.grey[100],
          // appBar: AppBar(
          //   leading: IconButton(
          //     icon: Icon(Icons.menu,color: Colors.grey[700]),
          //     onPressed: ()
          //     {

          //     },
          //   ),
          //   centerTitle: true,
          //   title: Text(
          //     'Ecommerce',
          //     style: TextStyle(fontWeight: FontWeight.w500,fontSize: 25,color: Colors.grey[700]),
          //   ),
          //   actions: [
          //     Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 10),
          //       child: CircleAvatar(
          //         backgroundColor: Colors.grey[500],
          //         radius: 23,
          //         child: CircleAvatar(
          //           radius: 21,
          //           backgroundImage: NetworkImage(
          //             'https://img.freepik.com/free-photo/no-problem-concept-bearded-man-makes-okay-gesture-has-everything-control-all-fine-gesture-wears-spectacles-jumper-poses-against-pink-wall-says-i-got-this-guarantees-something_273609-42817.jpg?w=826&t=st=1668746339~exp=1668746939~hmac=0254eb6b267ca6106835e31ec803146a453dae42c817320d1d7bdbe12ae6e651'
          //           ),
          //         ),
          //       ),
          //     ),

          //   ],
          // ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                        hintText: 'Search'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              Container(
                height: 110,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return categoryItem(AppCubit.get(context).catogeryList[index],context , index );   
                  }, 
                  separatorBuilder: (context, index) => SizedBox(width: 25,), 
                  itemCount: AppCubit.get(context).catogeryList.length),
              ),
                SizedBox(
                  height: 20,
                ),
                ConditionalBuilder(
                  condition: 
                  indexPet == 0 ? AppCubit.get(context).dogs.length > 0 : indexPet == 1 ? AppCubit.get(context).cats.length > 0 :
                   indexPet == 2 ? AppCubit.get(context).rabbits.length > 0 : indexPet == 3 ? AppCubit.get(context).fish.length > 0 :
                   indexPet == 4 ? AppCubit.get(context).birds.length > 0 : AppCubit.get(context).pets.length > 0,
                  // AppCubit.get(context).pets.length > 0,
                  fallback: (context) => Center(child: CircularProgressIndicator()),
                  builder: (context) {
                    return Expanded(
                      child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        // return petItem(AppCubit.get(context).pets[index],context,);
                        if(indexPet == 0)
                        {
                          return petItem(AppCubit.get(context).dogs[index],context,);
                          
                        }else if (indexPet == 1)
                        {
                          return petItem(AppCubit.get(context).cats[index],context,);
                        }
                        else if (indexPet == 2)
                        {
                          return petItem(AppCubit.get(context).rabbits[index],context,);
                        }
                        
                        else if (indexPet == 3)
                        {
                          return petItem(AppCubit.get(context).fish[index],context,);
                        }
                        else
                        {
                          return petItem(AppCubit.get(context).birds[index],context,);
                        }
                      }, 
                      separatorBuilder: (context, index) => SizedBox(height: 10,), 
                      itemCount: 
                                       indexPet == 0 ? AppCubit.get(context).dogs.length : indexPet == 1 ? AppCubit.get(context).cats.length :
                                       indexPet == 2 ? AppCubit.get(context).rabbits.length : indexPet == 3 ? AppCubit.get(context).fish.length :
                                       indexPet == 4 ? AppCubit.get(context).birds.length : 0
                      // AppCubit.get(context).pets.length
                      ),
                    );
                  },
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: ()
            {
              navigatTo(context, AddPet());
            },
            backgroundColor: defaultColor,
            child: Icon(Icons.post_add_outlined),
          ),
        );
      },
    );
  }

  Widget petItem(PetsModel model, context) => InkWell(
    onTap: ()
    {      
    
      AppCubit.get(context).itemDetails(context: context , model: model);
      
    },
    child: Row(
          children: [
            Expanded(
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                margin: EdgeInsets.symmetric(horizontal: 0),
                elevation: 10,
                child: Container(
                  height: 150,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                       color: defaultColor),
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      '${model.petImage}',
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 110,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        topRight: Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            color: Colors.grey
                          )
                        ],
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                '${model.petName}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 22,
                                    color: Colors.grey[700]),
                              ),
                            ),
                            Icon(
                              model.gender == 'male' ? Icons.male : Icons.female,
                              color: Colors.grey[600],
                              size: 25,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${model.type}',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.grey[700]),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${model.age}',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.grey[500]),
                        ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // Row(
                        //   children: [
                        //     Icon(
                        //       Icons.location_on_rounded,
                        //       color: defaultColor,
                        //     ),
                        //     SizedBox(
                        //       width: 8,
                        //     ),
                        //     Text(
                        //       'distance : ${model.distance}',
                        //       style: TextStyle(
                        //           fontWeight: FontWeight.w500,
                        //           fontSize: 18,
                        //           color: Colors.grey[500]),
                        //     ),
                        //   ],
                        // ),
                      ]),
                ),
              ),
            ),
          ],
        ),
  );





      Widget categoryItem(CatogeryModel model,context ,  index ,) => InkWell(
        onTap: ()
        {
          AppCubit.get(context).changeType(index);
        },
        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            width: index == AppCubit.get(context).indexPet ? 75 : 70,
                            height: index == AppCubit.get(context).indexPet ? 75 : 70,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Image(
                                fit: BoxFit.cover,
                                  width: index == AppCubit.get(context).indexPet ? 75 : 70,
                                  height: index == AppCubit.get(context).indexPet ? 75 : 70,
                                  image: NetworkImage(
                                    '${model.image}',
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${model.name}',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: index == AppCubit.get(context).indexPet ? 20 : 16,
                                color: index == AppCubit.get(context).indexPet ?defaultColor : Colors.grey[700]),
                          )
                        ],
                      ),
      );
}
