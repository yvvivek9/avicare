import 'package:avicare_web/screens/widget/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:avicare_web/models/user.dart';

import '../../../constants/custom_colors.dart';
import 'customer_table_heading.dart';
import 'customer_table_item.dart';

class CustomerList extends StatelessWidget {
  const CustomerList({super.key, required this.usersList, required this.onDeleteCallback});

  final List<User> usersList;
  final Function(String) onDeleteCallback;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
          width: 0.3.sp,
        ),
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 3.0,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Customers",
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Members that have registered and active",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 375.w,
              ),
              Row(
                children: [
                  customSearchBar(),
                  SizedBox(width: 30.w),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: 54.h,
                      height: 54.h,
                      decoration: BoxDecoration(
                        color: CustomColors.grey,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Icon(
                        Icons.settings,
                        size: 32.w,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 30.h,
          ),
          customerTableHeading(),
          Column(
            children: usersList
                .map((u) => CustomerTableItem(
                      imageUrl: "assets/images/person_image.png",
                      customerName: u.name,
                      customerId: u.id,
                      email: u.email,
                      amountPaid: "--",
                      location: "--",
                      registeredOn: "--",
                      isEdit: false,
              onDeleteCallback: onDeleteCallback,
                    ))
                .toList(),
          ),
          // CustomerTableItem(
          //   isEdit: true,
          //   imageUrl: "assets/images/person_image.png",
          //   customerName: "John Doe",
          //   customerId: "123456789",
          //   email: "fz3aU@example.com",
          //   amountPaid: "\$ 1000",
          //   location: "New York, USA",
          //   registeredOn: "2023-08-10",
          // ),
          // Divider(
          //   height: 1.h,
          //   color: Colors.black,
          //   thickness: 5.h,
          // ),
          // CustomerTableItem(
          //   isEdit: false,
          //   imageUrl: "assets/images/person_image.png",
          //   customerName: "John Doe",
          //   customerId: "123456789",
          //   email: "fz3aU@example.com",
          //   amountPaid: "\$ 1000",
          //   location: "New York, USA",
          //   registeredOn: "2023-08-10",
          // ),
        ],
      ),
    );
  }
}
