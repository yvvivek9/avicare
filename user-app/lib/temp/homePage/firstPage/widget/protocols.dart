import 'package:avicare/constants/colors.dart';
import 'package:avicare/temp/protocolDetails/page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class Protocols extends StatelessWidget {
  const Protocols({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Protocols",
                style: TextStyle(
                  fontSize: 22.sp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              individualProtocolContainer(
                protocolID: "67bfc86a885af9cf433e83d6",
                color: AppColors.darkPeach,
                height: 210,
                width: 164,
                description: "10 Exercises",
                title: "ACL",
                image: "knee.png",
                imageHeight: 130,
                imageWidth: 70,
              ),
              Column(
                children: [
                  individualProtocolContainer(
                    protocolID: "67bfc889885af9cf433e83df",
                    title: "PCL",
                    description: "10 Exercises",
                    image: "bone.png",
                    imageWidth: 60,
                    imageHeight: 50,
                    color: AppColors.lightBlue,
                    width: 161,
                    height: 100,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  individualProtocolContainer(
                    protocolID: "67bfe2972376f0bacac53a06",
                    title: "Total Knee \nReplacement",
                    description: "15 Exercises",
                    image: 'knee-3.png',
                    imageWidth: 30,
                    imageHeight: 40,
                    color: AppColors.pink,
                    width: 161,
                    height: 100,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              individualProtocolContainer(
                protocolID: "67bfe20b2376f0bacac539f8",
                title: "Hip \nrehab \nprotocol",
                description: "12 Exercises",
                image: "chest.png",
                imageWidth: 40,
                imageHeight: 60,
                color: AppColors.purple,
                width: 144,
                height: 125,
              ),
              individualProtocolContainer(
                protocolID: "67bfe2502376f0bacac539ff",
                title: "Ankle rehab \nprotocol",
                description: "13 Exercises",
                image: "leg.png",
                imageWidth: 80,
                imageHeight: 60,
                color: AppColors.green,
                width: 184,
                height: 125,
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          individualProtocolContainer(
            protocolID: "67bfe1c42376f0bacac539f1",
            title: "Meniscus repair \nProtocol ",
            description: "10 Exercises",
            image: "knee-2.png",
            imageWidth: 170,
            imageHeight: 70,
            color: AppColors.lightBlue,
            width: 332,
            height: 100,
          ),
          SizedBox(
            height: 100.h,
          ),
        ],
      ),
    );
  }
}

Widget individualProtocolContainer({
  required String protocolID,
  required int height,
  required int width,
  required Color color,
  required String title,
  required String description,
  String? image,
  required int imageHeight,
  required int imageWidth,
}) {
  return ZoomTapAnimation(
    onTap: () {
      Get.to(() =>
          ProtocolDetails(protocolID: protocolID));
    },
    child: Container(
      height: height.h,
      width: width.h,
      padding: EdgeInsets.all(10.r).copyWith(
        left: 10.w,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5.h,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
            ],
          ),
          Positioned(
            right: 0.w,
            top: 0.h,
            child: Container(
              height: 34.h,
              width: 34.h,
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.8),
              ),
              child: const ImageIcon(
                AssetImage("assets/images/arrow.png"),
                color: Colors.black,
              ),
            ),
          ),
          if (image != null)
            Positioned(
              right: 0.w,
              bottom: 0.h,
              child: Image.asset(
                "assets/images/$image",
                height: imageHeight.h,
                width: imageWidth.w,
              ),
            ),
        ],
      ),
    ),
  );
}
