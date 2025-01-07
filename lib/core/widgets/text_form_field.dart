import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/color_const.dart';
import '../global_variable/global_variable.dart';

class CustomTextInput extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final String? hint;
  final double? width;
  final double? height; // Ensure height is used properly
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onPrefixIconTap;
  final VoidCallback? onSuffixIconTap;
  final int? maxLines;
  final TextCapitalization textCapitalization;
  final bool? obscureText;
  final bool? readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final Color? bgColour;
  final Color? borderColour;
  final Color? labelColour;
  final TextInputAction? textInputAction;
  final InputDecoration? decoration;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;

  CustomTextInput({
    Key? key,
    required this.controller,
    this.label,
    this.hint,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.onPrefixIconTap,
    this.onSuffixIconTap,
    this.maxLines,
    this.textCapitalization = TextCapitalization.none,
    this.width,
    this.height,
    this.bgColour,
    this.borderColour,
    this.labelColour,
    this.onChanged,
    this.obscureText = false,
    this.inputFormatters,
    this.readOnly = false,
    this.textInputAction,
    this.decoration,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Container(
      width: w * (width ?? 0.99),
      height: h * (height ?? 0.08),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(w * 0.01),
        border: Border.all(color: Colors.transparent),
        color: bgColour ?? Colors.transparent,
      ),
      child: TextFormField(
        textInputAction: textInputAction,
        readOnly: readOnly ?? false,
        // style: TextStyle(
        //   fontSize: w * 0.04,
        //   fontFamily: fount,
        // ),
        obscureText: obscureText ?? false,
        onChanged: onChanged,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        cursorColor: Colors.black,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        validator: validator,
        controller: controller,
        maxLines: maxLines,
        textCapitalization: textCapitalization,
        decoration: decoration ??
            InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: h * (height ?? 0.08) * 0.3,
                horizontal: w * 0.03,
              ),
              hintText: hint,
              hintStyle: TextStyle(
                fontFamily: fount,
                fontSize: w * 0.04,
              ),
              labelText: label,
              labelStyle: TextStyle(
                fontFamily: fount,
                color: labelColour ?? Palette.greyColor,
                fontSize: MediaQuery.of(context).size.width > 600
                    ? 14 // Web or larger screen size
                    : 16, // Mobile
              ),
              prefixIcon: prefixIcon != null
                  ? InkWell(
                onTap: onPrefixIconTap,
                child: prefixIcon,
              )
                  : null,
              suffixIcon: suffixIcon != null
                  ? InkWell(
                onTap: onSuffixIconTap,
                child: suffixIcon,
              )
                  : null,
              border: border ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(w * 0.02),
                    borderSide: BorderSide(
                        color: borderColour ?? Palette.greyColor),
                  ),
              enabledBorder: enabledBorder ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(w * 0.02),
                    borderSide: BorderSide(
                        color: borderColour ?? Palette.greyColor),
                  ),
              focusedBorder: focusedBorder ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(w * 0.02),
                    borderSide: BorderSide(
                        color: borderColour ?? Palette.greyColor),
                  ),
            ),
      ),
    );
  }





}
