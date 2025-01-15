import 'package:crypto_wallet/core/components/custom_text.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final void Function()? onPressed;
  final Color borderColor;
  final double borderWidth;
  final double height;
  final double width;
  final FontWeight fontWeight;

  const CustomButton({
    super.key,
    required this.text,
    this.fontSize = 18,
    this.backgroundColor = Colors.transparent,
    this.textColor = Colors.white,
    this.borderRadius = 5,
    required this.onPressed,
    this.borderColor = Colors.white,
    this.borderWidth = 1.0,
    this.height = 50,
    this.width = 100,
    this.fontWeight = FontWeight.w400,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              side: BorderSide(
                color: borderColor,
                width: borderWidth,
              ),
            ),
          ),
        ),
        child: CustomText(
          overflow: TextOverflow.visible,
          text: text,
          color: textColor,
          size: fontSize,
          weight: fontWeight,
        ),
      ),
    );
  }
}
