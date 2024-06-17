import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:ielts/index.dart';
import 'package:ielts/screens/sign_in/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ielts/widget/image_cache.dart';
import 'package:ielts/widget/index.dart';
import 'package:get/get.dart';

class DrawerApp extends StatelessWidget {
  DrawerApp({Key? key}) : super(key: key);

  var signCtrl = Get.find<SignInController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ClipRRect(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(50),
        ),
        child: Container(
            width: Get.width * 0.9,
            decoration: const BoxDecoration(color: Color(0xffF5F7FC)),
            child: Column(
              children: [
                Expanded(
                    child: signCtrl.user.value != null
                        ? Column(
                            children: [
                              SizedBox(height: 24.h),
                              Container(
                                padding:
                                    EdgeInsets.symmetric(horizontal: padding),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          signCtrl.user.value?.name ?? "",
                                          style: TextStyle(
                                            fontSize: 24.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        // Text(signCtrl.user.value?.account)
                                      ],
                                    ),
                                    signCtrl.user.value!.avatar.isNotEmpty
                                        ? ImageCustom(
                                            url: signCtrl.user.value!.avatar,
                                            width: 60,
                                          )
                                        : Image(
                                            width: 60,
                                            image: AssetImage(
                                              AppImages.iconAvatarDefault,
                                            ),
                                          )
                                  ],
                                ),
                              ),
                              SizedBox(height: 12.h),
                              Divider(
                                thickness: 2.5,
                              ),
                              if (Get.isRegistered<HomeController>())
                                GetX<HomeController>(
                                  builder: (controller) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(left: 16.w),
                                          child: Text(
                                            "Dự án",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          children: List.generate(
                                            controller.projects.length,
                                            (index) {
                                              return itemOption(
                                                title: controller
                                                    .projects[index].name,
                                                onTap: () {
                                                  Get.toNamed(
                                                      RouterNames.RPOJECT,
                                                      arguments: {
                                                        "projectId": controller
                                                            .projects[index]
                                                            .projectId,
                                                      });
                                                },
                                                showDevide: false,
                                                icon: Container(
                                                  width: 6,
                                                  height: 6,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: AppColors
                                                          .colorProgress),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              Divider(
                                thickness: 2.5,
                              ),
                              SizedBox(height: 40),
                              itemOption(
                                title: "Đăng xuất",
                                onTap: () {
                                  signCtrl.logout();
                                },
                                showDevide: false,
                                icon: Icon(
                                  AppIcons.logout,
                                  size: 20,
                                  // color: AppColors.colorPrimaryApp,
                                ),
                              ),
                            ],
                          )
                        : Container()),
                Column(
                  children: [
                    Text(
                      Configs.appNameHiHi,
                      style: TextStyle(fontSize: 13.sp),
                    ),
                    Text(
                      Configs.verApp,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Color(0xff717070),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
              ],
            )),
      );
    });
  }

  Widget itemOption(
      {required String title,
      required Widget icon,
      Function? onTap,
      bool showDevide = true}) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            if (onTap != null) onTap();
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 20.w),
            child: Row(
              children: [
                icon,
                SizedBox(width: 26.h),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      // color: AppColors.black0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (showDevide)
          const Divider(
            thickness: 1,
            // color: AppColors.black0.withOpacity(0.12),
            height: 1,
          ),
      ],
    );
  }
}
