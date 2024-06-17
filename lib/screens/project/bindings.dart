import 'package:get/get.dart';
import 'package:ielts/screens/project/controller.dart';

class ProjectBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ProjectController());
  }
}
