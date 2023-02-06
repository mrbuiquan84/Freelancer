import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/modules/home/flcer/bloc/flcer_home_repo.dart';
import 'package:freelancer/modules/home/flcer/bloc/flcer_home_state.dart';
import 'package:freelancer/modules/home/flcer/model/get_home_load_data_result.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class FlcerHomeBloc extends Cubit<FlcerHomeState> {
  FlcerHomeBloc() : super(const FlcerHomeState()) {
    loadData();
    loadData2();
  }
  final FlcerHomeRepo _repo = FlcerHomeRepo();

  loadData({
    int page = 1,
    int limit = kHomeItemLimit,
  }) async {
    // emit(FlcerHomeLoadState());
    var resData = await _repo.loadData(
      page: page,
      limit: limit,
    );
    if (resData.result) {
      var res = GetHomeDataLoadResult.fromJson(resData.data);
      emit(state.copyWith(
        jobByProjects: [...state.jobByProjects, ...res.dataRender.jobByProject],
        jobParttimes: [...state.jobParttimes, ...res.dataRender.jobPartTime],
      ));
    } else {
      emit(FlcerHomeErrorState(resData.error?.message));
    }
  }

  loadData2({
    int page = 1,
    int limit = kHomeItemLimit,
  }) async {
    // emit(FlcerHomeLoadState());
    var resData = await _repo.loadData2(
      page: page,
      limit: limit,
    );
    if (resData.result) {
      var res = GetHomeDataLoadResult.fromJson(resData.data);
      emit(state.copyWith(
        jobByProjects: [...state.jobByProjects, ...res.dataRender.jobByProject],
        jobParttimes: [...state.jobParttimes, ...res.dataRender.jobPartTime],
      ));
    } else {
      emit(FlcerHomeErrorState(resData.error?.message));
    }
  }
}
