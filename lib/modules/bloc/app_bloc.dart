import 'package:bloc/bloc.dart';
import 'package:freelancer/common/services/http/result_data.dart';
import 'package:freelancer/common/services/share_pref/pref_service.dart';
import 'package:freelancer/modules/bloc/app_repo.dart';
import 'package:freelancer/modules/bloc/app_state.dart';

class AppBloc extends Cubit<AppState> {
  final AppRepo appRepo;
  AppBloc(this.appRepo) : super(AppLoadState()) {
    preLoad();
  }

  preLoad() async {
    emit(AppLoadState());
    var hasError = await Future.wait<ResultData>(
      [
        _getPrefsInstance(),
        _getListJobCate(),
        _getProvinces(),
      ],
      eagerError: true,
    ).onError((error, stackTrace) => [
          ResultData(
            result: false,
            error: Error(message: error.toString()),
          ),
        ]);
    var errorIndex = hasError.indexWhere((e) => !e.result);
    if (errorIndex != -1) {
      emit(AppErrorState(hasError[errorIndex].toString()));
      return;
    }

    emit(AppLoadDoneState());
  }

  Future<ResultData> _getListJobCate() async => await appRepo.getListJobCate();

  Future<ResultData> _getlistSkill(int id) async =>
      await appRepo.getListSkill(id: id);

  Future<ResultData> _getPrefsInstance() async {
    await Pref().getInstance();
    return ResultData(
      result: true,
    );
  }

  Future<ResultData> _getProvinces() async => await appRepo.getProvince();
}
