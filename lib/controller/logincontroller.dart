import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:interview/api/app_repository.dart';
import 'package:interview/main.dart';
import 'package:interview/screens/homescreen.dart';

class LoginController extends ChangeNotifier {
  bool isvisible = false;

  TextEditingController emailContoller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isloading = false;
  bool iserror = false;
  void changevisiblity() {
    isvisible = !isvisible;
    notifyListeners();
  }

  void loginuser({
    required BuildContext context,
  }) async {
    isloading = true;
    notifyListeners();

    try {
      await AppRepository()
          .login(email: emailContoller.text, password: passwordController.text)
          .then((value) {
        isloading = false;
        if (value["code"] == 200) {
          Fluttertoast.showToast(
            msg: value["message"],
          );
          emailContoller.clear();
          sharedPreferences!.setString("id", value["user_id"]);
          sharedPreferences!.setString("password", value["password"]);
          sharedPreferences!.setString("username", value["username"]);
          sharedPreferences!.setString("email", value["email"]);

          passwordController.clear();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
              (route) => false);
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
