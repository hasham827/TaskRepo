import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constants/app_text.dart';
import '../../constants/colors.dart';

class AppBtn extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final String? icon;
  final double width;
  final double height;
  final Color? bgColor;
  final double radius;
  final Color? fontColor;
  final Color borderColor;
  final double fontSize;
  final FontWeight fontWeight;
  final bool loading;
  final double iconSize;

  const AppBtn({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.width = double.infinity,
    this.height = 60,
    this.bgColor,
    this.radius = 8,
    this.fontColor,
    this.borderColor = Colors.transparent,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w500,
    this.loading = false,
    this.iconSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    var gradientColors = AppColors.gradientColor;

    return GestureDetector(
      onTap: loading || onPressed == null ? null : onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient:
          onPressed != null && bgColor == null ? gradientColors : null,
          color:
          onPressed == null ? AppColors.primary.withOpacity(0.4) : bgColor,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: borderColor),
        ),
        alignment: Alignment.center,
        child:
        loading
            ? SizedBox(
          width: 25,
          height: 25,
          child: CircularProgressIndicator.adaptive(
            strokeWidth: 2,
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              SvgPicture.asset(
                icon!,
                width: iconSize,
                height: iconSize,
              ),
              SizedBox(width: 10),
            ],
            if (text.isNotEmpty)
              AppText(
                text,
                color: fontColor ?? Colors.white,
                size: fontSize,
                weight: fontWeight,
              ),
          ],
        ),
      ),
    );
  }
}


