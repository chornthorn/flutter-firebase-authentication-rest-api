part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterLoading extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterSuccess extends RegisterState {
  final SignUpResModel data;

  const RegisterSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class RegisterFailure extends RegisterState {
  final String message;

  const RegisterFailure(this.message);

  @override
  List<Object> get props => [message];
}

class LoginSuccess extends RegisterState {
  final SignInResModel data;

  const LoginSuccess(this.data);

  @override
  List<Object> get props => [data];
}
