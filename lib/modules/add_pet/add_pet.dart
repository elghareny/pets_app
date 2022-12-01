
import 'dart:ffi';

import 'package:ecommerce_app/layout/cubit/cubit.dart';
import 'package:ecommerce_app/layout/cubit/states.dart';
import 'package:ecommerce_app/shared/components/components.dart';
import 'package:ecommerce_app/shared/components/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPet extends StatelessWidget {
  AddPet({super.key});

  var petNameController = TextEditingController();
  var typeController = TextEditingController();
  var ageController = TextEditingController();
  var descriptionController = TextEditingController();
  


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) 
      {
        if(state is AddPetDataSuccessState)
        {
          showToast('Successful Add', ToastStates.SUCCESS);
        }
      },
      builder: (context, state) {

        var cubit = AppCubit.get(context);

        var choseGender = cubit.gender;

        String? gender;

        
        
        return Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            centerTitle: true,
            title: Text('Add Pet'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              TextButton(
              onPressed: ()
              {
                if(cubit.Image != null)
                {
                  cubit.uploadPetImage(
                    context: context,
                    age: ageController.text,
                    petName: petNameController.text,
                    type: typeController.text,
                    description: descriptionController.text,
                    gender: choseGender == 0 ? gender ='male' : gender = 'female',
                    petType: cubit.dropdownvalue,
                  );
                }
              }, 
              child: Text('Upload',style: TextStyle(fontSize: 23 , color: defaultColor),))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if(state is AddPetDataLoadingState)
                    LinearProgressIndicator(),
                  if(state is AddPetDataLoadingState)
                    SizedBox(height: 10,),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage('${cubit.userModel!.image}'),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        '${cubit.userModel!.name}',
                        style: TextStyle(
                            height: 1.3,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                textField(
                    controller: petNameController,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Name not be empty';
                      }
                      return null;
                    },
                    text: 'Name',
                    prefixIcon: Icons.abc),
                  SizedBox(
                  height: 20,
                ),
                textField(
                    controller: typeController,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Type not be empty';
                      }
                      return null;
                    },
                    text: 'Type',
                    prefixIcon: Icons.pets),
                SizedBox(
                  height: 20,
                ),
                textField(
                    controller: ageController,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Age not be empty';
                      }
                      return null;
                    },
                    text: 'Age',
                    prefixIcon: Icons.numbers),
                SizedBox(
                  height: 20,
                ),
                textField(
                    controller: descriptionController,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Description not be empty';
                      }
                      return null;
                    },
                    text: 'Description',
                    prefixIcon: Icons.description),
                    SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: defaultColor,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                  padding: EdgeInsets.all(1),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Center(
                      child: DropdownButton(
                        icon: const Icon(Icons.keyboard_arrow_down),   
                        underline: Container(
                          height: 0,
                        ),
                        isExpanded: true,
                        borderRadius: BorderRadius.circular(20),
                        dropdownColor: Colors.grey[300],
                        style: TextStyle(
                          color: defaultColor,
                          fontSize: 22,
                        ),
                        hint: Text('Select Pet Type'),
                        value: cubit.dropdownvalue,
                        items: cubit.typeList.map((String typeList) {
                      return DropdownMenuItem(
                        value: typeList,
                        child: Text(typeList),
                        );}).toList(), 
                        onChanged: (newValue)
                        {
                          cubit.selectType(newValue);
                        }
                        ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Radio(
                      activeColor: defaultColor,
                    value: 0, 
                    groupValue: choseGender, 
                    onChanged: (value)
                    {
                      cubit.changegender(value);
                    },
                      ),
                      Text('Male',style: TextStyle(
                        fontSize: 20,
                      ),),
                      Radio(
                        activeColor: defaultColor,
                    value: 1, 
                    groupValue: choseGender, 
                    onChanged: (value)
                    {
                  cubit.changegender(value);
                    }
                  ),
                  Text('Female',style: TextStyle(
                        fontSize: 20,
                      ),),
                  ],
                ),
                if(cubit.Image != null)
                  Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                  height: 300,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: FileImage(cubit.Image!),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(4)),
                                )
                                ,
                                IconButton(onPressed: ()
                              {
                                cubit.removePetImage();
                              }, 
                              icon: CircleAvatar(
                                radius: 25,
                                child: Icon(Icons.close_rounded,size: 18,))),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                  defaultButton(
                    text: 'Add Pet Image',
                    backcolor: defaultColor,
                    height: 55,
                    radius: 20,
                    function: ()
                    {
                      cubit.getPetImage();
                    }
                  ),
              ]),
            ),
          ),
        );
      },
    );
  }
}
