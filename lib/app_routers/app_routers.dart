import 'package:get/get.dart';
import 'package:ielts/screens/home/bindings.dart';
import 'package:ielts/screens/home/view.dart';
import 'package:ielts/screens/project/bindings.dart';
import 'package:ielts/screens/project/view.dart';
import 'package:ielts/screens/sign_in/bindings.dart';
import 'package:ielts/screens/sign_in/view.dart';
import 'package:ielts/screens/splash/bindings.dart';
import 'package:ielts/screens/splash/view.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    GetPage(
      name: RouterNames.HOME,
      binding: HomeBindings(),
      page: () => HomeUi(),
    ),
    GetPage(
      name: RouterNames.SIGN_IN,
      binding: SignBindings(),
      page: () => SignInUI(),
    ),
    GetPage(
      name: RouterNames.SPLASH,
      binding: SplashBindings(),
      page: () => SplashUI(),
    ),
    GetPage(
      name: RouterNames.RPOJECT,
      binding: ProjectBindings(),
      page: () => PorjectUI(),
    ),
  ];
}

class RouterNames {
  RouterNames._();
  static const SFLASH = '/';
  static const SIGN_IN = '/sign_in';
  static const HOME = '/home';
  static const SPLASH = '/splash';
  static const RPOJECT = '/project';
}
