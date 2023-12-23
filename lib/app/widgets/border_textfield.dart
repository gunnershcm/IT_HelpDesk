import 'package:dich_vu_it/app/theme/colors.dart';
import 'package:dich_vu_it/app/theme/text.style.dart';
import 'package:flutter/material.dart';

class BorderTextField extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final String placeholder;
  final int? minLine;
  final int? maxLines;
  final bool? isPassword;
  final Function onChangeText;
  final TextInputType? typeKey;
  final bool? validator;
  const BorderTextField({
    required this.controller,
    super.key,
    required this.title,
    required this.placeholder,
    this.minLine,
    this.maxLines,
    this.isPassword,
    required this.onChangeText,
    this.typeKey,
    this.validator,
  });

  @override
  State<BorderTextField> createState() => _BorderTextFieldState();
}

class _BorderTextFieldState extends State<BorderTextField> {
  bool showpass = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: MyTextStyle.titleTextfile,
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.all(10),
          height: 40,
          decoration: BoxDecoration(
            color: MyColors.grey1,
            border: Border.all(
                width: 1,
                color:
                    (widget.validator == false) ? Colors.red : MyColors.grey2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            keyboardType: widget.typeKey ?? TextInputType.text,
            controller: widget.controller,
            obscureText: (widget.isPassword == true) ? showpass : false,
            maxLines: widget.maxLines ?? 1,
            minLines: widget.minLine ?? 1,
            decoration: InputDecoration(
              hintText: widget.placeholder,
              hintStyle: MyTextStyle.hintTextField,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(bottom: 13),
              suffixIcon: (widget.isPassword == true)
                  ? IconButton(
                      icon: Icon(
                        showpass ? Icons.visibility : Icons.visibility_off,
                        color: MyColors.black,
                        size: 22,
                      ),
                      padding: const EdgeInsets.only(bottom: 15),
                      onPressed: () {
                        setState(() {
                          showpass = !showpass;
                        });
                      },
                    )
                  : const Text(""),
            ),
            onChanged: (text) {
              widget.onChangeText(text);
            },
          ),
        ),
      ],
    );
  }
}
