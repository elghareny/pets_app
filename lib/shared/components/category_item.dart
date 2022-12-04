

import 'package:ecommerce_app/models/pet_model.dart';
import 'package:ecommerce_app/shared/components/constant.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
   CategoryItem({
    @required this.context , 
    @required this.model , 
    @required this.index , 
    @required this.indexPet ,
    @required this.onTap ,
    });

CatogeryModel? model;
BuildContext? context ;
int? index ;
int? indexPet ;
Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            width: index == indexPet ? 75 : 70,
                            height: index == indexPet ? 75 : 70,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Image(
                                fit: BoxFit.cover,
                                  width: index == indexPet ? 75 : 70,
                                  height: index == indexPet ? 75 : 70,
                                  image: NetworkImage(
                                    '${model!.image}',
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${model!.name}',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: index == indexPet ? 20 : 16,
                                color: index == indexPet ?defaultColor : Colors.grey[700]),
                          )
                        ],
                      ),
      );
  }
}