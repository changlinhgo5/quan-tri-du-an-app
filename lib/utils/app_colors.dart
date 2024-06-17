// import 'package:flutter/material.dart';

// abstract class AppColors {
//   static const Color colorPrimaryApp = Color(0xffE30224);
//   static const Color colorPrimaryApp2 = Color(0xff0285FE);

//   static const Color colorActive = Color(0xff3F7AD9);
//   static const Color colorInActive = Color(0xffB3B3B4);
//   static const Color colorCardPrimary = Color(0xffD3E7FF);
//   static const Color colorBoldCardPrimary = Color(0xff3F7AD9);
//   static const Color colorTextPrimay = Color(0xff0285FE);
//   static const Color pageBackground = Color(0xFFFAFBFD);
//   static const Color colorSuccess = Color(0xff26AB5E);

//   static const Color colorIconPrimary = Color(0xff0285FE);
//   static const Color colorProgress = Color(0xff0285FE);
//   static const List<Color> colorsProgress = [
//     Color(0xffFF9F47),
//     Color(0xffFF698D),
//   ];

//   static const Color colorPrimaryDarkMode = Color(0xff354E70);
//   static const Color backgroundItemDarkMode = Color(0xff354E70);
//   static const List<Color> colorsProgressDarkMode = [
//     Colors.white,
//     Colors.white,
//   ];
//   static Color shadowColor = const Color(0xff6F87C3).withOpacity(0.25);
//   static const List<Color> colorGradientBackgroundScreen = [
//     Color(0xffE5FFFF),
//     Color(0xffF5F6F9),
//     Color(0xffF6F7FB),
//     Color(0xffEFF5FD),
//     Color(0xffFFF3FC),
//   ];

//   static const Color centerTextColor = Colors.grey;
//   static const MaterialColor colorPrimarySwatch = Colors.cyan;
//   static const Color colorAccent = Color(0xFF38686A);
//   static const Color colorLightGreen = Color(0xFF00EFA7);
//   static const Color colorWhite = Color(0xFFFFFFFF);
//   static const Color lightGreyColor = Color(0xFFC4C4C4);
//   static const Color errorColor = Color(0xFFFD0202);
//   static const Color colorDark = Color(0xFF323232);

//   static const Color buttonBgColor = colorPrimaryApp;
//   static const Color disabledButtonBgColor = Color(0xFFBFBFC0);
//   static const Color defaultRippleColor = Color(0x0338686A);

//   static const Color textColorPrimary = Color(0xFF323232);
//   static const Color textColorSecondary = Color(0xFF9FA4B0);
//   static const Color textColorTag = colorPrimaryApp;
//   static const Color textColorGreyLight = Color(0xFFABABAB);
//   static const Color textColorGreyDark = Color(0xFF979797);
//   static const Color textColorBlueGreyDark = Color(0xFF939699);
//   static const Color textColorCyan = Color(0xFF38686A);
//   static const Color textColorWhite = Color(0xFFFFFFFF);
//   static Color searchFieldTextColor = const Color(0xFF323232).withOpacity(0.5);

//   static const Color iconColorDefault = Colors.grey;

//   static Color barrierColor = const Color(0xFF000000).withOpacity(0.5);

//   static Color timelineDividerColor = const Color(0x5438686A);

//   static Color borderColor = Color(0x52ADADAD);

//   static const Color gradientStartColor = Colors.black87;
//   static const Color gradientEndColor = Colors.transparent;
//   static const Color silverAppBarOverlayColor = Color(0x80323232);

//   static const Color switchActiveColor = colorPrimaryApp;
//   static const Color switchInactiveColor = Color(0xFFABABAB);
//   static Color elevatedContainerColorOpacity = Colors.grey.withOpacity(0.5);
//   static const Color suffixImageColor = Colors.grey;

//   static LinearGradient gradientColor(List<Color> colors, {bool vertical = false}) {
//     return LinearGradient(
//       begin: vertical ? Alignment.topCenter : Alignment.centerLeft,
//       end: vertical ? Alignment.bottomCenter : Alignment.centerRight,
//       // Add one stop for each color. Stops should increase from 0 to 1
//       // stops: [0.1, 0.4, 0.7, 1.0],
//       colors: colors,
//     );
//   }

//   //blue
//   static const Color blue = Color.fromRGBO(29, 161, 242, 1);
//   static const Color blue0 = Color.fromRGBO(44, 225, 193, 1);
//   static const Color blue4 = Color.fromRGBO(45, 194, 124, 1);
//   static const Color blue1 = Color.fromRGBO(35, 202, 239, 1);
//   static const Color blue2 = Color.fromRGBO(131, 169, 191, 1);
//   static const Color blue3 = Color.fromRGBO(238, 242, 252, 1);
//   static const Color blue5 = Color.fromRGBO(0, 182, 218, 1);
//   static const Color blue6 = Color.fromRGBO(139, 235, 253, 0.2);
//   static const Color blue7 = Color.fromRGBO(0, 142, 170, 1);

