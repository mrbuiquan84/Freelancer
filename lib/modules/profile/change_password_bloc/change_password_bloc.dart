import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/modules/profile/change_password_bloc/change_password_repo.dart';
import 'package:freelancer/modules/profile/change_password_bloc/change_password_state.dart';
import 'package:freelancer/utils/ui/show_toast.dart';

class ChangePassWordBloc extends Cubit<ChangePasswordState> {
  ChangePassWordBloc() : super(ChangePasswordInitState());
  final ChangePassWordRepo _repo = ChangePassWordRepo();

  changePassword(
      {required String password,
      required String newpassword,
      required String newrepassword}) async {
    var res = await _repo.changePassword(
        password: password,
        newPassword: newpassword,
        newrePassword: newpassword);
    if (res.result) {
      emit(ChangePasswordSuccessState());
      showToast("Đổi mật khẩu thành công");
    } else {
      emit(ChangePasswordErrorState(res._error?.message));
    }
  }

  changePassword2(
      {required String password,
      required String newpassword,
      required String newrepassword}) async {
    var res = await _repo.changePassword2(
        password: password,
        newPassword: newpassword,
        newrePassword: newpassword);
    if (res.result) {
      emit(ChangePasswordSuccessState());
      showToast("Đổi mật khẩu thành công");
    } else {
      emit(ChangePasswordErrorState(res._error?.message));
    }
  }
}
