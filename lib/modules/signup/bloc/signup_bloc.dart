import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/modules/bloc/app_repo.dart';
import 'package:freelancer/modules/signup/bloc/signup_repo.dart';
import 'package:freelancer/modules/signup/bloc/signup_state.dart';
import 'package:freelancer/modules/signup/model/post_signup_empler_result.dart';
import 'package:freelancer/modules/signup/model/post_signup_flcer_result.dart';
import 'package:freelancer/utils/data/city.dart';
import 'package:freelancer/utils/data/gender.dart';
import 'package:freelancer/utils/data/salary_type.dart';
import 'package:freelancer/utils/data/time.dart';
import 'package:freelancer/utils/helpers/datetime_extension.dart';
import 'package:intl/intl.dart';

class SignUpBloc extends Cubit<SignupState> {
  SignUpBloc({
    required this.appRepo,
  }) : super(SignupInitState()) {
    _preload();
  }

  final AppRepo appRepo;
  final SignupRepo signupRepo = const SignupRepo();

  _preload() async {
    emit(SignupInitState());
  }

  signupFlcer({
    required String email,
    required String phone,
    required String name,
    required Gender gender,
    required String password,
    required City city,
    required City district,
    required DateTime birthday,
    required SalaryType salaryType,
    required List<int> listCate,
    required Time salaryTime,
    required int minSalary,
    int? maxSalary,
    MultipartFile? avatarUser,
  }) async {
    emit(SignupLoadState());
    var res = await signupRepo.signupFlcer(
      email: email,
      phone: phone,
      name: name,
      gender: gender.id,
      password: password,
      city: city.citId,
      district: district.citId,
      birthday: DateFormat('yyyy-MM-dd').format(birthday),
      salaryType: salaryType.id,
      listCate: listCate,
      minSalary: minSalary,
      salaryTime: salaryTime.id,
    );
    if (res.result) {
      res.data = PostRegisterFlcerResult.fromJson(res.data);
      emit(
        SignupReceivedOTPState(
          token: (res.data as PostRegisterFlcerResult).token,
        ),
      );
    } else {
      emit(SignupErrorState(res.error.toString()));
    }
  }

  activeFlcer({
    required String otp,
    required String token,
  }) async {
    emit(SignupLoadState());
    var res = await signupRepo.activeFlcer(
      otp: otp,
      token: token,
    );
    if (res.result) {
      emit(SignupSuccessState(res.message));
    } else {
      emit(SignupErrorState(res.error.toString()));
    }
  }

  signupEmpler({
    required String email,
    required String phone,
    required String name,
    required Gender gender,
    required String password,
    required String repassword,
    required City city,
    required City district,
    required DateTime birthday,
    MultipartFile? avatarUser,
  }) async {
    emit(SignupLoadState());
    var res = await signupRepo.signupEmpler(
        email: email,
        name: name,
        phone: phone,
        gender: gender.id,
        password: password,
        city: city.citId,
        district: district.citId,
        birthday: birthday.format(),
        repassword: repassword);
    log('DEDEE');
    if (res.result) {
      res.data = PostRegisterEmplerResult.fromJson(res.data);
      emit(
        SignupEmplerReceivedOTPState(
          token: (res.data as PostRegisterEmplerResult).token,
        ),
      );
    } else {
      emit(SignupErrorState(res.error.toString()));
    }
  }

  activeEmpler({
    required String otp,
    required String token,
  }) async {
    emit(SignupLoadState());
    var res = await signupRepo.activeEmpler(
      otp: otp,
      token: token,
    );
    if (res.result) {
      emit(SignupSuccessState(res.message));
    } else {
      emit(SignupErrorState(res.error.toString()));
    }
  }
}
