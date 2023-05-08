abstract class LoginState {}

class InitialLoginState extends LoginState {}

class LoginSuccessfullyState extends LoginState {
  LoginSuccessfullyState(this.message);
  String message;
}

class LoginFailedState extends LoginState {
  LoginFailedState(this.message);
  String message;
}
