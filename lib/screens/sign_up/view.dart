import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ielts/base/index.dart';
import 'package:ielts/index.dart';
import 'package:ielts/screens/sign_in/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/validate.dart';
import '../../values/app_colors.dart';
import '../../values/app_icons.dart';
import '../../widget/primary_button.dart';
import '../../widget/primary_input_filed.dart';

class SignUpUI extends BaseView<SignInController> {
  final _formKey = GlobalKey<FormState>();

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget body(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Thông tin tài khoản",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  input(),
                  SizedBox(height: 60.h),
                  renderButton(),
                ],
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget input() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InputFiledCustom(
              controller: controller.accountEditCtrl,
              iconPrefix: const Icon(AppIcons.user),
              labelText: 'Tài khoản',
              validator: (p0) {
                return Validator().notEmpty(p0, 'tài khoản');
              },
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => null,
              color: AppColors.colorDark,
            ),
            SizedBox(height: halfPadding),
            InputFiledCustom(
              controller: controller.emailEditCtrl,
              iconPrefix: Icon(Icons.email_outlined),
              labelText: 'Email',
              validator: (p0) {
                return Validator().notEmpty(p0, 'email');
              },
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => null,
              color: AppColors.colorDark,
            ),
            SizedBox(height: halfPadding),
            InputFiledCustom(
              controller: controller.displayNameEditCtrl,
              iconPrefix: Icon(AppIcons.user),
              labelText: 'Họ và tên',
              validator: (p0) {
                return Validator().notEmpty(p0, 'họ và tên');
              },
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => null,
              color: AppColors.colorDark,
            ),
            SizedBox(height: halfPadding),
            InputFiledCustom(
              controller: controller.phoneNumberEditCtrl,
              iconPrefix: Icon(Icons.phone),
              labelText: 'Số điện thoại',
              validator: (v) {
                return null;
              },
              obscureText: false,
              color: AppColors.colorDark,
              onChanged: (value) => null,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: halfPadding),
            InputFiledCustom(
              controller: controller.passwordSignUpEditCtrl,
              iconPrefix: Icon(AppIcons.lock),
              labelText: 'Mật khẩu',
              validator: (p0) {
                return Validator().notEmpty(p0, "mật khẩu");
              },
              obscureText: true,
              color: AppColors.colorDark,
              onChanged: (value) => null,
            ),
            SizedBox(height: halfPadding),
            InputFiledCustom(
              controller: controller.confirmPasswordSignUpEditCtrl,
              iconPrefix: Icon(AppIcons.lock),
              labelText: 'Nhập lại mật khẩu',
              validator: (v) {
                if (controller.passwordSignUpEditCtrl.text !=
                    controller.confirmPasswordSignUpEditCtrl.text) {
                  return "Mật khẩu không khớp";
                } else
                  return null;
              },
              obscureText: true,
              color: AppColors.colorDark,
              onChanged: (value) => null,
            ),
          ],
        ),
      ),
    );
  }

  Widget renderButton() {
    return Column(
      children: [
        PrimaryButton(
          labelText: "Đăng ký",
          fontSizeText: 16.sp,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              controller.signUp();
            }
          },
          // width: 135.w,
          padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 15),
        ),
        SizedBox(height: largePadding),
        RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Text(
                  "Bạn đã có tài khoản? ",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ), //Đăng ký ngay
              WidgetSpan(
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Text(
                    "Đăng nhập ngay",
                    style: TextStyle(
                      fontSize: 14.sp,
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
    );
  }
}
