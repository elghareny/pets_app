import 'package:ecommerce_app/models/pet_model.dart';
import 'package:ecommerce_app/shared/components/components.dart';
import 'package:ecommerce_app/shared/components/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PetDetails extends StatelessWidget {
  PetDetails({super.key, required this.model});
  PetsModel? model;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   leading: IconButton(
      //   onPressed: ()
      //   {
      //     Navigator.pop(context);
      //   },
      //   icon: Icon(Icons.arrow_back_ios_new)),
      // ),
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Column(
            children: [
              Expanded(
                child: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    Container(
                        width: double.infinity,
                        child: Image(
                            fit: BoxFit.cover,
                            image: NetworkImage('${model!.petImage}'))),
                            Container(
                              width: double.infinity,
                              height: 100,
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back)),
                                  IconButton(onPressed: (){}, icon: Icon(Icons.logout_outlined)),
                                ],
                              ),
                            )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundImage:  NetworkImage('${model!.petImage}') 
                                      ),
                                  SizedBox(width: 10,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                                'Name',
                                                style: TextStyle(
                                                    color: Colors.grey[700],
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 22),
                                              ),
                                              SizedBox(height: 5,),
                                      Text(
                                                'Owner',
                                                style: TextStyle(
                                                    color: Colors.grey[500],
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 18),
                                              ),
                                    ],
                                  ),
                                    ],
                                  ),
                                  Text(
                                                'May,25,2022',
                                                style: TextStyle(
                                                    color: Colors.grey[500],
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 18),
                                              ),
                                ],
                              ),
                              SizedBox(height: 20,),
                              Text(
                                          'description',
                                          style: TextStyle(
                                              color: Colors.grey[500],
                                              fontWeight: FontWeight.w400,
                                              fontSize: 20),
                                        ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Container(
                              height: 150,
                              decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.grey[100],
                                        ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: 80,
                                    height: 60,
                                    child: MaterialButton(
                                      child: Icon(
                                        Icons.favorite_border,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {},
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: defaultColor,
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 5,
                                              color: defaultColor,
                                              offset: Offset(0, 4))
                                        ]),
                                  ),
                                  Container(
                                    width: 300,
                                    height: 60,
                                    child: MaterialButton(
                                      child: Text(
                                        'Adoption',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 25),
                                      ),
                                      onPressed: () {},
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: defaultColor,
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 5,
                                              color: defaultColor,
                                              offset: Offset(0, 4))
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        color: Colors.grey,
                        blurStyle: BlurStyle.outer,
                        offset: Offset(0, 2))
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${model!.petName}',
                          style:
                              TextStyle(fontSize: 40, color: Colors.grey[700]),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${model!.type}',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        Icon(
                          model!.gender == 'male' ? Icons.male : Icons.female,
                          color: Colors.grey[600],
                          size: 40,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${model!.age}',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
