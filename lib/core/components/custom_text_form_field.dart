import 'package:crypto_wallet/core/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatefulWidget {
  final String text;
  final double fontSize;
  final Color backgroundColor;
  final Color textColor;
  final Icon? leadingIcon;
  final IconButton? trailingIcon;
  final TextEditingController controller;
  final double topRightRadius;
  final double topLeftRadius;
  final double bottomRightRadius;
  final double bottomLeftRadius;
  final bool autoCorrect;
  final bool obscureText;
  final bool autoSuggestions;
  final double? height;
  final double? width;
  final TextAlign textAlign;
  final double leftPadding;
  final double rightPadding;
  final Color borderColor;
  final double borderWidth;
  final Color controllerColor;
  final Color typingTextColor;
  final Alignment alignment;
  final int? maxLength;
  final int? maxLines;
  final void Function()? onTap;
  final void Function()? actionButton;
  final void Function(String)? onChanged;
  final void Function()? onSubmitted;
  final TextInputType keyboardType;
  final bool? enabled;
  final bool? autoFocus;
  final List<TextInputFormatter> inputFormatters;
  final TextInputAction textInputAction;
  final Widget? underline;
  final double textFontSize;
  final FontWeight textFontWeight;
  final bool showCursor;
  final bool readOnly;
  final dynamic focusNode;
  final FloatingLabelBehavior floatingLabelBehavior;

  const CustomTextFormField({
    required this.text,
    this.fontSize = 18,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.grey,
    this.leadingIcon,
    this.trailingIcon,
    required this.controller,
    this.topRightRadius = 5,
    this.topLeftRadius = 5,
    this.bottomRightRadius = 5,
    this.bottomLeftRadius = 5,
    this.autoCorrect = false,
    this.obscureText = false,
    this.autoSuggestions = true,
    this.height,
    this.width,
    this.textAlign = TextAlign.start,
    this.leftPadding = 0,
    this.rightPadding = 0,
    this.borderColor = Colors.transparent,
    this.borderWidth = 0,
    super.key,
    this.controllerColor = Colors.black,
    this.typingTextColor = Colors.black,
    this.alignment = Alignment.topCenter,
    this.maxLength,
    this.maxLines,
    this.onTap,
    this.actionButton,
    this.onChanged,
    this.onSubmitted = _defaultOnSubmitted,
    this.keyboardType = TextInputType.text,
    this.enabled = true,
    this.autoFocus = false,
    this.inputFormatters = const [],
    this.textInputAction = TextInputAction.done,
    this.underline,
    this.textFontSize = 16,
    this.textFontWeight = FontWeight.normal,
    this.showCursor = true,
    this.readOnly = false,
    this.focusNode,
    this.floatingLabelBehavior = FloatingLabelBehavior.never,
  });

  static void _defaultOnSubmitted() {}

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}


class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            border: Border.all(
              color: widget.borderColor,
              width: widget.borderWidth,
            ),
            color: widget.backgroundColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(widget.topRightRadius),
              topLeft: Radius.circular(widget.topLeftRadius),
              bottomRight: Radius.circular(widget.bottomRightRadius),
              bottomLeft: Radius.circular(widget.bottomLeftRadius),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
                left: widget.leftPadding, right: widget.rightPadding),
            child: Align(
              alignment: widget.alignment,
              child: TextFormField(
                cursorColor: primary,
                textAlignVertical: widget.trailingIcon != null ? TextAlignVertical.center : TextAlignVertical.top,
                textInputAction: widget.textInputAction,
                onEditingComplete: () async{
                  widget.actionButton ??
                      (widget.focusNode == null ? FocusScope.of(context)
                          .nextFocus() : widget.focusNode!.nextFocus());
                },
                inputFormatters: widget.inputFormatters,
                autofocus: widget.autoFocus ?? false,
                enabled: widget.enabled,
                focusNode: widget.focusNode ?? null,
                readOnly: widget.readOnly,
                showCursor: widget.showCursor,
                onChanged: (value) {
                  widget.onChanged!(value);
                },
                onFieldSubmitted: (value) {
                  widget.onSubmitted!();
                },
                keyboardType: widget.keyboardType,
                maxLines: widget.maxLines,
                maxLength: widget.maxLength,
                onTap: widget.onTap,
                style: TextStyle(
                  color: widget.typingTextColor,
                  fontSize: widget.textFontSize,
                  fontWeight: widget.textFontWeight,
                ),
                controller: widget.controller,
                obscureText: widget.obscureText,
                autocorrect: widget.autoCorrect,
                enableSuggestions: widget.autoSuggestions,
                textAlign: widget.textAlign,
                decoration: InputDecoration(
                  floatingLabelBehavior: widget.floatingLabelBehavior,
                  contentPadding: EdgeInsets.only(top: 0),
                  hintText: widget.text,
                  alignLabelWithHint: true,
                  hintStyle: TextStyle(
                    overflow: TextOverflow.visible,
                    color: widget.textColor,
                    fontSize: widget.fontSize,
                  ),
                  prefixIcon: widget.leadingIcon,
                  suffixIcon: widget.trailingIcon,
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
        widget.underline != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: widget.underline!,
                    ),
                  ],
                ),
              )
            : Container(),
      ],
    );
  }
}
