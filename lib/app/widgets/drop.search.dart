// ignore_for_file: prefer_const_constructors

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class DropSearchWidget<T> extends StatelessWidget {
  final Future<List<T>> getList;
  final String Function(T)? title;
  final T? selected;
  final Function(T?) onChange;
  final double? heightSearch;
  const DropSearchWidget({
    super.key,
    required this.getList,
    required this.title,
    this.selected,
    required this.onChange,
    this.heightSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            height: 50,
            child: DropdownSearch<T>(
              popupProps: PopupPropsMultiSelection.menu(
                showSearchBox: true,
              ),
              dropdownDecoratorProps: DropDownDecoratorProps(
                baseStyle: TextStyle(fontSize: 16),
                dropdownSearchDecoration: const InputDecoration(
                  constraints: BoxConstraints.tightFor(
                    width: 300,
                    height: 40,
                  ),
                  contentPadding: EdgeInsets.only(left: 14, bottom: 14),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(0),
                    ),
                    borderSide: BorderSide(color: Colors.white, width: 0),
                  ),
                  hintText: "",
                  hintMaxLines: 1,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    borderSide: BorderSide(color: Colors.white, width: 0),
                  ),
                ),
              ),
              asyncItems: (String? filter) => getList,
              itemAsString: title,
              selectedItem: selected,
              onChanged: (value) {
                onChange(value);
              },
            ),
          ),
        ),
      ],
    );
  }
}
