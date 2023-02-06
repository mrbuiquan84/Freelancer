import 'package:equatable/equatable.dart';

class ConfirmSetPriceState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ConfirmSetPriceLoadState extends ConfirmSetPriceState {}

class ConfirmSetPriceErrorState extends ConfirmSetPriceState {
  final dynamic error;
  ConfirmSetPriceErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

class ConfirmSetPriceSuccessState extends ConfirmSetPriceState {}
