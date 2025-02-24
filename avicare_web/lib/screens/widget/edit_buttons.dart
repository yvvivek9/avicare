import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Controller for managing edit button states
class EditButtonController extends GetxController {
  final RxBool isBlocked = false.obs;

  void toggleBlock() {
    isBlocked.value = !isBlocked.value;
  }

  void delete() {
    // Implement delete functionality
    Get.snackbar(
      'Delete',
      'Item deleted successfully',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

class EditButtons extends StatelessWidget {
  EditButtons({Key? key}) : super(key: key);

  final EditButtonController controller = Get.put(EditButtonController());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Block/Unblock Button
        Obx(() => ElevatedButton.icon(
              onPressed: controller.toggleBlock,
              icon: Icon(
                controller.isBlocked.value ? Icons.block_outlined : Icons.block,
                size: 20.sp,
                color: controller.isBlocked.value ? Colors.grey : Colors.red,
              ),
              label: Text(
                controller.isBlocked.value ? 'unblock' : 'Block',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: controller.isBlocked.value ? Colors.grey : Colors.red,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 8.h,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  side: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),
            )),

        SizedBox(width: 12.w),

        // Delete Button
        ElevatedButton.icon(
          onPressed: controller.delete,
          icon: Icon(
            Icons.delete_outline,
            size: 20.sp,
            color: Colors.red,
          ),
          label: Text(
            'Delete',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.red,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 8.h,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
              side: const BorderSide(
                color: Colors.grey,
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
