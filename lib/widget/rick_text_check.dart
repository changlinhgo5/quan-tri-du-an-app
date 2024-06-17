import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ielts/utils/client_utils.dart';

import '../index.dart';
import '../values/app_colors.dart';

class RickTextCheck extends StatelessWidget {
  RickTextCheck({
    Key? key,
    required this.docData,
    required this.yourDoc,
    required this.percentPass,
    this.textAlign,
    this.isShowPercent = true,
  }) : super(key: key);
  List<String> docData;
  List<String> yourDoc;
  int percentPass;
  TextAlign? textAlign;
  bool isShowPercent;
  @override
  Widget build(BuildContext context) {
    // int percentPass = ClientUltis.percentCompareDocs(doc1: docData, doc2: yourDoc);
    return Row(
      children: [
        SizedBox(width: padding),
        Expanded(
          child: RichText(
            textAlign: textAlign ?? TextAlign.start,
            text: TextSpan(
              children: List.generate(
                docData.length,
                (index) {
                  Color color = colorText(index);
                  return TextSpan(
                    text: docData[index] + " ",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: color,
                      // decoration: TextDecoration.underline,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        isShowPercent
            ? Container(
                margin: EdgeInsets.only(right: padding),
                child: Text(
                  '${percentPass}%',
                  style: TextStyle(
                    color: AppColors.colorSuccess,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  Color colorText(int index) {
    Color color = Colors.black;
    if (index >= yourDoc.length) return color;
    if (ClientUltis.textCompareTo(
        text1: docData[index], text2: yourDoc[index])) {
      color = Colors.blue;
    } else {
      color = AppColors.errorColor;
    }
    return color;
  }
}
