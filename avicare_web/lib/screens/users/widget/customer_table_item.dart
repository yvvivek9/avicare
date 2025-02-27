import 'package:avicare_web/screens/widget/action_buttons.dart';
import 'package:avicare_web/screens/widget/edit_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:avicare_web/models/user.dart';

class CustomerTableItem extends StatelessWidget {
  const CustomerTableItem({
    super.key,
    required this.imageUrl,
    required this.customerName,
    required this.customerId,
    required this.email,
    required this.amountPaid,
    required this.location,
    required this.registeredOn,
    required this.isEdit, required this.onDeleteCallback,
  });

  final bool isEdit;
  final String imageUrl;
  final String customerName;
  final String customerId;
  final String email;
  final String amountPaid;
  final String location;
  final String registeredOn;
  final Function(String) onDeleteCallback;

  @override
  Widget build(BuildContext context) {
    final size = 150;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: size.w,
            child: Row(
              children: [
                Image.asset(
                  imageUrl,
                  width: 30.w,
                  height: 30.w,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customerName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.sp,
                      ),
                    ),
                    Text(
                      "${customerId.substring(0, 12)}...",
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            width: size.w,
            child: Text(
              email,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12.sp,
              ),
            ),
          ),
          SizedBox(
            width: size.w,
            child: Text(
              amountPaid,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12.sp,
              ),
            ),
          ),
          SizedBox(
            width: size.w,
            child: Text(
              location,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12.sp,
              ),
            ),
          ),
          SizedBox(
            width: size.w,
            child: Text(
              registeredOn,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12.sp,
              ),
            ),
          ),
          SizedBox(
            width: (size * 2).w,
            child: isEdit
                ? Center(child: EditButtons())
                : Center(
                    child: ActionButtons(
                    update: "Edit",
                    onDelete: () => onDeleteCallback(customerId),
                  )),
          ),
        ],
      ),
    );
  }
}
