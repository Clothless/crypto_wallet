import 'package:crypto_wallet/core/const/colors.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight weight;
  final TextAlign textAlign;
  final TextOverflow overflow;

   CustomText({
    super.key,
    this.text = "Text",
    this.size = 18,
    this.color = firstTextColor,
    this.weight = FontWeight.normal,
    // this.fontFamily = GoogleFonts.poppins(),
    this.textAlign = TextAlign.justify,
    this.overflow = TextOverflow.ellipsis,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: weight,
        overflow: overflow,
      ),
    );
  }
}
