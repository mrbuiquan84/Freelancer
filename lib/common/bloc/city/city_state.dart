import 'package:equatable/equatable.dart';
import 'package:freelancer/utils/data/city.dart';

abstract class CityState extends Equatable {}

class CityLoadState extends CityState {
  @override
  List<Object?> get props => [];
}

class CityListState extends CityState {
  final List<City> cities;
  final List<City> selectedCities;

  CityListState(
    this.cities, {
    this.selectedCities = const [],
  });

  @override
  List<Object?> get props => [cities, selectedCities];
}

class CityErrorState extends CityState {
  final String error;

  CityErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
