import 'package:equatable/equatable.dart';

class VoteFlcerState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VoteFlcerLoadState extends VoteFlcerState {}

class VoteFlcerErrorState extends VoteFlcerState {
  final dynamic error;
  VoteFlcerErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

class VoteFlcerSuccessState extends VoteFlcerState {}
