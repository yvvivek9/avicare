import 'package:avicare/controller/text_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BuildTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final String hint;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextInputType? keyboardType;
  final int? maxLength;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final bool isPassword;
  final int? radius;
  final TextFieldController _textFieldController = TextFieldController();

  BuildTextField({
    this.suffixIcon,
    Key? key,
    required this.controller,
    this.label,
    required this.hint,
    this.prefixIcon,
    this.radius = 100,
    this.keyboardType,
    this.maxLength,
    this.validator,
    this.onChanged,
    this.isPassword = false,
  }) : super(key: key) {
    // Initialize the obscured state based on isPassword
    if (isPassword) {
      _textFieldController.isObscured.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
        ],
        Obx(
          () => TextFormField(
            cursorRadius: Radius.circular(radius!.r),
            maxLength: maxLength,
            controller: controller,
            keyboardType: keyboardType,
            obscureText: _textFieldController.isObscured.value,
            validator: (value) {
              if (validator == null) {
                return "Please enter $label";
              }
              return validator!(value);
            },
            onChanged: onChanged,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 14.sp,
              ),
              prefixIcon: prefixIcon != null
                  ? Icon(
                      prefixIcon,
                      color: Colors.grey,
                    )
                  : null,
              suffixIcon: suffixIcon != null
                  ? IconButton(
                      icon: Icon(
                        suffixIcon,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        _textFieldController.toggleObscured();
                      },
                    )
                  : isPassword
                      ? IconButton(
                          icon: Icon(
                            _textFieldController.isObscured.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: _textFieldController.toggleObscured,
                        )
                      : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.r),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius!.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius!.r),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius!.r),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius!.r),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 15.h,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
