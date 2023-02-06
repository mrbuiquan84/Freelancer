import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/utils/data/salary_type.dart';
import 'package:freelancer/utils/helpers/time_utils.dart';

class Validator {
  static DateTime firstDateOfWorking = TimeUtils.tomorrow();

  static String? validatePhone(String? value) {
    if (value!.trim().isEmpty || value.trim() == '') {
      return 'Số điện thoại không được để trống';
    }
    if (!value.startsWith('0')) {
      return 'Số điện thoại không đúng định dạng';
    }
    if (value.trim().length < 10) {
      return 'Số điện thoại hợp lệ cần đủ 10 số';
    }
    return null;
  }

  static String? validateMinLength(
    String? value, {
    int minLength = 50,
  }) {
    if (value!.trim().isEmpty || value.trim() == '') {
      return 'Không được để trống';
    }
    if (value.trim().length < minLength) {
      return 'Bạn phải nhập ít nhất 50 từ.';
    }
    return null;
  }

  static String? validateNotEmpty(String? value) {
    return value!.trim().isEmpty ? 'Không được để trống' : null;
  }

  static String? validateDateTimeNotEmpty(DateTime? value) {
    return value == null ? 'Không được để trống' : null;
  }

  static String? validateCity(String? value) {
    return value!.trim().isEmpty ? 'Bạn chưa chọn Tỉnh/Thành phố' : null;
  }

  static String? validateDistrict(String? value) {
    return value!.trim().isEmpty ? 'Vui lòng chọn Quận/Huyện' : null;
  }

  static String? validateDob(String? value) {
    return value!.trim().isEmpty ? 'Vui lòng chọn ngày sinh' : null;
  }

  static String? validateAddress(String? value) {
    return value!.trim().isEmpty ? 'Vui lòng nhập địa chỉ' : null;
  }

  static String? validatePassword(String? value) {
    var pattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,20}$';
    var regExp = RegExp(pattern);
    if (!regExp.hasMatch(value ?? '')) {
      return 'Mật khẩu phải từ 8-20 ký tự gồm ít nhất 1 chữ hoa, chữ thường, số và không chứa dấu cách';
    }
    return null;
  }

  static String? validateNewPassword(String? pass, String? rePass) {
    var validatePasswordRePass = validatePassword(rePass);
    if (validatePasswordRePass != null) return validatePasswordRePass;
    var validateEmptyPass = validateNotEmpty(pass);
    if (validateEmptyPass != null) return 'Nhập mật khẩu trước';
    if (pass!.trim() != rePass!.trim()) return 'Mật khẩu không trùng khớp';
    return null;
  }

  static String? validateEstimatesSalary(String? from, String? to) {
    int f = int.parse(from?.isEmpty == true ? '0' : from!);
    int t = int.parse(to?.isEmpty == true ? '0' : to!);
    if (f == 0 && t == 0) {
      return 'Không được để trống';
    } else if (f >= t) {
      return 'Không hợp lệ';
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value!.isEmpty) {
      return 'Họ và tên không được để trống!';
    } else if (value.trim().length < 6) {
      return 'Họ và tên phải lớn hơn 6 kí tự';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (value!.isEmpty) {
      return 'Email không được để trống!';
    } else if (!emailRegExp.hasMatch(value.trim())) {
      return 'Email không hợp lệ.';
    }
    return null;
  }

  static String? validateTwoDate(DateTime? start, DateTime? end) {
    if (end == null) return 'Không được để trống';

    if (end.isBefore(start!)) return 'Ngày kết thúc phải sau ngày bắt đầu ';

    return null;
  }

  static String? validateTwoDate2(DateTime? start, DateTime? end) {
    if (end == null) return 'Không được để trống';

    if (end.isBefore(start!)) return 'Ngày làm việc phải sau ngày kết thúc';

    return null;
  }

  static String? inputEndDateOfWorkingValidator(DateTime? selectedValue) {
    if (selectedValue == null) return null;

    if (selectedValue.isAtSameMomentAs(firstDateOfWorking)) {
      return 'Ngày kết thúc phải sau ngày bắt đầu';
    }

    if (selectedValue.isBefore(firstDateOfWorking)) {
      return 'Ngày kết thúc phải sau ngày đăng tin';
    }

    return null;
  }

  static String? salaryValidator(
    String? value, {
    required SalaryType salaryType,
  }) {
    if (value == null || value.isEmpty) {
      return StringConst.notAllowEmpty;
    } else {
      if (salaryType == SalaryType.staticSalaryType) {
        return _staticSalaryTypeValidator(value);
      } else {
        return _estimateSalaryTypeValidator(value);
      }
    }
  }

  static _staticSalaryTypeValidator(String value) {
    try {
      int.parse(value);
      return null;
    } catch (e) {
      return 'Mức lương cố định phải là 1 số';
    }
  }

  static _estimateSalaryTypeValidator(String value) {
    try {
      var s = value.trim().split(' ');
      s.removeWhere((_s) => _s == ' ');
      int.parse(s[0]);
      int.parse(s[2]);
      if (s[1].trim() != '-') {
        throw Exception();
      }
      return null;
    } catch (e) {
      return 'Mức lương ước lượng chưa đúng định dạng: số - số';
    }
  }

  static otpValidator(String? value, {int otpLength = 6}) {
    if (value == null || value.isEmpty) {
      return StringConst.notAllowEmpty;
    } else {
      if (value.length < otpLength) {
        return StringConst.fillOtpField;
      }
    }
    return;
  }
}
