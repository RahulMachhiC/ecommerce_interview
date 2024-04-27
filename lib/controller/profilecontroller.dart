import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:interview/api/app_repository.dart';
import 'package:interview/main.dart';
import 'package:interview/size_extension.dart';

class ProfileController extends ChangeNotifier {
  bool isvisible = false;
  File? selectedimage;
  bool isloading = false;
  bool iserror = false;

  TextEditingController emailContoller =
      TextEditingController(text: sharedPreferences!.getString("email") ?? '');
  TextEditingController passwordController = TextEditingController(
      text: sharedPreferences!.getString("password") ?? '');
  TextEditingController usernameController = TextEditingController(
      text: sharedPreferences!.getString("username") ?? '');

  void changeselectedImage({required BuildContext context}) {
    pickFile(context: context).then(
      (value) {
        selectedimage = File(value!.path);

        notifyListeners();
      },
    );
    // .then((value) {
    //   selectedimage = value;
    //   notifyListeners();
    // });
  }

  Future<File?> pickFile({
    List<String>? extensions,
    required BuildContext context,
    ImageSource source = ImageSource.gallery,
  }) async {
    try {
      // ignore: invalid_use_of_visible_for_testing_member
      final xPath = await ImagePicker.platform.getImageFromSource(
        source: source,
      );
      if (xPath != null) {
        final paths = File(xPath.path);

        return File(paths.path);
      } else {
        Fluttertoast.showToast(msg: "No file selected.");
        return null;
      }
    } catch (ex) {
      Fluttertoast.showToast(msg: "Unsupported operation$ex \n\n");
    }
    return null;
  }

  Widget userimageicon() {
    if (selectedimage != null) {
      return Image.file(
        selectedimage!,
        fit: BoxFit.cover,
      );
    }
    //  else if (driverProfile != null) {
    //   if (driverProfile!.profilePhoto.isNotEmpty) {
    //     return CachedNetworkImage(
    //       imageUrl: driverProfile!.profilePhoto,
    //       fit: BoxFit.cover,
    //     );
    //   }
    // }
    return Icon(
      Icons.person,
      size: 40.sp,
    );
  }

  void edituser({
    required BuildContext context,
  }) async {
    isloading = true;
    notifyListeners();

    try {
      await AppRepository()
          .edituser(
              username: usernameController.text,
              password: passwordController.text,
              email: emailContoller.text,
              id: sharedPreferences!.getString("id") ?? '')
          .then((value) {
        isloading = false;
        if (value["code"] == 200) {
          Fluttertoast.showToast(
            msg: value["message"],
          );
        } else {
          Fluttertoast.showToast(
            msg: value["message"],
          );
        }

        notifyListeners();
      });
      notifyListeners();
    } catch (e) {
      iserror = true;
      isloading = false;

      notifyListeners();
    } finally {}
    notifyListeners();
  }

  void changevisiblity() {
    isvisible = !isvisible;
    notifyListeners();
  }
}
