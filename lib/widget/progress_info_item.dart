import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ielts/index.dart';
import 'package:ielts/widget/progress.dart';

class ProgressInfoItem extends StatelessWidget {
  ProgressInfoItem({
    super.key,
    required this.title,
    required this.image,
    required this.progress,
    this.colorProgress,
  });
  String title;
  double progress;
  String image;
  Color? colorProgress;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Image(
            image: AssetImage(
              image,
            ),
            width: 24,
          ),
          SizedBox(width: 22),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 10),
                    ),
                    Text(
                      (progress * 100).toString() + "%",
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                ProgressIndicatorApp(
                  progress: progress,
                  color: colorProgress,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
