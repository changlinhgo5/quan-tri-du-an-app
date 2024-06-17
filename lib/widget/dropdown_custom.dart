import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ielts/models/item_menu.dart';

import '../values/app_colors.dart';

class DropDownCustom extends StatelessWidget {
  String currentSelectedValue;
  Function(String?) onChanged;
  List<ItemMenu> listData;
  String? title;
  String error;
//  Alignment titleAlien;

  DropDownCustom({
    this.title,
    required this.currentSelectedValue,
    required this.onChanged,
    required this.listData,
    this.error = "",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != null
            ? Column(
                children: [
                  Text(
                    title!,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      // color: AppColors.black0,
                    ),
                  ),
                ],
              )
            : Container(),
        SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.only(left: 20, right: 12),
          decoration: BoxDecoration(
            color: const Color(0xffE7EFF9),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.borderColor.withOpacity(0.1)),
          ),
          child: FormField<String>(
            builder: (FormFieldState<String> state) {
              return Theme(
                data: ThemeData.light(),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  isEmpty: currentSelectedValue == '',
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: currentSelectedValue,
                      isDense: true,
                      iconSize: 12,
                      onChanged: onChanged,
                      items: listData.map((ItemMenu value) {
                        return DropdownMenuItem<String>(
                          value: value.key.toString(),
                          child: Text(
                            value.value,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        error.isNotEmpty
            ? Container(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  error,
                  style: TextStyle(color: Colors.red),
                ),
              )
            : Container(),
      ],
    );
  }
}
