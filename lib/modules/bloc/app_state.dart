import 'package:equatable/equatable.dart';

abstract class AppState extends Equatable {}

class AppLoadState extends AppState {
  @override
  List<Object?> get props => [];
}

class AppErrorState extends AppState {
  AppErrorState(this.error);
  final String error;

  @override
  List<Object?> get props => [error];
}

class AppLoadDoneState extends AppState {
  @override
  List<Object?> get props => [];
}
