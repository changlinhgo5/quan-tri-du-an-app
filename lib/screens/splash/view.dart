import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ielts/base/index.dart';
import 'package:ielts/index.dart';
import 'package:ielts/screens/splash/controller.dart';

class SplashUI extends BaseView<SplashController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget body(BuildContext context) {
    return renderIeltsSplash();
  }

  Widget renderToeicSplash() {
    return Scaffold(
      backgroundColor: AppColors.colorPrimaryApp,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            renderBooksImage(),
            Container(
              margin: EdgeInsets.only(top: 100.h, bottom: 50),
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Luyện Thi TOEIC",
                    style: TextStyle(
                      fontSize: 32.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "NÓI-VIẾT",
                    style: TextStyle(
                      fontSize: 34.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Học với niềm vui với chúng tôi, bất kể bạn ở đâu!",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget renderIeltsSplash() {
    return Container(
      height: Get.height,
      color: Colors.white,
      child: Stack(
        // alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            AppImages.splash,
            width: Get.width,
            // height: Get.height / 2,
            fit: BoxFit.fill,
          ),
          Center(child: CircularProgressIndicator()),
          Positioned(
            top: Get.height / 4,
            width: Get.width,
            child: Image(
              image: AssetImage(
                AppImages.logoInApp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget renderBooksImage() {
    return Container(
      height: 350,
      child: Obx(
        () => Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1000),
                boxShadow: controller.showShadowShape.value
                    ? [
                        const BoxShadow(
                          spreadRadius: 10,
                          blurRadius: 30,
                          color: const Color(0xffFFAD72),
                        ),
                      ]
                    : [],
              ),
              child: Image(
                width: 300,
                image: AssetImage(AppImages.pit),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 1300),
              bottom: controller.isVisible.value ? -300 : 0,
              onEnd: () {
                controller.onEndAnimation();
              },
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 2000),
                opacity: controller.opacityImage.value,
                child: Image(
                  // width: 200,
                  height: 300,
                  image: AssetImage(AppImages.books),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
