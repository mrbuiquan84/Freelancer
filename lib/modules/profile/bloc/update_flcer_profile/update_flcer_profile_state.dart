import 'package:equatable/equatable.dart';

abstract class UpdateFlcerProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateFlcerProfileInitState extends UpdateFlcerProfileState {}

class UpdateFlcerProfileErrorState extends UpdateFlcerProfileState {
  final dynamic error;

  UpdateFlcerProfileErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class UpdateFlcerProfileSuccessState extends UpdateFlcerProfileState {
  final String? message;

  UpdateFlcerProfileSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}

class UpdateFlcerProfileLoadState extends UpdateFlcerProfileState {}

// class UpdateFlcerProflieReceivedOTPState extends UpdateFlcerProfileState {
//   final String token;

//   UpdateFlcerProflieReceivedOTPState({required this.token});

//   @override
//   List<Object?> get props => [token];
// }
