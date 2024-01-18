import 'package:ar_visionary_explora/components/custom_text.dart';
import 'package:ar_visionary_explora/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomerTextField extends StatelessWidget {
  const CustomerTextField(
      {super.key,
      required this.hintText,
      required this.labelText,
      this.isObscure = false,
      this.controller});

  final String hintText;
  final String labelText;
  final bool isObscure;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.ash.withOpacity(.4),
            offset: const Offset(0, 2),
            blurRadius: 10,
          ),
        ],
      ),
      child: TextField(
        obscureText: isObscure,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: AppColors.ash),
          label: CustomText(
            labelText,
            color: AppColors.ash,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: AppColors.primaryColor),
          ),
        ),
      ),
    );
  }
}
