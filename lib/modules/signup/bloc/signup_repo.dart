import 'package:dio/dio.dart';
import 'package:freelancer/common/services/http/api.dart';
import 'package:freelancer/common/services/http/api_address.dart';
import 'package:freelancer/common/services/http/result_data.dart';

class SignupRepo {
  const SignupRepo();

  Future<ResultData> signupFlcer({
    required String email,
    required String phone,
    required String name,
    required int gender,
    required String password,
    required int city,
    required int district,
    required String birthday,
    required int salaryType,
    required int salaryTime,
    required List<int> listCate,
    required int minSalary,
    MultipartFile? avatarUser,
    int? maxSalary,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    var body = {
      'email': email,
      'phone': phone,
      'name': name,
      'sex': gender,
      'password': password,
      'city': city,
      'district': district,
      'birthday': birthday,
      'salary_type': salaryType,
      'list_cate': listCate.join(', '),
      'salary_permanent_date': salaryTime,
      'salary_estimates_date': salaryTime,
      'salary_permanent_number': minSalary,
      'salary_estimate_number_1': minSalary,
      'salary_salary_estimate_number_2': maxSalary,
      'avatar_user': avatarUser,
    };

    return await httpManager.netFetch(
      ApiAddress.postRegisterFlcer,
      method: 'post',
      params: body,
      isFormData: true,
    );
  }

  Future<ResultData> activeFlcer({
    required String otp,
    required String token,
  }) async {
    var body = {
      'otp': otp,
      'token': token,
    };

    return await httpManager.netFetch(
      ApiAddress.postActiveFlcer,
      params: body,
      method: 'post',
      isFormData: true,
    );
  }

  Future<ResultData> activeEmpler({
    required String otp,
    required String token,
  }) async {
    var body = {
      'otp': otp,
      'token': token,
    };

    return await httpManager.netFetch(
      ApiAddress.postActiveEmpler,
      params: body,
      method: 'post',
      isFormData: true,
    );
  }

  Future<ResultData> signupEmpler(
      {required String email,
      required String phone,
      required String name,
      required int gender,
      required String password,
      required String repassword,
      required int city,
      required int district,
      required String birthday,
      MultipartFile? avatarUser}) async {
    await Future.delayed(const Duration(seconds: 2));
    var body = {
      'email': email,
      'name': name,
      'phone': phone,
      'sex': gender,
      'password': password,
      'city': city,
      'district': district,
      'birthday': birthday,
      'avatar': avatarUser,
      'repassword': repassword,
    };
    return await httpManager.netFetch(
      ApiAddress.postRegisterEmpler,
      method: 'post',
      params: body,
      isFormData: true,
    );
  }
}