//   //red
//   static const Color red = Color.fromRGBO(191, 29, 45, 1);
//   static const Color red0 = Color.fromRGBO(248, 105, 182, 1);
//   static const Color red1 = Color.fromRGBO(255, 148, 140, 1);
//   static const Color red2 = Color.fromRGBO(255, 84, 84, 1);
//   //pink
//   static const Color pink = Color.fromRGBO(255, 99, 192, 1);
//   //green
//   static const Color green = Color.fromRGBO(186, 215, 97, 1);
//   static const Color green0 = Color.fromRGBO(128, 183, 38, 1);
//   static const Color green1 = Color.fromRGBO(169, 221, 84, 1);
//   static const Color green3 = Color.fromRGBO(193, 218, 58, 1);
//   static const Color green2 = Color.fromRGBO(154, 178, 175, 1);
//   static const Color green4 = Color.fromRGBO(172, 194, 94, 1);
//   static const Color green5 = Color.fromRGBO(130, 188, 36, 1);

//   //black
//   static const Color black = Color.fromRGBO(135, 135, 135, 1);
//   static const Color black0 = Color.fromRGBO(41, 49, 58, 1);
//   static const Color black1 = Color.fromRGBO(238, 242, 252, 1);
//   static const Color black2 = Color.fromRGBO(131, 169, 191, 0.14);
//   static const Color black3 = Color.fromRGBO(182, 207, 221, 1);
//   static const Color black4 = Color.fromRGBO(41, 49, 58, 1);

//   //white
//   static const Color white0 = Color.fromRGBO(247, 249, 252, 1);
//   static const Color white1 = Color.fromRGBO(255, 255, 255, 1);
//   static const Color white2 = Color.fromRGBO(244, 247, 253, 1);

// //yellow
//   static const Color yellow0 = Color.fromRGBO(255, 201, 163, 1);
//   static const Color yellow1 = Color.fromRGBO(255, 212, 82, 1);
//   static const Color yellow2 = Color.fromRGBO(255, 201, 63, 1);
//   static const Color yellow3 = Color.fromRGBO(245, 202, 115, 1);
//   static const Color yellow4 = Color.fromRGBO(255, 208, 86, 1);
//   static const Color yellow5 = Color.fromRGBO(255, 160, 17, 1);

//   static const Color yellow6 = Color.fromRGBO(255, 146, 99, 1);
//   static const Color yellow7 = Color.fromRGBO(253, 96, 58, 1);
// }


// // abstract class AppColors {
// //   static const Color colorPrimaryApp = Color(0xffE30224);
// //   static const Color colorPrimaryApp2 = Color(0xff0285FE);

// //   static const Color colorActive = Color(0xff3F7AD9);
// //   static const Color colorInActive = Color(0xffB3B3B4);
// //   static const Color colorCardPrimary = Color(0xffD3E7FF);
// //   static const Color colorBoldCardPrimary = Color(0xff3F7AD9);
// //   static const Color colorTextPrimay = Color(0xff0285FE);
// //   static const Color pageBackground = Color(0xFFFAFBFD);
// //   static const Color colorSuccess = Color(0xff26AB5E);

// //   static Color shadowColor = const Color(0xff6F87C3).withOpacity(0.25);
// //   static const List<Color> colorGradientBackgroundScreen = [
// //     Color(0xffE5FFFF),
// //     Color(0xffF5F6F9),
// //     Color(0xffF6F7FB),
// //     Color(0xffEFF5FD),
// //     Color(0xffFFF3FC),
// //   ];

// //   static const Color centerTextColor = Colors.grey;
// //   static const MaterialColor colorPrimarySwatch = Colors.cyan;
// //   static const Color colorAccent = Color(0xFF38686A);
// //   static const Color colorLightGreen = Color(0xFF00EFA7);
// //   static const Color colorWhite = Color(0xFFFFFFFF);
// //   static const Color lightGreyColor = Color(0xFFC4C4C4);
// //   static const Color errorColor = Color(0xFFFD0202);
// //   static const Color colorDark = Color(0xFF323232);

// //   static const Color buttonBgColor = colorPrimaryApp;
// //   static const Color disabledButtonBgColor = Color(0xFFBFBFC0);
// //   static const Color defaultRippleColor = Color(0x0338686A);

// //   static const Color textColorPrimary = Color(0xFF323232);
// //   static const Color textColorSecondary = Color(0xFF9FA4B0);
// //   static const Color textColorTag = colorPrimaryApp;
// //   static const Color textColorGreyLight = Color(0xFFABABAB);
// //   static const Color textColorGreyDark = Color(0xFF979797);
// //   static const Color textColorBlueGreyDark = Color(0xFF939699);
// //   static const Color textColorCyan = Color(0xFF38686A);
// //   static const Color textColorWhite = Color(0xFFFFFFFF);
// //   static Color searchFieldTextColor = const Color(0xFF323232).withOpacity(0.5);

// //   static const Color iconColorDefault = Colors.grey;

// //   static Color barrierColor = const Color(0xFF000000).withOpacity(0.5);

// //   static Color timelineDividerColor = const Color(0x5438686A);

// //   static Color borderColor = Color(0x52ADADAD);

// //   static const Color gradientStartColor = Colors.black87;
// //   static const Color gradientEndColor = Colors.transparent;
// //   static const Color silverAppBarOverlayColor = Color(0x80323232);

// //   static const Color switchActiveColor = colorPrimaryApp;
// //   static const Color switchInactiveColor = Color(0xFFABABAB);
// //   static Color elevatedContainerColorOpacity = Colors.grey.withOpacity(0.5);
// //   static const Color suffixImageColor = Colors.grey;
// // }
