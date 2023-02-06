import 'package:bloc/bloc.dart';
import 'package:freelancer/common/bloc/city/city_state.dart';
import 'package:freelancer/common/services/http/result_data.dart';
import 'package:freelancer/modules/bloc/app_repo.dart';

class CityBloc extends Cubit<CityState> {
  CityBloc(
    CityState initialState, {
    required this.appRepo,
  }) : super(initialState);
  final AppRepo appRepo;

  getDistricts(int id) async {
    emit(CityLoadState());
    print('Call');
    var res = await _getDistricts(id);
    if (res.result) {
      emit(CityListState(res.data));
      return;
    }
    emit(CityErrorState(res.error?.message ?? res.message));
  }

  Future<ResultData> _getDistricts(int id) async =>
      await appRepo.getProvince(id: id);
}
