import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'dart:typed_data';

import 'package:avicare_web/utils/utils.dart';
import 'package:avicare_web/models/exercise.dart';
import '../../../controller/category_controller.dart';
import '../../widget/build_text_field.dart';
import '../../widget/image_picker.dart';

class UpdateExerciseController extends GetxController {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final youtubeController = TextEditingController();
  final stepsController = TextEditingController();
  late DropzoneViewController fileController;
  final imageData = Rx<Uint8List?>(null);
  final borderColor = Rx<Color?>(null);

  Future<void> handleSubmit(Exercise exercise) async {
    if (nameController.text == "" || descriptionController.text == "" || youtubeController.text == "" || stepsController.text == "" || imageData.value == null) {
      showErrorSnackBar(content: "Please fill all the fields");
      return;
    } else {
      try {
        exercise.name = nameController.text;
        exercise.description = descriptionController.text;
        exercise.youtube = youtubeController.text;
        exercise.steps = stepsController.text.split(",");
        exercise.image = base64Encode(imageData.value!.toList());

        await Exercise.updateExercise(exercise);
        Get.back();
      } catch(e) {
        showErrorSnackBar(content: e.toString());
      }
    }
  }

  void handleClear() {
    nameController.text = "";
    descriptionController.text = "";
    youtubeController.text = "";
    stepsController.text = "";
    imageData.value = null;
  }
}

class UpdateExerciseDialog extends StatelessWidget {
  UpdateExerciseDialog({super.key, required this.exercise}) {
    controller.nameController.text = exercise.name;
    controller.descriptionController.text = exercise.description;
    controller.youtubeController.text = exercise.youtube;
    controller.stepsController.text = exercise.steps.join(",");
    controller.imageData.value = base64Decode(exercise.image);
  }

  final Exercise exercise;
  final controller = Get.put(UpdateExerciseController());

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 1050.w,
        height: 800.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
            width: 0.3.sp,
          ),
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Update Exercise',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40.h),
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Row(
                spacing: 140.w,
                children: [
                  Column(
                    spacing: 20.h,
                    children: [
                      buildTextField(
                        controller: controller.nameController,
                        label: "Name",
                        hint: "Enter name",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter name';
                          }
                          return null;
                        },
                      ),
                      buildTextField(
                        label: "Description",
                        hint: "Enter description",
                        maxLength: 200,
                        maxLines: 4,
                        controller: controller.descriptionController,
                      ),
                      buildTextField(
                        label: "Steps (seperated by comma)",
                        hint: "Enter Steps",
                        maxLength: 200,
                        maxLines: 4,
                        controller: controller.stepsController,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    spacing: 20.h,
                    children: [
                      SizedBox(height: 35.h),
                      buildTextField(
                        label: "Youtube Link",
                        hint: "Enter Youtube Link",
                        maxLength: 100,
                        controller: controller.youtubeController,
                      ),
                      // SizedBox(
                      //   width: 400.w,
                      //   height: 200.h,
                      //   child: imagePicker(),
                      // ),
                      Obx(() => SizedBox(
                        width: 400.w,
                        height: 200.h,
                        child: controller.imageData.value != null
                            ? Image.memory(controller.imageData.value!)
                            : Stack(
                          children: [
                            DropzoneView(
                              onCreated: (ctrl) => controller.fileController = ctrl,
                              onHover: () => controller.borderColor.value = Colors.blue,
                              onLeave: () => controller.borderColor.value = null,
                              onDropFiles: (files) {
                                if (files?.length != 1) {
                                  showErrorSnackBar(content: "Only single image file accepted");
                                }
                              },
                              onDropFile: (file) async {
                                final mime = await controller.fileController.getFileMIME(file);
                                if (mime == "image/png" || mime == "image/jpeg") {
                                  controller.imageData.value = await controller.fileController.getFileData(file);
                                } else {
                                  showErrorSnackBar(content: "Only PNG and JPEG files supported");
                                }
                              },
                            ),
                            imagePicker(controller.borderColor.value),
                          ],
                        ),
                      )),
                      SizedBox(height: 100.h),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: controller.handleClear,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.r),
                                )),
                            child: Text(
                              "Clear All",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          ElevatedButton(
                            onPressed: () => controller.handleSubmit(exercise),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.r),
                                )),
                            child: Text(
                              "Update",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// Widget newExercise() {
//   final controller = Get.put(CategoryController());
//   return Container(
//     padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
//     decoration: BoxDecoration(
//       color: Colors.white,
//       border: Border.all(
//         color: Colors.grey,
//         width: 0.3.sp,
//       ),
//       borderRadius: BorderRadius.circular(15.r),
//       boxShadow: [
//         BoxShadow(
//           color: Colors.grey,
//           offset: Offset(0.0, 1.0), //(x,y)
//           blurRadius: 3.0,
//         ),
//       ],
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Add new Exercise',
//           style: TextStyle(
//             fontSize: 24.sp,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         Row(
//           spacing: 140.w,
//           children: [
//             Column(
//               spacing: 20.h,
//               children: [
//                 buildTextField(
//                   controller: controller.nameController,
//                   label: "Name",
//                   hint: "Enter name",
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter name';
//                     }
//                     return null;
//                   },
//                 ),
//                 buildTextField(
//                   label: "Steps",
//                   hint: "Enter Steps",
//                   maxLength: 100,
//                   controller: controller.descriptionController,
//                 )
//               ],
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               spacing: 20.h,
//               children: [
//                 SizedBox(height: 35.h),
//                 buildTextField(
//                   label: "Youtube Link",
//                   hint: "Enter Youtube Link",
//                   maxLength: 100,
//                   controller: controller.descriptionController,
//                 ),
//                 imagePicker(),
//                 Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     ElevatedButton(
//                       onPressed: () {},
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.grey,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(5.r),
//                           )),
//                       child: Text(
//                         "Clear All",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 20.w,
//                     ),
//                     ElevatedButton(
//                       onPressed: () {},
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.blueAccent,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(5.r),
//                           )),
//                       child: Text(
//                         "Save",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ],
//         ).paddingSymmetric(horizontal: 20.w),
//       ],
//     ),
//   );
// }
