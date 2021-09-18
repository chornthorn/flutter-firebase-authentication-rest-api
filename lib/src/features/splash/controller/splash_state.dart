part of 'splash_cubit.dart';

abstract class SplashState extends Equatable {
  const SplashState();
}



class SplashLoading extends SplashState {
  @override
  List<Object> get props => [];
}

class SplashLoaded extends SplashState {
  @override
  List<Object> get props => [];
}

class SplashFailure extends SplashState {
  final String message;

  const SplashFailure(this.message);

  @override
  List<Object> get props => [];
}
