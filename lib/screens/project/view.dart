import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/preferred_size.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ielts/base/base_view.dart';
import 'package:ielts/index.dart';
import 'package:ielts/models/sprint_point.dart';
import 'package:ielts/models/task.dart';
import 'package:ielts/screens/project/controller.dart';
import 'package:ielts/utils/client_utils.dart';
import 'package:ielts/widget/custom_app_bar.dart';

class PorjectUI extends BaseView<ProjectController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return CustomAppBar(
      showBackScreen: true,
      appBarTitleText: "Project",
      // appBarTitleWidget: Text("fdf"),
    );
  }

  @override
  Widget body(BuildContext context) {
    bodies = [
      taskUI(context),
      memberUI(),
    ];
    return Obx(
      () {
        return Scaffold(
          bottomNavigationBar: ConvexAppBar(
            color: Colors.white,
            elevation: 8,
            items: [
              TabItem(icon: Icons.task, title: 'Tasks'),
              TabItem(icon: Icons.group_outlined, title: 'Members'),
            ],
            onTap: (int i) {
              controller.tabSelected.value = i;
            },
          ),
          body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: AppColors.colorGradientBackgroundScreen,
                ),
              ),
              child: bodies[controller.tabSelected.value]),
        );
      },
    );
  }

  late List<Widget> bodies;

  Widget memberUI() {
    return Obx(
      () {
        return ListView.builder(
          itemCount: controller.userDetails.value.length,
          itemBuilder: (context, index) {
            var image;
            if (controller.userDetails[index].avatar.isNotEmpty) {
              image = NetworkImage(controller.userDetails[index].avatar);
            } else {
              image = AssetImage(
                AppImages.iconAvatarDefault,
              );
            }
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              padding: EdgeInsets.symmetric(horizontal: 22, vertical: 12),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 0,
                        blurRadius: 10,
                        offset: Offset(0, 2),
                        color: Colors.black12.withOpacity(
                          0.2,
                        ))
                  ]),
              child: Row(
                children: [
                  CircleAvatar(radius: 20, backgroundImage: image),
                  SizedBox(width: 22),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Họ tên :    ",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(controller.userDetails[index].name),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Email :    ",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 160,
                            child: Text(
                              controller.userDetails[index].email,
                              maxLines: 1,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget taskUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _renderSpirnt(context),
          _renderTask(),
          SizedBox(height: 120),
        ],
      ),
    );
  }

  Widget _renderSpirnt(BuildContext context) {
    return Obx(
      () {
        if (controller.sprints.value.isEmpty ||
            controller.spSelected.value == null) return Container();
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black12,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<SprintPoint>(
              isExpanded: true,
              hint: Text(
                'Select Item',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).hintColor,
                ),
              ),
              items: controller.sprints
                  .map(
                    (SprintPoint item) => DropdownMenuItem<SprintPoint>(
                      value: item,
                      child: _renderSprint(item),
                    ),
                  )
                  .toList(),
              value: controller.spSelected.value,
              onChanged: (value) {
                controller.changeSelectedSprint(value);
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 40,
                width: 140,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _renderSprint(SprintPoint sp) {
    IconData ic = Icons.timer;
    Color c = Colors.green;
    if (sp.isBacklog) {
      c = Colors.black;
      ic = Icons.ac_unit_rounded;
    } else {
      switch (sp.status) {
        case -1:
          c = Colors.red;
          ic = Icons.access_alarm;
          break;
        case 0:
          break;
        case 1:
          c = Colors.blue;
          ic = Icons.snowboarding;
          break;
        default:
      }
    }
    Icon icon = Icon(
      ic,
      color: c.withOpacity(0.7),
    );
    return Row(
      children: [
        icon,
        SizedBox(width: 6),
        Text(sp.name),
        SizedBox(width: 6),
        Container(
          width: 2,
          height: 20,
          color: Colors.black12,
        ),
        SizedBox(width: 6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.date_range,
              size: 20,
              color: AppColors.colorPrimaryApp,
            ),
            Text(
              ClientUltis.intToTime(sp.startDate),
              style: TextStyle(
                fontSize: 12,
                color: Colors.black45,
              ),
            ),
          ],
        ),
        Text(" - "),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.date_range,
              size: 20,
              color: AppColors.colorPrimaryApp,
            ),
            Text(
              ClientUltis.intToTime(sp.endDate),
              style: TextStyle(
                fontSize: 12,
                color: Colors.black45,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _renderTask() {
    return Obx(
      () {
        return itemTask();
      },
    );
  }

  Color xxx(int status) {
    switch (status) {
      case Configs.openTask:
        return Colors.grey;

      case Configs.inprogressTask:
        return Colors.amber;

      case Configs.reviewTask:
        return Colors.purple;

      case Configs.bugTask:
        return Colors.red;

      case Configs.completeTask:
        return Colors.green;

      case Configs.cacelTask:
        return Colors.black;

      default:
    }
    return Colors.grey;
  }

  List<int> statusTask = [
    Configs.openTask,
    Configs.inprogressTask,
    Configs.bugTask,
    Configs.reviewTask,
    Configs.completeTask,
    Configs.cacelTask,
  ];
  Widget itemTask() {
    Color color = Colors.green;
    String status = "";
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: List.generate(
          statusTask.length,
          (index) {
            List<Task> parentTask = [];
            List<Task> childTasks = [];

            switch (statusTask[index]) {
              case Configs.openTask:
                color = Colors.grey;
                status = "TODO";
                parentTask = controller.tasks.where(
                  (x) {
                    return x.status == Configs.openTask && x.parentTask == null;
                  },
                ).toList();
                break;
              case Configs.inprogressTask:
                color = Colors.amber;
                status = "Inprogress";
                parentTask = controller.tasks.where(
                  (x) {
                    return x.status == Configs.inprogressTask &&
                        x.parentTask == null;
                  },
                ).toList();
                break;
              case Configs.reviewTask:
                color = Colors.purple;
                status = "Review";

                parentTask = controller.tasks.where(
                  (x) {
                    return x.status == Configs.reviewTask &&
                        x.parentTask == null;
                  },
                ).toList();
                break;
              case Configs.bugTask:
                color = Colors.red;
                status = "Bug";
                parentTask = controller.tasks.where(
                  (x) {
                    return x.status == Configs.bugTask && x.parentTask == null;
                  },
                ).toList();
                break;

              case Configs.completeTask:
                color = Colors.green;
                status = "Complete";
                parentTask = controller.tasks.where(
                  (x) {
                    return x.status == Configs.completeTask &&
                        x.parentTask == null;
                  },
                ).toList();
                break;
              case Configs.cacelTask:
                color = Colors.black;
                parentTask = controller.tasks.where(
                  (x) {
                    print(x.status);
                    return x.status == Configs.cacelTask &&
                        x.parentTask == null;
                  },
                ).toList();
                status = "Cancel";
                break;
              default:
            }

            return Card(
              elevation: 10,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                          ),
                        ),
                        child: Text(
                          status,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.colorPrimaryApp,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: Text(
                          "${parentTask.length} task",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  if (parentTask.isNotEmpty) SizedBox(height: 12),
                  Column(
                    children: List.generate(
                      parentTask.length,
                      (index) {
                        return Column(
                          children: [
                            renderParentTask(
                                parentTask[index],
                                color,
                                controller.tasks
                                    .where(
                                      (x) =>
                                          x.parentTask != null &&
                                          x.parentTaskId ==
                                              parentTask[index].id,
                                    )
                                    .toList()),
                            Divider(),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget renderParentTask(Task t, Color color, List<Task> childTasks,
      {bool isChild = false}) {
    return ExpandablePanel(
      theme: ExpandableThemeData(
        hasIcon: childTasks.isNotEmpty,
      ),
      header: Container(
        margin: EdgeInsets.only(
          left: isChild ? 40 : 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (childTasks.isNotEmpty) Icon(Icons.arrow_forward),
            Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(child: Text(t.name)),
              ],
            ),
            SizedBox(height: 5),
            Text(
              "Deadline: ${ClientUltis.intToTime(t.deadline)}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
      expanded: Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          children: List.generate(
            childTasks.length,
            (x) {
              return Column(
                children: [
                  Divider(),
                  renderParentTask(childTasks[x], xxx(childTasks[x].status), [],
                      isChild: true)
                ],
              );
            },
          ),
        ),
      ),
      collapsed: Container(),
    );
  }
}
