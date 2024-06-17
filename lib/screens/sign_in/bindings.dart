import 'package:get/instance_manager.dart';
import 'package:ielts/screens/sign_in/controller.dart';
import 'package:ielts/widget/primary_input_filed.dart';

class SignBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SignInController(), permanent: true);
    Get.create<InputPrimaryController>(() => InputPrimaryController());
  }
}
