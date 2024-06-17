import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:ielts/base/base_contrller.dart';
import 'package:ielts/index.dart';
import 'package:ielts/models/sprint_point.dart';
import 'package:ielts/models/task.dart';
import 'package:ielts/models/user_detail.dart';
import 'package:ielts/screens/sign_in/controller.dart';

class ProjectController extends BaseController {
  SignInController signInCtrl = Get.find();
  HomeController homeCtrl = Get.find();
  RxInt tabSelected = 0.obs;
  Rxn<SprintPoint> spSelected = Rxn<SprintPoint>();

  RxList<SprintPoint> sprints = <SprintPoint>[].obs;

  RxList<Task> tasks = <Task>[].obs;
  RxList<UserDetail> userDetails = <UserDetail>[].obs;
  ServerRepository serverRepo = ServerRepository();
  Future getSprintPoint() async {
    var getSprint = serverRepo.getSprint(
        signInCtrl.user.value!.accessToken, Get.arguments['projectId']);
    await callDataService(
      getSprint,
      onSuccess: (response) async {
        sprints.value = (response as List<SprintPoint>)
          ..sort(
            (a, b) {
              return b.startDate.compareTo(a.startDate);
            },
          );
        if (sprints.isNotEmpty) spSelected.value = sprints.first;
      },
    );
  }

  Future getTask(String sprintId) async {
    var getTasksInProject = serverRepo.getTasksInProject(
      signInCtrl.user.value!.accessToken,
      sprintId: sprintId,
      projectId: Get.arguments['projectId'],
    );
    await callDataService(
      getTasksInProject,
      onSuccess: (response) async {
        tasks.value = response as List<Task>;
      },
    );
  }

  Future getUserDetail() async {
    var getTasksInProject = serverRepo.getUserDetails(
      signInCtrl.user.value!.accessToken,
      projectId: Get.arguments['projectId'],
    );
    await callDataService(
      getTasksInProject,
      onSuccess: (response) async {
        userDetails.value = response as List<UserDetail>;
      },
    );
  }

  @override
  void onReady() async {
    // TODO: implement onReady
    await getSprintPoint();
    if (spSelected.value != null) await getTask(spSelected.value!.id);
    await getUserDetail();
    super.onReady();
  }

  void changeSelectedSprint(SprintPoint? value) async {
    if (value != null) {
      spSelected.value = value;
      await getTask(spSelected.value!.id);
    }
  }
}
