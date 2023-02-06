import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/modules/profile/bloc/empler_general_bloc/empler_general_repo.dart';
import 'package:freelancer/modules/profile/bloc/empler_general_bloc/empler_general_state.dart';
import 'package:freelancer/modules/profile/bloc/empler_general_bloc/post_empler_general.dart';
import 'package:freelancer/modules/profile/bloc/posted_job_bloc/posted_job_state.dart';

import '../../../../core/constants/string_constants.dart';
import '../../../../utils/data/error_state_action.dart';
import '../../../../utils/data/load_state_actions.dart';

class EmplerGeneralBloc extends Cubit<EmplerGeneralState> {
  EmplerGeneralBloc() : super(EmplerGeneralLoadState()) {
    getData();
  }

  final EmplerGeneralRepo _repo = EmplerGeneralRepo();
  List<Data2> jobs = [];
  List<Data3> flcers = [];

  getData({
    LoadStateActions onLoad = LoadStateActions.rebuild,
    ErrorStateActions onError = ErrorStateActions.rebuild,
  }) async {
    emit(EmplerGeneralLoadState(action: onLoad));

    try {
      var resData = await _repo.getEmplerGeneral();
      if (resData.result) {
        var res = PostEmplerGeneral.fromJson(resData.data);
        // var data1 = res.data1;
        // var data2 = res.data2;
        // jobs.addAll(data2);
        // var data3 = res.data3;
        // flcers.addAll(data3);
        emit(EmplerGeneralDoneState(
            general: res.data1, jobs: res.data2, flcers: res.data3));
      } else {
        emit(EmplerGeneralErrorState(
          StringConst.errorOccurredTryAgainError,
          action: onError,
        ));
      }
    } catch (e, s) {
      print(e);
      print(s);
      emit(EmplerGeneralErrorState(
        StringConst.errorOccurredTryAgainError,
        action: onError,
      ));
    }
  }
}
