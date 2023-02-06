import 'package:bloc/bloc.dart';
import 'package:freelancer/modules/auth/model/flcer_info.dart';
import 'package:freelancer/modules/profile/bloc/flcer_profile_bloc/flcer_profile_repo.dart';
import 'package:freelancer/modules/profile/bloc/flcer_profile_bloc/flcer_profile_state.dart';

class FlcerProfileBloc extends Cubit<FlcerProfileState> {
  FlcerProfileBloc({
    required this.flcerProfileRepo,
  }) : super(FlcerProfileLoadState());
  FlcerInfo? flcerInfo;

  final FlcerProfileRepo flcerProfileRepo;
}
