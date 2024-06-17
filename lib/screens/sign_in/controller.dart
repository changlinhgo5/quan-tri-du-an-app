import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ielts/base/index.dart';
import 'package:ielts/index.dart';
import 'package:ielts/widget/index.dart';

import '../../models/user.dart';

class SignInController extends BaseController {
  //signin
  TextEditingController userNameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  //sign up
  TextEditingController accountEditCtrl = TextEditingController();
  TextEditingController emailEditCtrl = TextEditingController();
  TextEditingController displayNameEditCtrl = TextEditingController();
  TextEditingController passwordSignUpEditCtrl = TextEditingController();
  TextEditingController confirmPasswordSignUpEditCtrl = TextEditingController();
  TextEditingController phoneNumberEditCtrl = TextEditingController();

  ServerRepository serverRepo = ServerRepository();
  bool handleLogin = false;
  final store = PreferenceImpl();

  Rxn<User> user = Rxn<User>();
  User? get userInfo => user.value;
  String getaccessToken() {
    if (user.value != null) return user.value!.accessToken;
    print("Session Id empty");
    return "";
  }

  Future signInWithAccount() async {
    handleLogin = true;
    var loginService = serverRepo.loginAccount(
        userNameCtrl.text.trim(), passwordCtrl.text.trim());
    callDataService(
      loginService,
      onSuccess: (response) async {
        User userLogin = response as User;
        user.value = userLogin;
        ClientData.user = userLogin;
        if (user.value != null) {
          await store.writeStore(
              key: PreferenceManager.user, value: user.value!);
          userNameCtrl.clear();
          passwordCtrl.clear();
          Get.offAndToNamed(RouterNames.HOME);
        } else {}
      },
    );
  }

  // Future<bool> signInWithToken() async {
  //   bool check = false;
  //   String? user =
  //       await store.readStore(key: PreferenceManager.user);
  //   if (accessToken != null && accessToken.isNotEmpty) {
  //     var loginService = serverRepo.loginWithaccessToken(accessToken);
  //     await callDataService(
  //       loginService,
  //       onSuccess: (response) async {
  //         User userLogin = response as User;
  //         user.value = userLogin;
  //         ClientData.user = userLogin;

  //         if (userLogin.accessToken.isNotEmpty) {
  //           await store.writeStore(
  //               key: PreferenceManager.accessToken,
  //               value: user.value!.accessToken);
  //         } else {
  //           user.value!.accessToken = accessToken ?? "";
  //         }
  //         check = true;
  //         // Get.offAndToNamed(RouterNames.HOME);
  //       },
  //     );
  //   }
  //   return check;
  // }

  Future getUserLocal() async {
    String? userlocal = await store.readStore(key: PreferenceManager.user);

    if (userlocal != null) {
      user.value = User.fromMap(jsonDecode(userlocal));
      print(user.value!.name.toString() + " pp");
    }
  }

  @override
  void onReady() {
    // signInWithToken();
    getUserLocal();
    super.onReady();
  }

  void logout() async {
    user.value = null;
    await store.remove(PreferenceManager.user);
    Get.offAllNamed(RouterNames.SIGN_IN);
  }

  void signUp() {
    var signUpHandle = serverRepo.signUpAccount(
      account: accountEditCtrl.text.trim(),
      password: passwordSignUpEditCtrl.text.trim(),
      name: displayNameEditCtrl.text.trim(),
      email: emailEditCtrl.text.trim(),
      phone: phoneNumberEditCtrl.text.trim(),
      province: "",
    );
    callDataService(
      signUpHandle,
      onSuccess: (response) async {
        User userLogin = response as User;
        print(userLogin.toJson() + "dsds");
        if (userLogin != null) {
          Get.dialog(
            DialogApp(
              titleCofirm: "OK",
              description: "Tạo tài khoản thành công",
              onConfirm: () {
                accountEditCtrl.text = "";
                emailEditCtrl.text = "";
                displayNameEditCtrl.text = "";
                phoneNumberEditCtrl.text = "";
                passwordSignUpEditCtrl.text = "";
                confirmPasswordSignUpEditCtrl.text = "";
                Get.back();
                Get.back();
                // if (Configs.isOpenHomeScreenAfterLogin) {
                //   Get.offAndToNamed(RouterNames.HOME);
                // } else {
                //   Get.offAllNamed(RouterNames.LEVEL_SKILL);
                // }
              },
            ),
          );
        } else {}
      },
    );
  }
}

class SignUp {}
