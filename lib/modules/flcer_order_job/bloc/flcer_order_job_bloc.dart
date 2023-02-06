import 'package:bloc/bloc.dart';
import 'package:freelancer/modules/flcer_order_job/bloc/flcer_order_job_repo.dart';
import 'package:freelancer/modules/flcer_order_job/bloc/flcer_order_job_state.dart';

class FlcerOrderJobBloc extends Cubit<FlcerOrderJobState> {
  FlcerOrderJobBloc() : super(FlcerOrderJobState());
  final _repo = FlcerOrderJobRepo();

  orderJob({
    required String jobId,
    required String salary,
    required String email,
    required String expDate,
  }) async {
    emit(FlcerOrderJobLoadState());
    var resData = await _repo.orderJob(
      jobId: int.parse(jobId),
      salary: salary,
      email: email,
      expDate: expDate,
    );
    if (resData.result) {
      emit(FlcerOrderJobSuccessState());
    } else {
      await Future.delayed(const Duration(seconds: 1));
      emit(FlcerOrderJobErrorState(resData.error));
    }
  }
}
