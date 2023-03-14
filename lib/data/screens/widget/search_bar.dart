import 'package:flutter/material.dart';
import 'package:object_box_tut/utils/app_color.dart';

class SearchBar extends StatefulWidget {
  final TextEditingController searchController;
  final Function(String, bool) onChanged;
  final FocusNode textFocusNode;
  final BuildContext ctx;

  const SearchBar({required this.searchController, required this.onChanged,required this.textFocusNode , required this.ctx});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool _searchModeOn = false;
  bool _numericOn = false;
  final FocusNode _searchFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 18,
      ),
      height: 48,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
            color: _searchModeOn
                ? AppColor.appBarColor
                : Colors.black.withOpacity(0.11),
            width: _searchModeOn ? 1 : 0.1),
        boxShadow: [
          BoxShadow(
            color: AppColor.appBarColor.withOpacity(0.9),
            blurRadius: 7,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _searchModeOn
              ? InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    size: 24.15,
                  ),
                )
              : const Icon(
                  Icons.search_outlined,
                  size: 24.15,
                  color: Color(0xFF878DA3),
                ),
          const SizedBox(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Focus(
                focusNode: _searchFocusNode,
                onFocusChange: (hasFocus) {
                  if (hasFocus) {
                    _searchModeOn = true;
                  } else {
                    _searchModeOn = false;
                  }
                  setState(() {});
                },
                child: TextFormField(
                  focusNode: widget.textFocusNode,
                  keyboardType:
                      _numericOn ? TextInputType.number : TextInputType.text,
                  autofocus: false,
                  controller: widget.searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search',
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    isCollapsed: true,
                  ),
                  onChanged: (val) {
                    widget.onChanged(val, _numericOn);
                  },
                ),
              ),
            ),
          ),
          _numericOn
              ? IconButton(
                  splashColor: Colors.transparent,
                  padding: EdgeInsets.zero,
                  onPressed: () {

                  },
                  icon: const Icon(Icons.format_list_numbered_rounded))
              : IconButton(
                  splashColor: Colors.transparent,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    _numericOn = true;

                  },
                  icon: const Icon(Icons.keyboard_alt_outlined))
        ],
      ),
    );
  }
}
