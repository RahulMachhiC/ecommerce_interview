import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:interview/api/app_repository.dart';

class RegisterController extends ChangeNotifier {
  bool isvisible = false;
  bool iscpasswordvisible = false;
  TextEditingController emailContoller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  TextEditingController cPasswordController = TextEditingController();
  bool isloading = false;
  bool iserror = false;
  void changevisiblity() {
    isvisible = !isvisible;
    notifyListeners();
  }

  void chageCpasswrod() {
    iscpasswordvisible = !iscpasswordvisible;
    notifyListeners();
  }

  void registeruser({
    required BuildContext context,
  }) async {
    isloading = true;
    notifyListeners();

    try {
      await AppRepository()
          .register(
              email: emailContoller.text,
              username: usernameController.text,
              password: passwordController.text)
          .then((value) {
        isloading = false;
        if (value["code"] == 200) {
          Fluttertoast.showToast(
            msg: value["message"],
          );
          emailContoller.clear();
          passwordController.clear();
          usernameController.clear();
          Navigator.pop(context);
        } else {
          Fluttertoast.showToast(
            msg: value["message"],
          );
        }

        notifyListeners();
      });
      notifyListeners();
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
      );
      iserror = true;
      isloading = false;

      notifyListeners();
    } finally {}
    notifyListeners();
  }
}
