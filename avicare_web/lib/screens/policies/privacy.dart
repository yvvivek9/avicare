import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:avicare_web/models/policy.dart';
import 'package:avicare_web/utils/utils.dart';
import 'widgets.dart';

class PrivacyPolicyController extends GetxController {
  final textController = TextEditingController();
  late Policy privacyPolicy;

  @override
  void onInit() {
    super.onInit();
    getFile();
  }

  Future<void> getFile() async {
    try {
      privacyPolicy = await Policy.getPrivacyPolicy();
      textController.text = privacyPolicy.content;
    } catch (e) {
      showErrorSnackBar(content: e.toString());
    }
  }

  Future<void> handleUpdate() async {
    try {
      privacyPolicy.content = textController.text;
      final response = await httpPostRequest(route: "/admin/policies/privacy/update", body: privacyPolicy.toJSON());
      getFile();
      showSuccessSnackBar(content: response["detail"]);
    } catch (e) {
      showErrorSnackBar(content: e.toString());
    }
  }
}

class PrivacyPolicyPage extends StatelessWidget {
  PrivacyPolicyPage({super.key});

  final controller = Get.put(PrivacyPolicyController());

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
                "Privacy Policy Editor",
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
