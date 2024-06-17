import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ielts/index.dart';

typedef OnTabChange(int tab);

class TabPageCustom extends StatefulWidget {
  List<String> titleTabs;
  EdgeInsets padding;
  List<Widget> viewTabBars;
  double? width;
  bool scaleWidgetTabWithTitleLength;
  OnTabChange? onTabChange;
  TabPageCustom({
    required this.titleTabs,
    required this.viewTabBars,
    this.onTabChange,
    this.width,
    this.padding = EdgeInsets.zero,
    this.scaleWidgetTabWithTitleLength = true,
  });

  @override
  State<TabPageCustom> createState() => _TabPageCustomState();
}

class _TabPageCustomState extends State<TabPageCustom> with TickerProviderStateMixin {
  late TabController tabController;
  double get width => widget.width ?? Get.width;
  CustomSegmentedController<int> customSegmentedController = CustomSegmentedController();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.titleTabs.length,
      child: Container(
        // padding: padding,
        child: Column(
          children: [
            renderTabBar(),
            SizedBox(height: padding12),
            renderTabBarView(),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    tabController = TabController(length: widget.titleTabs.length, vsync: this);
    // tabController.addListener(() {
    //   customSegmentedController.value = tabController.index + 1;
    //   setState(() {});
    // });
    super.initState();
  }

  Widget renderTabBar() {
    Map<int, Widget> title = {};
    int i = 1;
    widget.titleTabs.forEach((element) {
      title.putIfAbsent(
        i,
        () => Container(
          constraints: BoxConstraints(minWidth: 0, maxWidth: width / (widget.titleTabs.length) - 20),
          child: Text(
            element,
            maxLines: 1,
            style: TextStyle(
              color: i == tabController.index + 1 || i == customSegmentedController.value ? Colors.white : Colors.black,
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
      i++;
    });
    return CustomSlidingSegmentedControl<int>(
      controller: customSegmentedController,
      // fromMax: true,
      fixedWidth: widget.scaleWidgetTabWithTitleLength ? Get.width / widget.titleTabs.length - 20 : null,
      initialValue: 1,
      children: title,
      padding: 20,
      innerPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      decoration: BoxDecoration(color: Get.theme.cardColor, borderRadius: BorderRadius.circular(50.r), boxShadow: [
        BoxShadow(
          offset: Offset(0, 4),
          blurRadius: 10,
          spreadRadius: 0,
          color: Color(0xff6F87C3).withOpacity(0.2),
        ),
      ]),
      thumbDecoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xff1981FC), Color(0xff5A6AF9)]),
        borderRadius: BorderRadius.circular(50.r),
        boxShadow: [
          BoxShadow(
            color: Color(0xff359EFF).withOpacity(0.5),
            blurRadius: 10.0,
            spreadRadius: 0,
            offset: const Offset(0.0, 2.0),
          ),
        ],
      ),
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInToLinear,
      onValueChanged: (v) {
        tabController.animateTo(v - 1);
        if (widget.onTabChange != null) widget.onTabChange!(v - 1);
        setState(() {});
      },
    );
  }

  Widget renderTabBarView() {
    return Expanded(
      child: IndexedStack(
        index: customSegmentedController.value != null
            ? customSegmentedController.value! - 1
            : 0, // Biến _currentIndex là chỉ số tab hiện tại
        children: List.generate(
          widget.viewTabBars.length,
          (index) => widget.viewTabBars[index],
        ),
      ),
    );
    // return Expanded(
    //   child: TabBarView(
    //     physics: NeverScrollableScrollPhysics(),
    //     // controller: tabController,
    //     children: List.generate(
    //       widget.viewTabBars.length,
    //       (index) => widget.viewTabBars[index],
    //     ),
    //   ),
    // );
  }
}
