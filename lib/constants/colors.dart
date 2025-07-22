import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primary = Color(0xFF29778D);
  static const Color secondary = Color(0xFF0198A5);
  static const Color skyBlue = Color(0xFFABE1FF);

  static const Color lightGrey = Color(0xFFE1E7EF);
  static const Color grayScale = Color(0xFF757575);
  static const Color grey = Color(0xFFA0AEC0);
  static const Color grey200 = Color(0xffeeeeee);
  static const Color bgColor = Color(0xffFFFFFF);
  static const Color hintColor = Color(0xFF9E9E9E);
  static const Color unselectedIconColor = Color(0xFF6B7280);
  static const Color borderColor = Color(0xFFF3F4F6);
  static const Color avatarBg = Color(0xFFF1F5F9);
  static  Color dotColor = Color(0xff29778D).withOpacity(0.3);
  static  Color tabBarBg = Color(0xffF1F5F9);
  static  Color profileCardBg = Color(0xffEDFDFF);
  static  Color circleBg = Color(0xffEFF0F4);
  static  Color starsColor = Color(0xffFBBF24);

  /// test colors here
  static const Color txtBlack = Color(0xFF323536);
  static const Color textLightBlack = Color(0xFF282C33);
  static const Color textDarkGrey = Color(0xFF5D737E);
  static const Color textTimeColor = Color(0xFF9CA3AF);
  static const Color textLightGreyColor = Color(0xFF66707A);
  static const Color textMoreLightGreyColor = Color(0xFF64748B);
  static const Color moreLight = Color(0xFF71797A);

  static  Gradient gradientColor = LinearGradient(
      colors: [
        Color(0XFF21B9C6),
        // Color(0XFF21B9C6),
        Color(0XFF0198A5).withOpacity(0.9),
        Color(0XFF0198A5).withOpacity(0.9),
        Color(0XFF0198A5).withOpacity(0.9),
        Color(0XFF0198A5).withOpacity(0.9),
        Color(0XFF0198A5),
      ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}

