

import 'package:ecommerce_app/models/pet_model.dart';
import 'package:ecommerce_app/shared/components/constant.dart';
import 'package:flutter/material.dart';

class PetItem extends StatelessWidget {
   PetItem({
    @required this.model,
    @required this.context,
    @required this.onTap,
    });

    PetsModel? model;
    BuildContext? context;
    Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
    onTap: onTap,
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
                      '${model!.petImage}',
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
                                '${model!.petName}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 22,
                                    color: Colors.grey[700]),
                              ),
                            ),
                            Icon(
                              model!.gender == 'male' ? Icons.male : Icons.female,
                              color: Colors.grey[600],
                              size: 25,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${model!.type}',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.grey[700]),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${model!.age}',
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
  }
}