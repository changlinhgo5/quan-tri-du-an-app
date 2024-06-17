import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:ielts/base/index.dart';
import 'package:ielts/models/project.dart';
import 'package:ielts/models/sprint_point.dart';
import 'package:ielts/models/task.dart';
import 'package:ielts/screens/sign_in/controller.dart';
import 'package:ielts/screens/sign_in/index.dart';
import '../../index.dart';
import 'dart:io' show Platform;

class HomeController extends BaseController {
  SignInController signInCtrl = Get.find();
  ServerRepository serverRepo = ServerRepository();

  Rxn<SprintPoint> spSelected = Rxn<SprintPoint>();
  Rxn<Project> pjSelected = Rxn<Project>();

  // RxList<SprintPoint> sprintPoints = <SprintPoint>[].obs;
  RxList<Project> projects = <Project>[].obs;
  RxList<Task> tasks = <Task>[].obs;
  RxDouble pecentCompleteTask = (0.0).obs;
  Future getSprintPoint() async {
    var getSprintPoint =
        serverRepo.getSprintPoint(signInCtrl.user.value!.accessToken);
    await callDataService(
      getSprintPoint,
      onSuccess: (response) async {
        var data = response as List<SprintPoint>;

        spSelected.value = data.firstWhere(
          (element) =>
              element.startDate < DateTime.now().millisecondsSinceEpoch &&
              element.endDate > DateTime.now().millisecondsSinceEpoch,
        );
        print(spSelected.value.toString() + "-=====");
      },
    );
  }

  Future getUserProject() async {
    var getProjects =
        serverRepo.getProjects(signInCtrl.user.value!.accessToken);
    await callDataService(
      getProjects,
      onSuccess: (response) async {
        projects.value = response as List<Project>;
        if (projects.isNotEmpty) {
          pjSelected.value = projects.first;
        }
      },
    );
  }

  Future getTask() async {
    var getTaskx = serverRepo.getTasks(
      signInCtrl.user.value!.accessToken,
      from: spSelected.value!.startDate,
      to: spSelected.value!.endDate,
      userId: signInCtrl.user.value!.id,
      project_ids: pjSelected.value!.projectId,
    );

    await callDataService(
      getTaskx,
      onSuccess: (response) async {
        tasks.value = response as List<Task>;
        int total = caculateTotalTask() == 0 ? 1 : caculateTotalTask();
        int countComplete = 0;
        tasks.forEach(
          (element) {
            if (element.status == Configs.completeTask) {
              countComplete++;
            }
          },
        );
        pecentCompleteTask.value = (countComplete / total).toPrecision(2);
        print(
            "pecentCompleteTask $pecentCompleteTask  countComplete $countComplete  total $total");
      },
    );
  }

  int caculateTotalTask() {
    int total = 0;
    tasks.forEach(
      (element) {
        if (element.status != Configs.openTask) {
          total++;
        }
      },
    );
    return total;
  }

  @override
  void onReady() async {
    // TODO: implement onReady
    print("xxxxx ${signInCtrl.user.value!}");
    await getSprintPoint();
    await getUserProject();
    await getTask();
    super.onReady();
  }

  void changePJSelected(Project? value) {
    pjSelected.value = value;
    getTask();
  }
}
