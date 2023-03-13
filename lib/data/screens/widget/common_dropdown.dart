import 'package:flutter/material.dart';
import 'package:object_box_tut/utils/app_color.dart';

class CommonDropDown<T> extends StatefulWidget {
  final List<T> items;
  final String hintText;
  final Function(T) onSelected;
  const CommonDropDown({
    Key? key,
    required this.items,
    required this.onSelected,
    required this.hintText,
  }) : super(key: key);

  @override
  State<CommonDropDown<T>> createState() => _CommonDropDownState<T>();
}

class _CommonDropDownState<T> extends State<CommonDropDown<T>> {
  T? selectedVal;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(0, 5, 20, 5),
      margin: const EdgeInsets.fromLTRB(10, 20, 10, 15),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColor.appBarColor,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 5),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<T>(
            borderRadius: BorderRadius.circular(10),
            hint: Text(
              widget.hintText,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            value: selectedVal,
            icon: const Icon(Icons.arrow_drop_down_rounded),
            iconSize: 24,
            items: widget.items.map((T value) {
              return DropdownMenuItem<T>(
                value: value,
                child: Text(
                  value.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  // minFontSize: 11,
                ),
              );
            }).toList(),
            onChanged: (T) {
              widget.onSelected(T!);
              setState(() => selectedVal = T);
            },
          ),
        ),
      ),
    );
  }
}
