import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ielts/base/index.dart';
import 'package:ielts/screens/sign_in/controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ielts/widget/primary_button.dart';
import '../../index.dart';
import '../../widget/primary_input_filed.dart';
import '../sign_up/view.dart';

class SignInUI extends BaseView<SignInController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget body(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          gradient: Get.isDarkMode
              ? null
              : RadialGradient(
                  colors: [
                    Colors.blue.withOpacity(0.1),
                    Colors.blue.withOpacity(0.24),
                  ],
                  // center: Alignment(-1.0, 1.0),
                  radius: 1,
                ),
        ),
        child: Container(
          height: Get.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: Get.height / 6),
              logo(context),
              SizedBox(height: 120.h),
              Column(
                children: [
                  input(),
                  SizedBox(height: Get.height * 0.06),
                  buttonBottom(context),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget logo(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Positioned(
          bottom: -10,
          child: Container(
            width: 30,
            height: 0,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              boxShadow: [
                // BoxShadow(
                //   color: Color(0xff060044).withOpacity(0.9),
                //   spreadRadius: 6,
                //   blurRadius: 40,
                // )
              ],
            ),
          ),
        ),
        Image(
          image: AssetImage(AppImages.logoInApp),
          width: 160.w,
        ),
      ],
    );
  }

  Widget input() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InputFiledCustom(
                controller: controller.userNameCtrl,
                iconPrefix: Icon(AppIcons.user),
                labelText: "Tài khoản",
                validator: (p0) {
                  return Validator().notEmpty(p0, 'tài khoản');
                },
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) => null,
                color: AppColors.colorDark,
              ),
              SizedBox(height: 16),
              InputFiledCustom(
                controller: controller.passwordCtrl,
                iconPrefix: Icon(AppIcons.lock),
                labelText: "Mật khẩu",
                validator: (p0) {
                  return Validator().notEmpty(p0, "mật khẩu");
                },
                obscureText: true,
                color: AppColors.colorDark,
                onChanged: (value) => null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buttonBottom(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: PrimaryButton(
              labelText: 'Đăng nhập',
              fontSizeText: 16.sp,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  controller.signInWithAccount();
                }
              },
              // width: 135.w,
              padding: EdgeInsets.symmetric(horizontal: 44, vertical: 12),
            ),
          ),
          SizedBox(height: Get.height * 0.033),
          if (Configs.openLoginGoogle)
            const Text(
              "OR",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          const SizedBox(height: 16),
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Text(
                    "Bạn chưa có tài khoản?" + " ",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ), //Đăng ký ngay
                WidgetSpan(
                  child: InkWell(
                    onTap: () {
                      Get.to(() => SignUpUI());
                    },
                    child: Text(
                      "Đăng ký ngay",
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.colorPrimaryApp2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
