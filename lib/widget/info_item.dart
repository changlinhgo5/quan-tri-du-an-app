import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ielts/index.dart';
import 'package:ielts/models/user.dart';

class InfoItem extends StatelessWidget {
  final User user;
  const InfoItem({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    ImageProvider<Object> x;
    if (user.avatar.isNotEmpty) {
      x = NetworkImage(user.avatar);
    } else {
      x = AssetImage(user.avatar);
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 22,
                backgroundImage: x,
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    user.email,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black45,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
