
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
  var genderController = TextEditingController();
  


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) 
      {
        if(state is AddPetDataSuccessState)
        {
          showToast('Successful Add', ToastStates.SUCCESS);
          Navigator.pop(context);
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
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
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
                  ]),
                ),
                defaultButton(
                  text: 'Add Pet',
                  backcolor: defaultColor,
                  height: 55,
                  radius: 20,
                  function: ()
                  {
                    cubit.addPet(
                      age: ageController.text,
                      petName: petNameController.text,
                      type: typeController.text,
                      gender: choseGender == 0 ? gender ='male' : gender = 'female'
                    );
                  }
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
