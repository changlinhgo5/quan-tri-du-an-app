// --no-tree-shake-icons

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ielts/screens/main/bindings.dart';
import 'package:ielts/screens/main/main_view.dart';

import 'utils/index.dart';
import 'package:flutter/services.dart';

String courseSelectedApp = "";

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

//init controller
  await GetStorage.init();
  MainBindings().dependencies();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  ).then((_) async {
    runApp(MainView());
  });
}
