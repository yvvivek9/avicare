import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildTextField({
  required TextEditingController controller,
  required String label,
  required String hint,
  TextInputType? keyboardType,
  IconData? suffixIcon,
  IconData? prefixIcon,
  int? maxLength,
  String? Function(String?)? validator,
  int maxLines = 1,
}) {
  return SizedBox(
    width: 392.w,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4.h),
        SizedBox(
          child: TextFormField(
            maxLines: maxLines,
            maxLength: maxLength,
            controller: controller,
            keyboardType: keyboardType,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter $label';
              }
              return validator != null ? validator(value) : null;
            },
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 14.sp,
              ),
              prefixIcon: prefixIcon != null
                  ? Icon(
                      prefixIcon,
                      color: Colors.black,
                    )
                  : null,
              suffixIcon: suffixIcon != null
                  ? Icon(
                      suffixIcon,
                      color: Colors.black,
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: Colors.black.withValues(alpha: 0.13),
                  width: 0.5.sp,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: Colors.black.withValues(alpha: 0.13),
                  width: 0.5.sp,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: Colors.black.withValues(alpha: 0.13),
                  width: 0.5.sp,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(color: Colors.red),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}
