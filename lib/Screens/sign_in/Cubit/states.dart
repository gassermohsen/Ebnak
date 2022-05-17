
abstract  class EbnakLoginStates{}

class EbnakLoginInitialState extends EbnakLoginStates{}

class EbnakLoginLoadingState extends EbnakLoginStates{}

class EbnakLoginSuccessState extends EbnakLoginStates
{
  final String uId;

  EbnakLoginSuccessState(this.uId);
}

class EbnakLoginErrorState extends EbnakLoginStates{
  final String error;
  EbnakLoginErrorState(this.error);

}