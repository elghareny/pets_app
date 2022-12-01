
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/layout/cubit/states.dart';
import 'package:ecommerce_app/layout/home.dart';
import 'package:ecommerce_app/models/pet_model.dart';
import 'package:ecommerce_app/models/user_model.dart';
import 'package:ecommerce_app/modules/profile/profile.dart';
import 'package:ecommerce_app/modules/register/cubit/states.dart';
import 'package:ecommerce_app/shared/components/constant.dart';
import 'package:ecommerce_app/shared/network/local/cacheHelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:hidden_drawer_menu/model/screen_hidden_drawer.dart';
import 'package:image_picker/image_picker.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());
  static AppCubit get(context) => BlocProvider.of(context);


UserModel? userModel;

UserModel? ownerModel;

PetsModel? petsModel;


var gender = 0;

void changegender(value)
{
  gender = value;
  emit(ChoseGendarState());
}

var typeList = ['Cat','Dog','Bird','Fish'];

var dropdownvalue ;

void selectType(newValue)
{
  dropdownvalue = newValue!;
  emit(ChoseTypeState());
}


void logout ()
{
  FirebaseAuth.instance.signOut()
  .then((value) 
  {
    CacheHelper.removeData(key: 'uId');
    emit(LogoutSuccessState());
  })
  .catchError((error)
  {

  });
}


///////////////////////////////////////////////////////////////////////////   user   //////////////////////////


  void getUser()
  {
    emit(GetUserLoadingState());
    FirebaseFirestore.instance
    .collection('users')
    .doc(token)
    .get()
    .then((value) 
    {
      userModel = UserModel.fromjson(value.data()!);
      emit(GetUserSuccessState());
    })
    .catchError((error)
    {
      emit(GetUserErrorState(error.toString()));
    });
  }



/////////////////////////////////////////////////////////////////////////   add pet    /////////////////////////////

File? Image;
var picker = ImagePicker();

Future <void> getPetImage ()async
{
  final PickedFile = await picker.pickImage(source: ImageSource.gallery);

  if(PickedFile != null)
  {
    Image = File(PickedFile.path);
    emit(PetImagePickedSuccessState());
  }else 
  {
    print('no image selected');
    emit(PetImagePickedErrorState());
  }
}



void removePetImage()
        {
          Image = null;
          emit(RemovePetImageSuccessState());
        }



void uploadPetImage({
  @required String? petName,
  @required String? type,
  @required String? age,
  @required String? gender,
  @required String? description,
  @required String? petType,
  context
})
{
  emit(AddPetDataLoadingState());
  firebase_storage.FirebaseStorage.instance
  .ref()
  .child('pets/${Uri.file(Image!.path).pathSegments.last}')
  .putFile(Image!).then((value) 
  {
    value.ref.getDownloadURL().then((value)
    {
      addPet(
      age: age,
      gender: gender,
      petName: petName,
      type: type,
      ownerId: userModel!.uId,
      petImage: value,
      description: description,
      petType: petType
    );
    removePetImage();
    pets = [];
    getPets();
    dropdownvalue = null;
    Navigator.pop(context);
    }).catchError((error)
    {
      emit(AddPetDataErrorState(error.toString()));
    });
    
  })
  .catchError((error)
  {
    emit(AddPetDataErrorState(error.toString()));
  });
}







  void addPet({
  String? ownerId,
  @required String? petName,
  @required String? type,
  @required String? age,
  @required String? petImage,
  @required String? gender,
  @required String? description,
  @required String? petType,
  })
  {
    emit(AddPetDataLoadingState());

    PetsModel? petsModel = PetsModel(
      petName: petName, 
      type: type, 
      age: age, 
      petImage: petImage, 
      gender: gender,
      ownerId: userModel!.uId,
      description: description,
      date: DateTime.now().toString(),
      petType: petType
      );

    FirebaseFirestore.instance
    .collection('pets')
    .add(petsModel.toMap())
    .then((value) 
    {
      emit(AddPetDataSuccessState());
    })
    .catchError((error)
    {
      emit(AddPetDataErrorState(error.toString()));
    });
  }


List<PetsModel> pets = [];


