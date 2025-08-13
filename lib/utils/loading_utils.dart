import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoadingUtils {
  static void showProgress({String? message}) {
    EasyLoading.show(status: message ?? 'Loading...');
  }

  static void dismiss() {
    EasyLoading.dismiss();
  }

  static void showErrorMessage(String message) {
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
    EasyLoading.showError(message);
  }

  static void showSuccessMessage(String message) {
    EasyLoading.showSuccess(message);
  }
}