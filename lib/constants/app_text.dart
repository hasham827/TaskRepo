import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'colors.dart';

Widget AppText(
  String text, {
  Color? color,
  double? size,
  double? height,
  FontWeight? weight,
  TextAlign? align,
  TextOverflow? overflow,
  int? maxLines,
}) {
  return Text(
    text.tr,
    maxLines: maxLines,
    overflow: overflow,
    textAlign: align ?? TextAlign.start,
    style: TextStyle(
      fontFamily: "brittiSans",
      height: height,
      color: color ?? AppColors.txtBlack,
      fontSize: size ?? 14,
      fontWeight: weight ?? FontWeight.w400,
    ),
  );
}
