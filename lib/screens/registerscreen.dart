import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interview/controller/registercontroller.dart';
import 'package:interview/size_extension.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RegisterController>(builder: (context, controller, child) {
        return Padding(
          padding: EdgeInsets.all(12.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlutterLogo(
                size: 150.h,
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                "Register",
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                "New User",
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              TextFormField(
                controller: controller.emailContoller,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: "Enter your email",
                  hintStyle: GoogleFonts.inter(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              TextFormField(
                controller: controller.usernameController,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: "Enter your username",
                  hintStyle: GoogleFonts.inter(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              TextFormField(
                controller: controller.passwordController,
                obscureText: controller.isvisible,
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                    onTap: () {
                      controller.changevisiblity();
                    },
                    child: Icon(
                      controller.isvisible
                          ? Icons.remove_red_eye
                          : Icons.hide_source_sharp,
                      color: Colors.black,
                    ),
                  ),
                  isDense: true,
                  hintText: "Enter your password",
                  hintStyle: GoogleFonts.inter(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              TextFormField(
                controller: controller.cPasswordController,
                obscureText: controller.iscpasswordvisible,
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                    onTap: () {
                      controller.chageCpasswrod();
                    },
                    child: Icon(
                      controller.iscpasswordvisible
                          ? Icons.remove_red_eye
                          : Icons.hide_source_sharp,
                      color: Colors.black,
                    ),
                  ),
                  isDense: true,
                  hintText: "Confirm your password",
                  hintStyle: GoogleFonts.inter(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              InkWell(
                onTap: () {
                  if (controller.emailContoller.text.isEmpty) {
                    Fluttertoast.showToast(msg: "Please Enter Email");
                  } else if (controller.usernameController.text.isEmpty) {
                    Fluttertoast.showToast(msg: "Please Enter username");
                  } else if (controller.passwordController.text.isEmpty) {
                    Fluttertoast.showToast(msg: "Please Enter password");
                  } else if (controller.cPasswordController.text.isEmpty) {
                    Fluttertoast.showToast(msg: "Password Not Matched");
                  } else if (controller.passwordController.text !=
                      controller.cPasswordController.text) {
                    Fluttertoast.showToast(msg: "Password Not Matched");
                  } else {
                    controller.registeruser(context: context);
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    "Signup",
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Already have an account? Login",
                  style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}



// 9727420279