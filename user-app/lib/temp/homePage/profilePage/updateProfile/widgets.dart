import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({super.key, required this.controller, required this.width, required this.leading, required this.title, required this.options});

  final TextEditingController controller;
  final String title;
  final double width;
  final IconData leading;
  final List<String> options;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5.h),
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 5.h),
        DropdownMenu(
          width: width,
          controller: controller,
          leadingIcon: SizedBox(
            width: 60.w,
            child: Center(
              child: Icon(
                leading,
                color: Colors.grey,
              ),
            ),
          ),
          trailingIcon: SizedBox(
            width: 60.w,
            child: Center(
              child: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.grey,
              ),
            ),
          ),
          selectedTrailingIcon: SizedBox(
            width: 60.w,
            child: Center(
              child: Icon(
                Icons.keyboard_arrow_up_rounded,
                color: Colors.grey,
              ),
            ),
          ),
          hintText: "-Select-",
          textStyle: TextStyle(
            fontSize: 16.sp,
            color: Colors.black,
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Color(0xfff2f2f2),
            contentPadding: EdgeInsets.symmetric(horizontal: 15),
            hintStyle: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey,
            ),
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              gapPadding: 0,
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              gapPadding: 0,
              borderRadius: BorderRadius.circular(10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              gapPadding: 0,
              borderRadius: BorderRadius.circular(10),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              gapPadding: 0,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          menuStyle: MenuStyle(
            padding: WidgetStatePropertyAll<EdgeInsets>(EdgeInsets.all(0)),
            fixedSize: WidgetStatePropertyAll(Size.fromWidth(300.w)),
            alignment: Alignment(-1.01, 1.2),
          ),
          dropdownMenuEntries: options
              .map((o) => DropdownMenuEntry(
                    value: o,
                    label: o,
                    leadingIcon: SizedBox(width: 40),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(Color(0xfff2f2f2)),
                      foregroundColor: WidgetStatePropertyAll<Color>(Colors.black),
                      textStyle: WidgetStatePropertyAll<TextStyle>(TextStyle(
                        fontSize: 16.sp,
                      )),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class CustomDatePicker extends StatelessWidget {
  const CustomDatePicker({super.key, required this.controller, required this.title, required this.placeholder, required this.width, required this.leading});

  final TextEditingController controller;
  final String title;
  final String placeholder;
  final double width;
  final IconData leading;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5.h),
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 5.h),
        SizedBox(
          width: width,
          child: TextField(
            controller: controller,
            readOnly: true,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(15),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                gapPadding: 0,
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                gapPadding: 0,
                borderRadius: BorderRadius.circular(10),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                gapPadding: 0,
                borderRadius: BorderRadius.circular(10),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                gapPadding: 0,
                borderRadius: BorderRadius.circular(10),
              ),
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Color(0xfff2f2f2),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              hintText: placeholder,
              hintStyle: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey,
              ),
              prefixIcon: SizedBox(
                width: 60.w,
                child: Center(
                  child: Icon(
                    leading,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            onTap: () async {
              final pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1950),
                lastDate: DateTime.now(),
                builder: (context, child) => Theme(
                  data: ThemeData.light().copyWith(
                    colorScheme: ColorScheme.light(
                      primary: Colors.black,
                      onPrimary: Colors.white,
                      surface: Colors.white,
                      onSurface: Colors.black,
                    ),
                  ),
                  child: child!,
                ),
              );
              if (pickedDate != null) {
                controller.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
              }
            },
          ),
        ),
      ],
    );
  }
}

class CustomInputWithUnit extends StatelessWidget {
  const CustomInputWithUnit(
      {super.key,
      required this.controller,
      required this.width,
      required this.leading,
      required this.title,
      required this.units,
      required this.info,
      required this.placeholder,
      required this.selectedUnit,
      required this.onUnitChange});

  final TextEditingController controller;
  final String title;
  final String placeholder;
  final String info;
  final double width;
  final IconData leading;
  final List<String> units;
  final String selectedUnit;
  final Function(String) onUnitChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5.h),
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 5.h),
        SizedBox(
          width: width,
          child: TextField(
            controller: controller,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black,
            ),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(15),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                gapPadding: 0,
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                gapPadding: 0,
                borderRadius: BorderRadius.circular(10),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                gapPadding: 0,
                borderRadius: BorderRadius.circular(10),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                gapPadding: 0,
                borderRadius: BorderRadius.circular(10),
              ),
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Color(0xfff2f2f2),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              hintText: placeholder,
              hintStyle: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey,
              ),
              prefixIcon: SizedBox(
                width: 60.w,
                child: Center(
                  child: Icon(
                    leading,
                    color: Colors.grey,
                  ),
                ),
              ),
              suffixIcon: SizedBox(
                width: 60.w,
                child: Center(
                  child: CustomUnitSelector(
                    selectedUnit: selectedUnit,
                    units: units,
                    onUnitChange: onUnitChange,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          info,
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }
}

class CustomUnitSelector extends StatelessWidget {
  const CustomUnitSelector({super.key, required this.selectedUnit, required this.units, required this.onUnitChange});

  final String selectedUnit;
  final List<String> units;
  final Function(String) onUnitChange;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        int currentIndex = units.indexOf(selectedUnit);
        int nextIndex = (currentIndex + 1) % units.length; // Loops back to first unit
        onUnitChange(units[nextIndex]);
      },
      child: Text(
        selectedUnit,
        style: TextStyle(
          fontSize: 16.sp,
          color: Colors.black,
        ),
      ),
    );
  }
}
