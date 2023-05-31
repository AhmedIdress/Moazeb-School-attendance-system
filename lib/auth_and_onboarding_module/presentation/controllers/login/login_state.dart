abstract class LoginState {}

class InitialLoginState extends LoginState {}

class WaitingLoginState extends LoginState {}

class LoginSuccessfullyState extends LoginState {
  LoginSuccessfullyState(this.message, this.isParent);

  String message;
  bool isParent;
}

class LoginFailedState extends LoginState {
  LoginFailedState(this.message);

  String message;
}
