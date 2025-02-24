import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GridTileWidget extends StatelessWidget {
  const GridTileWidget({super.key, required this.title, required this.image});

  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    Uint8List? imageAsBytes;
    try {
      imageAsBytes = base64Decode(image);
    } catch (e) {
      imageAsBytes = null;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            // Add ClipRRect to respect container's border radius
            borderRadius: BorderRadius.circular(12.r),
            child: imageAsBytes != null
                ? Image.memory(
                    imageAsBytes,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    "assets/images/corrupted_file.webp",
                    fit: BoxFit.cover,
                  ),
          ),
          Positioned(
            top: 10.h,
            right: 10.w,
            child: MenuAnchor(
              menuChildren: [
                MenuItemButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(Icons.edit),
                      SizedBox(width: 15),
                      Text(
                        "Edit",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                MenuItemButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(Icons.delete),
                      SizedBox(width: 15),
                      Text(
                        "Delete",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
              builder: (ctx, controller, _) => IconButton(
                onPressed: () {
                  if (controller.isOpen) {
                    controller.close();
                  } else {
                    controller.open();
                  }
                },
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                  size: 18.sp,
                ),
              ),
            ),
          ),
          Positioned(
            left: 20.w,
            top: 170.h,
            child: SizedBox(
              width: 200.w,
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget singleCategory({
  required String title,
  required String image,
  required onTap,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.w),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.r),
    ),
    child: Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          // Add ClipRRect to respect container's border radius
          borderRadius: BorderRadius.circular(12.r),
          child: Image.asset(
            image,
            // height: 400.h,
            // width: 238.w, // Add width to match container
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 10.h,
          right: 10.w,
          child: Icon(
            Icons.more_vert,
            color: Colors.white,
            size: 18.sp,
          ),
        ),
        Positioned(
          left: 20.w,
          top: 170.h,
          child: SizedBox(
            width: 200.w,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.sp,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
