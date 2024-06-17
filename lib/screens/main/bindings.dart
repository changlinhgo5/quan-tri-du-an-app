import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ielts/index.dart';
import '../sign_in/index.dart';

class MainBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(
      SignInController(),
      permanent: true,
    );

    Get.lazyPut(
      () => ThemeController(),
      fenix: true,
    );
    Get.lazyPut(
      () => LanguageController(),
      fenix: true,
    );
    // if (GetPlatform.isIOS) Get.put(SpeechToTextCheckDocController());
  }
}
