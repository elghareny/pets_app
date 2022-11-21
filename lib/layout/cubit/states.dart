abstract class AppStates{}

class InitialState extends AppStates{}

class ChoseGendarState extends AppStates{}

class AddPetDataLoadingState extends AppStates{}
class AddPetDataSuccessState extends AppStates
{
}
class AddPetDataErrorState extends AppStates
{
  final String? error;

  AddPetDataErrorState(this.error);
}

class GetPetDataLoadingState extends AppStates{}
class GetPetDataSuccessState extends AppStates
{
}
class GetPetDataErrorState extends AppStates
{
  final String? error;

  GetPetDataErrorState(this.error);
}



class GetUserLoadingState extends AppStates{}
class GetUserSuccessState extends AppStates
{
}
class GetUserErrorState extends AppStates
{
  final String? error;

  GetUserErrorState(this.error);
}



class RemovePetImageSuccessState extends AppStates{}


class PetImagePickedSuccessState extends AppStates{}
class PetImagePickedErrorState extends AppStates{}






