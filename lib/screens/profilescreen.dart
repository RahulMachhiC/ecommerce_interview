import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interview/size_extension.dart';
import 'package:provider/provider.dart';

import '../controller/profilecontroller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff0f0f7),
      appBar: AppBar(
        centerTitle: true,
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 2,
        title: Text(
          "Profile",
          style: GoogleFonts.inter(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Consumer<ProfileController>(builder: (context, controller, child) {
        return Padding(
          padding: EdgeInsets.all(12.r),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  controller.changeselectedImage(context: context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                          height: 90.h,
                          width: 90.w,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                          child: controller.userimageicon()),
                    ),
                    Transform.translate(
                      offset: const Offset(-24, 40),
                      child: Container(
                        padding: EdgeInsets.all(4.r),
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.edit,
                          size: 10.sp,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
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
              SizedBox(
                height: 20.h,
              ),
              InkWell(
                onTap: () {
                  if (controller.emailContoller.text.isEmpty) {
                    Fluttertoast.showToast(msg: "Please Enter Email");
                  } else if (controller.passwordController.text.isEmpty) {
                    Fluttertoast.showToast(msg: "Please Enter password");
                  } else if (controller.usernameController.text.isEmpty) {
                    Fluttertoast.showToast(msg: "Please Enter Usernname");
                  } else {
                    controller.edituser(context: context);
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
                    "Update Profile",
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
