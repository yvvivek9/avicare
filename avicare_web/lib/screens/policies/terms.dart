import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:avicare_web/models/policy.dart';
import 'package:avicare_web/utils/utils.dart';
import 'widgets.dart';

class TermsConditionsController extends GetxController {
  final textController = TextEditingController();
  late Policy termsConditions;

  @override
  void onInit() {
    super.onInit();
    getFile();
  }

  Future<void> getFile() async {
    try {
      termsConditions = await Policy.getTermsConditions();
      textController.text = termsConditions.content;
    } catch (e) {
      showErrorSnackBar(content: e.toString());
    }
  }

  Future<void> handleUpdate() async {
    try {
      termsConditions.content = textController.text;
      final response = await httpPostRequest(route: "/admin/policies/terms/update", body: termsConditions.toJSON());
      getFile();
      showSuccessSnackBar(content: response["detail"]);
    } catch (e) {
      showErrorSnackBar(content: e.toString());
    }
  }
}

class TermsConditionsPage extends StatelessWidget {
  TermsConditionsPage({super.key});

  final controller = Get.put(TermsConditionsController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1024.h,
      width: 1150.w,
      child: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Terms & Conditions Editor",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: InputField(
                controller: controller.textController,
                label: "",
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Spacer(),
                BuildElevatedButton(
                  onTap: controller.handleUpdate,
                  background: Colors.black,
                  foreground: Colors.white,
                  child: Text("Update"),
                ),
                Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
