import 'package:equatable/equatable.dart';

class FlcerOrderJobState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FlcerOrderJobLoadState extends FlcerOrderJobState {}

class FlcerOrderJobErrorState extends FlcerOrderJobState {
  final dynamic error;

  FlcerOrderJobErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

class FlcerOrderJobSuccessState extends FlcerOrderJobState {}