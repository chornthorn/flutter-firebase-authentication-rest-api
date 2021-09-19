part of 'user_info_cubit.dart';

abstract class UserInfoState extends Equatable {
  const UserInfoState();
}

class UserInfoInitial extends UserInfoState {
  @override
  List<Object> get props => [];
}

class UserInfoLoading extends UserInfoState {
  @override
  List<Object> get props => [];
}

class UserInfoLoaded extends UserInfoState {
  final List<UserModel> data;

  const UserInfoLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class UserInfoInFailure extends UserInfoState {
  final String message;

  const UserInfoInFailure(this.message);

  @override
  List<Object> get props => [message];
}

class UserDeleteAccountSuccess extends UserInfoState {
  @override
  List<Object> get props => [];
}

class UserConfirmAccountSuccess extends UserInfoState {
  @override
  List<Object> get props => [];
}
