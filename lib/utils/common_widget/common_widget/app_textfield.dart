import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'color_constant.dart';

typedef StringToVoidFunc = void Function(String);

class AppTextField extends StatelessWidget {
  String? name;
  int? maxLength;
  String? title;
  final List<TextInputFormatter>? inputFormatters;
  final List<BoxShadow>? boxShadow;
  final TextStyle? style;
  final Color? suffixIconColor;
  TextEditingController? controller;

  bool? isObscure = false;
  bool? readOnly;
  TextInputType? textInputType = TextInputType.emailAddress;
  double? height;
  TextInputAction? textInputAction;
  double? width;
  final double? elevation;
  final Widget? suffix;
  final Widget? prefix;
  Color? color;
  StringToVoidFunc? onChanged;
  final VoidCallback? onTap;
  EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? margin;
  int? maxLines;
  BorderRadiusGeometry? borderRadius;
  InputBorder? outlineInputBorder;
  BoxBorder? border;
  TextStyle? hintstyle;
  String? labelText;
  final AutovalidateMode? autovalidateMode;
  final String? Function(String?)? validator;

  AppTextField({
    super.key,
    this.title,
    this.style,
    this.boxShadow,
    this.suffix,
    this.validator,
    this.autovalidateMode,
    this.color,
    this.margin,
    this.name,
    this.hintstyle,
    this.labelText,
    this.controller,
    this.outlineInputBorder,
    this.elevation,
    this.inputFormatters,
    this.onChanged,
    this.onTap,
    this.isObscure,
    this.textInputType,
    this.height,
    this.width,
    this.maxLength,
    this.prefix,
    this.textInputAction,
    this.contentPadding,
    this.maxLines,
    this.borderRadius,
    this.border,
    this.suffixIconColor,
    this.readOnly,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 60,
      //width: width ?? Get.width,
      margin: margin ?? const EdgeInsets.only(left: 0, right: 0),
      decoration: BoxDecoration(
        color: color ?? AppColor.textFieldColor,
        boxShadow: boxShadow ?? [],
        borderRadius:
            borderRadius ?? const BorderRadius.all(Radius.circular(10)),
        border: border,
      ),
      child: TextFormField(
          onTap: onTap,
          style: style ??

            const TextStyle(
                color: AppColor.white,
                fontWeight: FontWeight.w500,
                fontSize: 15),
        onChanged: onChanged,
        controller: controller,
        inputFormatters: inputFormatters,
        autovalidateMode: autovalidateMode ?? AutovalidateMode.onUserInteraction,
        validator: validator,
        maxLength: maxLength,
        maxLines: maxLines,
        readOnly: readOnly ?? false,
        textInputAction: textInputAction ?? TextInputAction.done,
        obscureText: isObscure ?? false,
        keyboardType: textInputType ?? TextInputType.emailAddress,
        decoration: InputDecoration(
          counterText: "",
          hintText: title,

          labelText: labelText,
          suffixIcon: suffix,
          prefixIcon: prefix,
          suffixIconColor: suffixIconColor,
          contentPadding:
              contentPadding ?? const EdgeInsets.only(left: 20, top: 20),
          hintStyle: hintstyle ?? const TextStyle(color: Colors.white54),
          border: outlineInputBorder?? OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
