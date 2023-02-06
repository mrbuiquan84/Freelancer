import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/common/services/share_pref/pref_service.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/modules/auth/bloc/auth_event.dart';
import 'package:freelancer/modules/auth/bloc/auth_repo.dart';
import 'package:freelancer/modules/auth/bloc/auth_state.dart';
import 'package:freelancer/modules/auth/model/auth_status.dart';
import 'package:freelancer/modules/auth/model/empler_info.dart';
import 'package:freelancer/modules/auth/model/flcer_info.dart';
import 'package:freelancer/modules/auth/model/post_empler_info_result.dart';
import 'package:freelancer/modules/auth/model/post_flcer_info_result.dart';
import 'package:freelancer/modules/auth/model/post_login_result.dart';
import 'package:freelancer/modules/bloc/app_repo.dart';
import 'package:freelancer/modules/profile/bloc/empler_profile_bloc/empler_profile_bloc.dart';
import 'package:freelancer/modules/profile/bloc/empler_profile_bloc/empler_profile_state.dart';
import 'package:freelancer/modules/profile/bloc/flcer_profile_bloc/flcer_profile_bloc.dart';
import 'package:freelancer/modules/profile/bloc/flcer_profile_bloc/flcer_profile_state.dart';
import 'package:freelancer/utils/data/gender.dart';
import 'package:freelancer/utils/data/user_type.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    this.userType = UserType.freelancer,
    required this.authRepo,
    required this.appRepo,
  }) : super(const AuthUnknownState()) {
    on<AuthStatusChanged>((event, emit) async {
      switch (event.status) {
        case AuthStatus.unknown:
          emit(const AuthUnknownState());
          break;
        case AuthStatus.authed:
          emit(const AuthenticatedState());
          break;
        case AuthStatus.unAuth:
          emit(const UnAuthenticatedState());
          break;
      }
    });
    on<AuthLogoutRequest>((event, emit) async {
      emit(const UnAuthenticatedState(showIntro: false));
    });

    _statusSubscription = authRepo.status.listen((status) {
      add(AuthStatusChanged(status));
    });

    _initLoad();
  }

  // Load khi khoi tao app
  _initLoad() async {
    var isExist = _checkLocalStorageToken();
    if (isExist) {
      var typeStr = prefs.getString(StringConst.userTypeKey);
      if (typeStr != null) {
        if (typeStr == UserType.freelancer.toString()) {
          userType = UserType.freelancer;
        } else if (typeStr == UserType.employer.toString()) {
          userType = UserType.employer;
        }
        var resData = await _loadData();
        if (resData == null) {
          return add(AuthStatusChanged(AuthStatus.authed));
        }
      }
    }
    return add(AuthStatusChanged(AuthStatus.unAuth));
  }

  late final StreamSubscription<AuthStatus> _statusSubscription;
  final AuthRepo authRepo;
  final AppRepo appRepo;
  UserType userType;

  dynamic currentUser;

  FlcerInfo? get currentFlcer => flcerProfileBloc?.flcerInfo;
  EmplerInfo? get currentEmpler => emplerProfileBloc?.emplerInfo;

  FlcerProfileBloc? flcerProfileBloc;

  EmplerProfileBloc? emplerProfileBloc;
  login({
    required String email,
    required String password,
    required UserType loginUserType,
    // UserType loginUserType = UserType.freelancer,
  }) async {
    if (loginUserType == UserType.freelancer) {
      var res = await authRepo.loginFlcer(email: email, password: password);
      if (res.result) {
        var loginRes = PostLoginResult.fromJson(res.data);
        try {
          await prefs.setString(StringConst.tokenKey, loginRes.token);
          await prefs.setString(
              StringConst.userTypeKey, loginUserType.toString());
          userType = loginUserType;
          var res = await _loadData();
          if (res == null) {
            return add(AuthStatusChanged(AuthStatus.authed));
          }
          return res;
        } catch (e) {
          return e.toString();
        }
      } else {
        return res.error.toString();
      }
    } else {
      var res = await authRepo.loginEmpler(email: email, password: password);
      if (res.result) {
        var loginRes = PostLoginResult.fromJson(res.data);
        try {
          await prefs.setString(StringConst.tokenKey, loginRes.token);
          await prefs.setString(
              StringConst.userTypeKey, loginUserType.toString());
          userType = loginUserType;
          var res = await _loadData();
          if (res == null) {
            return add(AuthStatusChanged(AuthStatus.authed));
          }
          return res;
        } catch (e) {
          return e.toString();
        }
      } else {
        return res.error.toString();
      }
    }
    // var res = await authRepo.loginFlcer(email: email, password: password);
    // if (res.result) {
    //   var loginRes = PostLoginResult.fromJson(res.data);
    //   try {
    //     await prefs.setString(StringConst.tokenKey, loginRes.token);
    //     await prefs.setString(
    //         StringConst.userTypeKey, loginUserType.toString());
    //     userType = loginUserType;
    //     var res = await _loadData();
    //     if (res == null) {
    //       return add(AuthStatusChanged(AuthStatus.authed));
    //     }
    //     return res;
    //   } catch (e) {
    //     return e.toString();
    //   }
    // } else {
    //   return res.error.toString();
    // }
  }

  bool _checkLocalStorageToken() => authRepo.checkLocalStorageToken();

  Future<String?> _loadData() async {
    var resData = await authRepo.getCurrentUserInfo(userType: userType);
    if (resData.result) {
      try {
        onUserTypeCase(userType, flcerFunc: () {
          // Freelancer
          var res = PostFlcerInfoResult.fromJson(resData.data);
          var renderer = res.dataRender;
          flcerProfileBloc =
              FlcerProfileBloc(flcerProfileRepo: authRepo.flcerProfileRepo);
          flcerProfileBloc!.flcerInfo = FlcerInfo(
            info: res.info,
            basic: renderer.basic,
            intro: renderer.intro,
            work: renderer.work,
            skill: renderer.skill,
            proficiency: renderer.proficiency,
          );
          flcerProfileBloc!.emit(FlcerProfileDoneState());
        }, emplerFunc: () {
          var res = PostEmplerInfoResult.fromJson(resData.data);
          emplerProfileBloc =
              EmplerProfileBloc(emplerProfileRepo: authRepo.emplerProfileRepo);
          emplerProfileBloc!.emplerInfo = EmplerInfo(
            name: res.info.name,
            birthday: res.info.birthday,
            city: res.info.city,
            district: res.info.district,
            sex: Gender.fromStringId(res.info.gender.toString()).toString(),
            email: res.info.email,
            createdAt: res.info.createdAt,
            phone: res.info.phone,
            avatar: res.info.avatar,
            point: res.info.point,
          );
          emplerProfileBloc!.emit(EmplerProfileDoneState());
        });

        // TODO: implement Employer login
        return null;
      } catch (e, s) {
        print(e);
        print(s);
        return StringConst.loginError;
      }
    } else {
      return resData.error?.toString();
    }
  }

  Future<void> logout() async {
    var message = await authRepo.logout();
    if (message == null) {
      add(AuthLogoutRequest());
    }
  }

  @override
  Future<void> close() {
    _statusSubscription.cancel();
    return super.close();
  }
}

extension CurrentUser on AuthBloc {
  static AuthBloc of(BuildContext context) => context.read<AuthBloc>();
}
