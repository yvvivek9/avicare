import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:multiselect/multiselect.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'dart:typed_data';

import 'package:avicare_web/utils/utils.dart';
import 'package:avicare_web/models/protocol.dart';
import 'package:avicare_web/models/exercise.dart';
import '../../widget/build_text_field.dart';
import '../../widget/image_picker.dart';

class NewProtocolController extends GetxController {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  late DropzoneViewController fileController;
  final imageData = Rx<Uint8List?>(null);
  final borderColor = Rx<Color?>(null);

  final selectedExercises = Rx<List<CompactExerciseData>>([]);
  final exercises = Rx<List<CompactExerciseData>>([]);

  @override
  void onInit() {
    super.onInit();
    loadExercises();
  }

  Future<void> loadExercises() async {
    try {
      exercises.value = await CompactExerciseData.list();
    } catch (e) {
      showErrorSnackBar(content: e.toString());
    }
  }

  Future<void> handleSubmit() async {
    if (nameController.text == "" || descriptionController.text == "" || imageData.value == null) {
      showErrorSnackBar(content: "Please fill all the fields");
      return;
    } else {
      try {
        await Protocol.addProtocol(Protocol(
          id: "",
          name: nameController.text,
          description: descriptionController.text,
          image: base64Encode(imageData.value!.toList()),
          exercises: selectedExercises.value.map((e) => e.id).toList(),
        ));
        Get.back();
      } catch (e) {
        showErrorSnackBar(content: e.toString());
      }
    }
  }

  void handleClear() {
    nameController.text = "";
    descriptionController.text = "";
    imageData.value = null;
    selectedExercises.value = [];
  }
}

class NewProtocolDialog extends StatelessWidget {
  const NewProtocolDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: GetBuilder<NewProtocolController>(
        init: NewProtocolController(),
        builder: (controller) => Container(
          width: 1050.w,
          height: 700.h,
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
                'Add new Protocol',
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
                        SizedBox(height: 50.h),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      spacing: 20.h,
                      children: [
                        Obx(
                          () => SizedBox(
                            width: 400.w,
                            height: 100.h,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Select Exercises",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                DropDownMultiSelect(
                                  options: controller.exercises.value,
                                  selectedValues: controller.selectedExercises.value,
                                  onChanged: (values) => controller.selectedExercises.value = values,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Obx(() => SizedBox(
                              width: 400.w,
                              height: 200.h,
                              child: controller.imageData.value != null
                                  ? Row(
                                      children: [
                                        Expanded(child: Image.memory(controller.imageData.value!)),
                                        IconButton(onPressed: () => controller.imageData.value = null, icon: Icon(Icons.close, color: Colors.black))
                                      ],
                                    )
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
                        SizedBox(height: 70.h),
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
                              onPressed: controller.handleSubmit,
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.r),
                                  )),
                              child: Text(
                                "Save",
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
      ),
    );
  }
}
