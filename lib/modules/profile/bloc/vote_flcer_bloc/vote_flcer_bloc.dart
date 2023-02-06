import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/modules/profile/bloc/vote_flcer_bloc/vote_flcer_repo.dart';
import 'package:freelancer/modules/profile/bloc/vote_flcer_bloc/vote_flcer_state.dart';

class VoteFlcerBloc extends Cubit<VoteFlcerState> {
  VoteFlcerBloc() : super(VoteFlcerState());

  final _repo = VoteFlcerRepo();

  voteFlcer(
      {required String flcerId,
      required String jobId,
      required int star}) async {
    emit(VoteFlcerState());
    var resData =
        await _repo.voteFlcerRepo(flcerId: flcerId, jobId: jobId, star: star);
    if (resData.result) {
      emit(VoteFlcerSuccessState());
    } else {
      emit(VoteFlcerErrorState(resData.error));
    }
  }
}
