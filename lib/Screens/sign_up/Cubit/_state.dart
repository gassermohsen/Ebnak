abstract class EbnakRegisterStates {}

class EbnakRegisterInitialState extends EbnakRegisterStates {}

class EbnakRegisterLoadingState extends EbnakRegisterStates {}

class EbnakRegisterSuccessState extends EbnakRegisterStates {}

class EbnakRegisterErrorState extends EbnakRegisterStates
{
  final String error;

  EbnakRegisterErrorState(this.error);
}

class EbnakCreateUserSuccessState extends EbnakRegisterStates {}

class EbnakCreateUserErrorState extends EbnakRegisterStates
{
  final String error;

  EbnakCreateUserErrorState(this.error);
}

class EbnakRegisterChangePasswordVisibilityState extends EbnakRegisterStates {}