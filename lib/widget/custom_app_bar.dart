import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ielts/index.dart';

//Default appbar customized with the design of our app
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? appBarTitleText;
  Widget? appBarTitleWidget;
  final List<Widget>? actions;
  final bool isBackButtonEnabled;
  final bool showBackScreen;
  final double elevation;
  final Color? backgroundColor;
  final Function? onBack;
  final Widget? leading;
  CustomAppBar(
      {Key? key,
      this.appBarTitleWidget,
      this.appBarTitleText,
      this.actions,
      this.isBackButtonEnabled = true,
      this.showBackScreen = true,
      this.elevation = 5,
      this.backgroundColor,
      this.onBack,
      this.leading})
      : super(key: key);

  @override
  Size get preferredSize => AppBar().preferredSize;
  var overlayStyle = SystemUiOverlayStyle.light; // 1

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      backgroundColor: AppColors.colorWhite,
      foregroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      centerTitle: false,
      elevation: elevation,
      shadowColor: Color.fromARGB(66, 240, 240, 240),
      automaticallyImplyLeading: false,
      actions: actions,
      titleSpacing: 0,
      title: Row(
        children: [
          leading == null
              ? showBackScreen
                  ? InkWell(
                      onTap: () {
                        if (onBack != null)
                          onBack!();
                        else
                          Get.back();
                      },
                      child: Container(
                        padding: EdgeInsets.all(6),
                        child: const Icon(
                          Icons.navigate_before,
                          color: Colors.black,
                          size: 34,
                        ),
                      ),
                    )
                  : InkWell(
                      highlightColor: Colors.transparent,
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: Container(
                        // padding: EdgeInsets.all(10),
                        margin: const EdgeInsets.only(left: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        width: 30.w,
                        height: 30.w,
                        child: const Icon(
                          AppIcons.menu,
                          size: 12,
                        ),
                      ),
                    )
              : Container(),
          const SizedBox(width: 10),
          appBarTitleWidget != null
              ? Expanded(child: appBarTitleWidget!)
              : Expanded(
                  child: appBarTitleText != null
                      ? Text(
                          appBarTitleText!,
                          style:
                              TextStyle(fontSize: 16.sp, color: Colors.black),
                          textAlign: TextAlign.start,
                        )
                      : Container(),
                ),
        ],
      ),
    );
  }
}
