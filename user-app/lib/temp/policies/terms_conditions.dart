import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:avicare/utils/utils.dart';

class TermsConditionsController extends GetxController {
  final content = "".obs;

  @override
  void onInit() {
    super.onInit();
    getFile();
  }

  Future<void> getFile() async {
    try {
      final response = await httpPostRequest(route: "/policies/terms/get", body: {});
      content.value = response["content"];
    } catch(e) {
      Fluttertoast.showToast(msg: "Unexpected error occurred, please try again!");
    }
  }
}

class TermsConditionsScreen extends StatelessWidget {
  TermsConditionsScreen({super.key});

  final controller = Get.put(TermsConditionsController());
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        surfaceTintColor: Colors.transparent,
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Row(
            children: [
              Material(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
                color: Colors.black12,
                child: InkWell(
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Ink(
                    padding: EdgeInsets.all(7),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  onTap: () {
                    Get.back();
                  },
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "Terms & Conditions",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Material(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.black45,
                child: InkWell(
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Ink(
                    padding: EdgeInsets.all(7),
                    child: Icon(
                      Icons.more_horiz,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
      body: Scrollbar(
        controller: scrollController,
        thumbVisibility: true,
        trackVisibility: true,
        child: Padding(
          padding: EdgeInsets.all(25),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Obx(() => Text(controller.content.value, style: TextStyle(color: Colors.white),)),
          ),
        ),
      ),
    );
  }
}
