enum AppErrorState { lostConnection, unkownn }

extension AppErrorStateExt on AppErrorState {
  String get friendlyName {
    switch (this) {
      case AppErrorState.lostConnection:
        return 'Không có kết nối mạng.';
      case AppErrorState.unkownn:
        return 'Đã có lỗi xảy ra, vui lòng thử lại sau.';
    }
  }
}