List<PetsModel> dogs = [];
List<PetsModel> cats = [];
List<PetsModel> rabbits= [];
List<PetsModel> fish= [];
List<PetsModel> birds= [];

  int indexPet = 0;


    void getPets()
  {
    emit(GetPetDataLoadingState());
    FirebaseFirestore.instance
    .collection('pets')
    .get()
    .then((value) 
    {
      value.docs.forEach((element) { 
        pets.add(PetsModel.fromjson(element.data()));
        if(PetsModel.fromjson(element.data()).petType == 'Dog')
      {
        dogs.add(PetsModel.fromjson(element.data()));
      }else if(PetsModel.fromjson(element.data()).petType == 'Cat')
        {
        cats.add(PetsModel.fromjson(element.data()));
        }
      else if(PetsModel.fromjson(element.data()).petType == 'Rabbit')
        {
        rabbits.add(PetsModel.fromjson(element.data()));
        }
      else if(PetsModel.fromjson(element.data()).petType == 'Fish')
        {
        fish.add(PetsModel.fromjson(element.data()));
        }
      else if(PetsModel.fromjson(element.data()).petType == 'Bird')
        {
        birds.add(PetsModel.fromjson(element.data()));
        }
      });
      print("Cats : ${cats.length}");
      emit(GetPetDataSuccessState());

      getOwner(petsModel!.ownerId);

    })
    .catchError((error)
    {
      emit(GetPetDataErrorState(error.toString()));
    });
  }


  void changeType(index)
  {
    indexPet = index;
pets = [];
dogs = [];
cats = [];
rabbits= [];
fish= [];
birds= [];
    getPets();
    emit(ChangePetTypeSuccessState());
  }


//////////////////////////////////////////////////////////////////////////   update profile   ///////////////////////////

File? imageProfile;
 Future <void> pickprofile()async
{
  final PickedFile = await picker.pickImage(source: ImageSource.gallery);
  if(PickedFile != null)
  {
    imageProfile = File(PickedFile.path);
    emit(ProfileImagePickedSuccessState());
  }else
  {
    print('no image selected');
    emit(ProfileImagePickedErrorState());
  }
}

void removeProfileImage()
        {
          imageProfile = null;
          emit(RemoveProfileImageSuccessState());
        }

void uploadProfileImage({
  @required String? name,
  @required String? phone,
  String? profileImage,
})
{
  emit(UpdateProfileUploadState());
  firebase_storage.FirebaseStorage.instance
  .ref()
  .child('profile/${Uri.file(imageProfile!.path).pathSegments.last}')
  .putFile(imageProfile!)
  .then((value)
  {
    value.ref.getDownloadURL().then((value) 
    {
      updateProfile(name: name, phone: phone, profileImage: value);
      removeProfileImage();
      getUser();
    })
    .catchError((error)
    {
      emit(UpdateProfileErrorState());
    });
  })
  .catchError((error)
  {
    emit(UpdateProfileErrorState());
  });
}


void updateProfile({
  @required String? name,
  @required String? phone,
  String? profileImage,
})
{
  emit(UpdateProfileUploadState());
  UserModel model = UserModel(uId: userModel!.uId, name: name, phone: phone, email: userModel!.email, image: profileImage ?? userModel!.image);
  FirebaseFirestore.instance
  .collection('users')
  .doc(userModel!.uId)
  .set(model.toMap())
  .then((value) 
  {
    emit(UpdateProfileSuccessState());
    getUser();
  })
  .catchError((error)
  {
    emit(UpdateProfileErrorState());
  });
}


///////////////////////////////////////////////////////////////////////////////////////////////   owner     /////////////  


