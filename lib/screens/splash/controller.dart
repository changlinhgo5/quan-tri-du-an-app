import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ielts/base/index.dart';
import 'package:ielts/index.dart';
import 'dart:isolate';

class SplashController extends BaseController {
  final store = PreferenceImpl();
  RxDouble positionedImage = (0.0).obs;
  RxDouble opacityImage = (0.0).obs;

  RxBool isVisible = true.obs;
  RxBool showShadowShape = false.obs;
  moveImage() {
    isVisible.value = !isVisible.value;
    positionedImage.value = 300;
    opacityImage.value = 1;
  }

  enableShadow() {
    showShadowShape.value = true;
  }

  Future<bool> checkLogin() async {
    if (GetPlatform.isAndroid) {}
    String user = await store.readStore(key: PreferenceManager.user) ?? "";
    if (user.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> nextRoute() async {
    bool successLogin = await checkLogin();
    if (successLogin) {
      return RouterNames.HOME;
    }
    return RouterNames.SIGN_IN;
  }

  onEndAnimation() async {
    enableShadow();
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  void onReady() async {
    if (Configs.isToeicApp) {
      moveImage();
    } else {
      Future.delayed(const Duration(seconds: 1), () async {
        String nextRouter = await nextRoute();
        Get.offAllNamed(nextRouter.toString());
      });
    }
    super.onReady();
  }
}
