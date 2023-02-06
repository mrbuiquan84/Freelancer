import 'package:bloc/bloc.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/modules/empler/bloc/empler_detail_repo.dart';
import 'package:freelancer/modules/empler/bloc/empler_detail_state.dart';
import 'package:freelancer/modules/empler/models/post_empler_detail_result.dart';

class EmplerDetailBloc extends Cubit<EmplerDetailState> {
  EmplerDetailBloc({required this.id}) : super(EmplerDetailLoadState()) {
    loadData(id: id);
  }
  final EmplerDetailRepo _repo = EmplerDetailRepo();
  final int id;

  loadData({required int id}) async {
    emit(EmplerDetailLoadState());
    var resData = await _repo.getEmplerDetail(id: id);
    if (resData.result) {
      try {
        var res = PostEmplerDetailResult.fromJson(resData.data);
        emit(EmplerDetailLoadDoneState(info: res.info, jobs: res.infoJobs));
      } catch (e, s) {
        print(e);
        print(s.toString());
        emit(EmplerDetailErrorState(StringConst.errorOccurredTryAgainError));
      }
    } else {
      emit(EmplerDetailErrorState(resData.error));
    }
  }
}