void getOwner(String? ownerId)
  {
    emit(GetOwnerLoadingState());
    FirebaseFirestore.instance
    .collection('users')
    .doc(ownerId)
    .get()
    .then((value) 
    {
      ownerModel = UserModel.fromjson(value.data()!);
      emit(GetOwnerSuccessState());
    })
    .catchError((error)
    {
      emit(GetOwnerErrorState(error.toString()));
    });
  }






  // List<PetsModel>petsList = 
  // [
  //   PetsModel(
  //     name: 'Sola', 
  //     type: 'cat', 
  //     age: '8 months', 
  //     distance: '3.6 Km', 
  //     gender: Icons.female,
  //     image: 'https://img.freepik.com/free-photo/red-white-cat-i-white-studio_155003-13189.jpg?w=360&t=st=1668893476~exp=1668894076~hmac=0614695804a4245892816c0192e39a12abe9f97388f09f7b93fdcf7d72f6587f'),
  //   PetsModel(
  //     name: 'Lucky', 
  //     type: 'dog', 
  //     age: '10 months', 
  //     distance: '2.2 Km', 
  //     gender: Icons.female,
  //     image: 'https://img.freepik.com/premium-photo/pomeranian-dog-cute-pet-happy-smile-playing-nature_106368-70.jpg?w=826'),
  //   PetsModel(
  //     name: 'Max', 
  //     type: 'dog', 
  //     age: '8 years', 
  //     distance: '1.5 Km', 
  //     gender: Icons.male,
  //     image: 'https://img.freepik.com/free-photo/adorable-brown-white-basenji-dog-smiling-giving-high-five-isolated-white_346278-1657.jpg?w=826&t=st=1668893727~exp=1668894327~hmac=4805a7dc70f5f897e9d2613750e60bc6789adc9736e6c747140516fb59fe72b8'),
  //   PetsModel(
  //     name: 'Jinx', 
  //     type: 'dog', 
  //     age: '1 years', 
  //     distance: '0.5 Km', 
  //     gender: Icons.male,
  //     image: 'https://img.freepik.com/premium-photo/pomeranian-spitz_1472-11020.jpg?w=826'),
  //   PetsModel(
  //     name: 'Chloe', 
  //     type: 'cat', 
  //     age: '2 years', 
  //     distance: '6.6 Km',
  //     gender: Icons.male, 
  //     image: 'https://img.freepik.com/free-photo/grey-cat-lying-looking-up_176474-6827.jpg?w=826&t=st=1668893758~exp=1668894358~hmac=1631b3d970740191726902bca0329f5400dcebc511136880b279186168166b9c'),
  //   PetsModel(
  //     name: 'Cody', 
  //     type: 'dog', 
  //     age: '3 years', 
  //     distance: '4.3 Km', 
  //     gender: Icons.male,
  //     image: 'https://img.freepik.com/free-photo/cute-puppy-maltipoo-dog-posing-isolated-white-background_155003-46004.jpg?w=826&t=st=1668893770~exp=1668894370~hmac=2d24574c9ae259d926a8b2d26b3fb4b2791e72111eaffcf2e3354c83fbb062c4'),
  // ];









  List<CatogeryModel> catogeryList = 
  [
    CatogeryModel(
      name: 'Dogs', 
      image: 'https://img.freepik.com/free-photo/portrait-funny-little-dog_23-2148366899.jpg?w=740&t=st=1669876720~exp=1669877320~hmac=4d5e8673040e5e90393196726399216b4fd051263d49c97e8d98cfcc792ccc19'),
    CatogeryModel(
      name: 'Cats', 
      image: 'https://img.freepik.com/premium-photo/studio-portrait-beautiful-grey-cat-dark-background-pet-mammal-animal-predator_158518-3811.jpg'),
    CatogeryModel(
      name: 'Rabbits', 
      image: 'https://img.freepik.com/premium-photo/white-rabit-closeup-head-red-background_188878-595.jpg?w=826'),
    CatogeryModel(
      name: 'Fish', 
      image: 'https://img.freepik.com/free-photo/dumpy-frog-litoria-caerulea-green-leaves-dumpy-frog-branch-tree-frog-branch_488145-3603.jpg?w=740&t=st=1669877682~exp=1669878282~hmac=dd2d185e5c60aacc4e81a0983dc0aa9f329c647987516120817e87528f867eaf'),
    CatogeryModel(
      name: 'Birds', 
      image: 'https://img.freepik.com/free-photo/white-bird-flying-sea_181624-36686.jpg?w=900&t=st=1669877236~exp=1669877836~hmac=4274a3929b49604f526ddd4ba04d2410ce34648529f7404de3ca3af10ff3b7ea'),
  ];
}