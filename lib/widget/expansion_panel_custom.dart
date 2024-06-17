import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../index.dart';

class ExpansionPanelCustom extends StatelessWidget {
  Widget header, body;
  Function? onExpand;
  double borderRadius;
  bool hasShadow;
  bool enableExpand;
  BorderRadius? borderRadiusCustom;
  Color backgroundExpandColor;
  bool showIconArrow;
  ExpansionPanelCustom(
    this.header,
    this.body, {
    this.onExpand,
    this.borderRadius = 15,
    this.hasShadow = true,
    this.enableExpand = true,
    this.borderRadiusCustom,
    this.backgroundExpandColor = Colors.white,
    this.showIconArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return _buildPanel(context);
  }

  Widget _buildPanel(context) {
    return GetBuilder<ExpansionPanelController>(
      didChangeDependencies: (state) {
        if (onExpand != null)
          state.controller!.controller.addListener(() {
            // if (state.controller!.controller.value) {
            //   onExpand!();
            // }
            onExpand!();
          });
      },
      builder: (controller) {
        return AbsorbPointer(
          absorbing: !enableExpand,
          child: Container(
            decoration: BoxDecoration(
              borderRadius:
                  borderRadiusCustom ?? BorderRadius.circular(borderRadius),
              //color: enableExpand ? Get.theme.cardColor : Colors.black26.withOpacity(0.2),
              color: !controller.expand.value
                  ? Colors.white
                  : backgroundExpandColor,
              boxShadow: hasShadow
                  ? [
                      BoxShadow(
                        color: Get.theme.shadowColor.withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 10,
                        offset: Offset(0, 10),
                      )
                    ]
                  : null,
            ),
            child: ExpandablePanel(
              controller: controller.controller,
              header: header,
              collapsed: Container(),
              expanded: body,
              theme: ExpandableThemeData(
                hasIcon: showIconArrow,
                iconColor: Get.isDarkMode
                    ? Colors.white
                    : controller.expand.value
                        ? AppColors.colorPrimaryApp
                        : Colors.black,
              ),
            ),
          ),
        );
      },
    );
  }
}

class ExpansionPanelController extends GetxController {
  ExpandableController controller = ExpandableController();
  RxBool expand = false.obs;

  @override
  void onReady() {
    controller.addListener(() {
      changeExpand();
    });
    super.onReady();
  }

  void changeExpand() {
    expand.value = !expand.value;
    update();
  }
}
