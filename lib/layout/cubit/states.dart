abstract class AppStates{}

class InitialState extends AppStates{}

class ChoseGendarState extends AppStates{}

class ChoseTypeState extends AppStates{}

class LogoutSuccessState extends AppStates{}

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

class ChangePetTypeSuccessState extends AppStates
{
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

class ProfileImagePickedSuccessState extends AppStates{}
class ProfileImagePickedErrorState extends AppStates{}

class RemoveProfileImageSuccessState extends AppStates{}


class UpdateProfileUploadState extends AppStates{}
class UpdateProfileSuccessState extends AppStates{}
class UpdateProfileErrorState extends AppStates{}



class GetOwnerLoadingState extends AppStates{}
class GetOwnerSuccessState extends AppStates
{
}
class GetOwnerErrorState extends AppStates
{
  final String? error;

  GetOwnerErrorState(this.error);
}


class GetMyPetsLoadingState extends AppStates{}
class GetMyPetsSuccessState extends AppStates
{
}
class GetMyPetsErrorState extends AppStates
{
  final String? error;

  GetMyPetsErrorState(this.error);
}
