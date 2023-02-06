import 'package:bloc/bloc.dart';
import 'package:freelancer/modules/auth/model/empler_info.dart';
import 'package:freelancer/modules/profile/bloc/empler_profile_bloc/empler_profile_repo.dart';
import 'package:freelancer/modules/profile/bloc/empler_profile_bloc/empler_profile_state.dart';

class EmplerProfileBloc extends Cubit<EmplerProfileState> {
  EmplerProfileBloc({
    required this.emplerProfileRepo,
  }) : super(EmplerProfileLoadState());

  EmplerInfo? emplerInfo;

  final EmplerProfileRepo emplerProfileRepo;
}
