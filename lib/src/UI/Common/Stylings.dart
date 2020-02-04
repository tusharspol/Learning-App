import 'package:flutter/material.dart';

class Style {
  static final baseTextStyle = const TextStyle(
    fontFamily: 'Poppins'
  );

  static final errorText = baseTextStyle.copyWith(
    fontSize: 12.0,
  );

  static final text32SemiBold = baseTextStyle.copyWith(
    color: blackTextColor,
    fontSize: 32.0,
    fontWeight: FontWeight.w600
  );

  static final text12Regular = baseTextStyle.copyWith(
    color: greyTextColor,
    fontSize: 12.0
  );
  
  static final buttonTextStyle = baseTextStyle.copyWith(
    color: Colors.white,
    fontSize: 16.0,
  );

  static final signupLinkTextStyle = text12Regular.copyWith(
    fontWeight: FontWeight.w700,
    color: blackTextColor
  );

  static final roundedButtonShape = RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0));

  static final primaryColor = Colors.redAccent;
  static final primaryLightColor = primaryColor.withOpacity(0.2);
  static final backgroundColor = const Color(0xFFFAFAFA);
  static final blackTextColor = const Color(0xff515C6F);
  static final greyTextColor = const Color(0xFF8A9EAD);
  static final borderColor = const Color(0xFF707070);
}
