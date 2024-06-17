import 'dart:ffi';
import 'dart:typed_data';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ielts/base/index.dart';
import 'package:ielts/index.dart';
import 'package:ielts/models/project.dart';
import 'package:ielts/screens/home/home_toeic_ui.dart';
import 'package:ielts/screens/sign_in/index.dart';
import 'package:ielts/values/app_images.dart';
import 'package:ielts/widget/custom_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ielts/widget/info_item.dart';
import 'package:ielts/widget/progress.dart';
import 'package:ielts/widget/progress_info_item.dart';

class HomeUi extends BaseView<HomeController> {
  SignInController signCtrl = Get.find();
  @override
  Widget body(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: signCtrl.user.value != null
          ? Column(
              children: [
                _renderUserInfo(),
                SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: _renderStatistical(),
                ),
              ],
            )
          : Container(),
    );
  }

  Widget _renderUserInfo() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoItem(user: signCtrl.user.value!),
            Divider(
              thickness: 2,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dự án",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                _renderPoject(),
                SizedBox(height: 22),
                Obx(
                  () => ProgressInfoItem(
                    title: "Tỷ lệ hoàn thành",
                    image: AppImages.cup,
                    progress: controller.pecentCompleteTask.value,
                    colorProgress: AppColors.colorSuccess,
                  ),
                ),
                SizedBox(height: 16),
                ProgressInfoItem(
                  title: "Kỉ luật",
                  image: AppImages.iconMemory,
                  progress: 1,
                  colorProgress: Colors.amber,
                ),
              ],
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _renderStatistical() {
    return Obx(
      () {
        if (controller.spSelected.value == null) return Container();
        return Card(
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Thống kê cá nhân",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 16),
                ProgressIndicatorApp(
                  progress: ((DateTime.now().millisecondsSinceEpoch -
                              controller.spSelected.value!.startDate) /
                          (controller.spSelected.value!.endDate -
                              controller.spSelected.value!.startDate))
                      .toPrecision(2),
                  name: controller.spSelected.value!.name,
                  timeRemain: Row(
                    children: [
                      const Icon(
                        Icons.timer,
                        size: 16,
                        color: AppColors.colorPrimaryApp,
                      ),
                      SizedBox(width: 4),
                      Text(
                        ((controller.spSelected.value!.endDate -
                                        DateTime.now().millisecondsSinceEpoch) /
                                    3600000)
                                .toInt()
                                .toString() +
                            "h",
                      ),
                    ],
                  ),
                  showSuffixProgress: true,
                ),
                Divider(
                  thickness: 2,
                ),
                Column(
                  children: [
                    SizedBox(height: 16),
                    ProgressInfoItem(
                      title: "Điểm kinh nghiệm theo spint",
                      image: AppImages.iconMemory,
                      progress: 1,
                      colorProgress: Colors.amber,
                    ),
                  ],
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _renderPoject() {
    return Obx(
      () {
        if (controller.pjSelected.value == null) return Container();
        return DropdownButtonHideUnderline(
          child: DropdownButton2<Project>(
            isExpanded: true,
            hint: const Row(
              children: [
                Icon(
                  Icons.list,
                  size: 16,
                  color: Colors.yellow,
                ),
                SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Text(
                    'Select Item',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            items: controller.projects
                .map((Project item) => DropdownMenuItem<Project>(
                      value: item,
                      child: Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList(),
            value: controller.pjSelected.value!,
            onChanged: (value) {
              controller.changePJSelected(value);
            },
            buttonStyleData: ButtonStyleData(
              height: 50,
              // width: 160,
              padding: const EdgeInsets.only(left: 14, right: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: AppColors.colorPrimaryApp,
              ),
              elevation: 2,
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.arrow_circle_down_outlined,
              ),
              iconSize: 14,
              iconEnabledColor: Colors.white,
              iconDisabledColor: Colors.grey,
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 200,
              // width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: AppColors.colorPrimaryApp,
              ),
              // offset: const Offset(-20, 0),
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(40),
                thickness: MaterialStateProperty.all(6),
                thumbVisibility: MaterialStateProperty.all(true),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
              padding: EdgeInsets.only(left: 14, right: 14),
            ),
          ),
        );
      },
    );
  }

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return CustomAppBar(
      // leading: Icon(
      //   AppIcons.menu,
      //   size: 12,
      // ),
      showBackScreen: false,
    );
  }
}
