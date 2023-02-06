import 'package:bloc/bloc.dart';
import 'package:freelancer/modules/profile/bloc/confirm_set_price_bloc/confirm_set_price_repo.dart';
import 'package:freelancer/modules/profile/bloc/confirm_set_price_bloc/confirm_set_price_state.dart';

class ConfirmSetPriceBloc extends Cubit<ConfirmSetPriceState> {
  ConfirmSetPriceBloc() : super(ConfirmSetPriceState());
  final _repo = ConfirmSetPriceRepo();

  confirmPrice({
    required String jobId,
    required String flcId,
    required int isconfirm,
  }) async {
    emit(ConfirmSetPriceState());
    var resData = await _repo.confirmSetPriceRepo(
      isconfirm: isconfirm,
      jobId: int.parse(jobId),
      flcID: int.parse(flcId),
    );
    if (resData.result) {
      emit(ConfirmSetPriceSuccessState());
    } else {
      emit(ConfirmSetPriceErrorState(resData.error));
    }
  }
}
