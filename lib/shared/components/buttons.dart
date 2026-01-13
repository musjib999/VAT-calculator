import 'package:flutter/material.dart';

import '../widgets.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({
    super.key,
    required this.text,
    this.onPressed,
    this.buttonStyle,
    this.buttonTextStyle,
    this.isDisabled,
    this.height,
    this.width,
    this.margin,
    this.alignment,
  });

  final String text;

  final VoidCallback? onPressed;

  final ButtonStyle? buttonStyle;

  final TextStyle? buttonTextStyle;

  final bool? isDisabled;

  final double? height;

  final double? width;

  final EdgeInsets? margin;

  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class PrimaryButton extends BaseButton {
  const PrimaryButton({
    super.key,
    this.decoration,
    this.leftIcon,
    this.rightIcon,
    this.loading = false,
    super.margin,
    super.onPressed,
    super.buttonStyle,
    super.alignment,
    super.buttonTextStyle,
    super.isDisabled,
    super.height,
    super.width,
    required super.text,
    this.bgColor = AppColors.primaryColor,
  });

  final BoxDecoration? decoration;

  final Widget? leftIcon;

  final Widget? rightIcon;
  final bool loading;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
          alignment: alignment ?? Alignment.center,
          child: buildElevatedButtonWidget,
        )
        : buildElevatedButtonWidget;
  }

  Widget get buildElevatedButtonWidget => Container(
    height: height ?? 52,
    width: width ?? double.maxFinite,
    margin: margin,
    decoration:
        decoration ?? BoxDecoration(borderRadius: BorderRadius.circular(8)),
    child: ElevatedButton(
      style:
          buttonStyle ??
          ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 0,
          ),
      onPressed: loading == true ? () {} : onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          leftIcon ?? const SizedBox.shrink(),
          leftIcon == null
              ? const SizedBox.shrink()
              : const SizedBox(width: 10),
          loading == true
              ? loader(AppColors.white)
              : Text(text, style: buttonTextStyle ?? AppTextStyle.buttonTitle),
          rightIcon ?? const SizedBox.shrink(),
        ],
      ),
    ),
  );
}

class SecondaryButton extends BaseButton {
  const SecondaryButton({
    super.key,
    this.decoration,
    this.leftIcon,
    this.rightIcon,
    this.loading = false,
    super.margin,
    super.onPressed,
    super.buttonStyle,
    super.alignment,
    super.buttonTextStyle,
    super.isDisabled,
    super.height,
    super.width,
    required super.text,
    this.bgColor = AppColors.primaryColor,
  });

  final BoxDecoration? decoration;

  final Widget? leftIcon;

  final Widget? rightIcon;
  final bool loading;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
          alignment: alignment ?? Alignment.center,
          child: buildElevatedButtonWidget,
        )
        : buildElevatedButtonWidget;
  }

  Widget get buildElevatedButtonWidget => Container(
    height: height ?? 52,
    width: width ?? double.maxFinite,
    margin: margin,
    decoration:
        decoration ?? BoxDecoration(borderRadius: BorderRadius.circular(8)),
    child: ElevatedButton(
      style:
          buttonStyle ??
          ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(color: bgColor),
            ),
          ),
      onPressed: loading == true ? () {} : onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          leftIcon ?? const SizedBox.shrink(),
          leftIcon == null
              ? const SizedBox.shrink()
              : const SizedBox(width: 10),
          loading == true
              ? loader(AppColors.white)
              : Text(
                text,
                style:
                    buttonTextStyle ??
                    AppTextStyle.buttonTitle.copyWith(color: bgColor),
              ),
          rightIcon ?? const SizedBox.shrink(),
        ],
      ),
    ),
  );
}
