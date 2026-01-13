import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets.dart';

class AppInputField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged, onSubmitted;
  final String? Function(String?)? validator;
  final String hintText;
  final String? errorText;
  final IconData? prefixIcon;
  final Widget? suffix;
  final bool obscureText;
  final AutovalidateMode? autovalidateMode;
  final TextInputType? keyboardType;
  final int? maxLength, maxLines;
  final bool? enabled;
  final bool readOnly;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final Color? fillColor;
  const AppInputField({
    super.key,
    required this.controller,
    required this.hintText,
    this.errorText,
    this.prefixIcon,
    this.suffix,
    this.obscureText = false,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.autovalidateMode,
    this.keyboardType,
    this.maxLength,
    this.maxLines,
    this.enabled,
    this.focusNode,
    this.readOnly = false,
    this.inputFormatters,
    this.fillColor = AppColors.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      readOnly: readOnly,
      controller: controller,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      validator: validator,
      keyboardType: keyboardType,
      focusNode: focusNode,
      maxLines: maxLines ?? 1,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hintText,
        errorText: errorText,
        fillColor: fillColor,
        filled: true,
        prefixIcon:
            prefixIcon == null
                ? null
                : Icon(prefixIcon, color: AppColors.black),
        hintStyle: AppTextStyle.body.copyWith(color: AppColors.ashlyGrey),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: AppColors.ash, width: 1.0),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: AppColors.ash, width: 1.0),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: AppColors.error, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2.0,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 8,
        ),
        suffix: suffix,
      ),
      maxLength: maxLength,
      obscureText: obscureText,
      autovalidateMode: autovalidateMode,
    );
  }
}

class AppTextArea extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final TextInputType keyboardType;
  final Function(String)? onChanged;

  const AppTextArea({
    super.key,
    required this.controller,
    this.hintText = '',
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
        fillColor: AppColors.fillColor,
        filled: true,
        hintText: hintText,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
      ),
    );
  }
}

class ClickableInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final Function()? onTap;

  const ClickableInputField({
    super.key,
    required this.icon,
    required this.hintText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.ash,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 15.0,
              ),
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
              child: Icon(icon, color: AppColors.white),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 15.0,
                ),
                child: Text(
                  hintText,
                  style: const TextStyle(color: Colors.grey, fontSize: 16.0),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppDropdown extends StatelessWidget {
  final List<String> items;
  final String? hintText;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final IconData? prefixIcon;

  const AppDropdown({
    super.key,
    required this.items,
    this.onChanged,
    this.hintText,
    this.validator,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      items:
          items.map((String value) {
            return DropdownMenuItem(value: value, child: Text(value));
          }).toList(),
      validator: validator,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.fillColor,
        hintText: hintText ?? 'Select an option',
        prefixIcon: Icon(prefixIcon, color: AppColors.primaryColor),
        hintStyle: AppTextStyle.body.copyWith(color: AppColors.primaryColor),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: AppColors.ash, width: 1.0),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: AppColors.ash, width: 1.0),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: AppColors.ash, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1.0,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 10,
        ),
      ),
      onChanged: onChanged,
    );
  }
}

class AppDropdown2 extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final String? hintText;
  final String? valueToShow;
  final void Function(Map<String, dynamic>?)? onChanged;
  final String? Function(Map<String, dynamic>?)? validator;

  const AppDropdown2({
    super.key,
    required this.items,
    this.onChanged,
    this.hintText,
    this.validator,
    this.valueToShow,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      items:
          items.map((Map<String, dynamic> value) {
            return DropdownMenuItem(
              value: value,
              child: Text(value[valueToShow ?? 'name']),
            );
          }).toList(),
      validator: validator,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.grey,
        hintText: hintText ?? 'Select an option',
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
      ),
      onChanged: onChanged,
    );
  }
}
