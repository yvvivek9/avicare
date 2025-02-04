import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'package:avicare/utils/utils.dart';
import 'package:avicare/model/protocols.dart';

class ProtocolDetailsController extends GetxController {
  final protocol = Protocol(name: " -- ", exercises: []).obs;

  Future<void> fetchProtocolDetails(String protocolID) async {
    try {
      Get.context!.loaderOverlay.show();
      protocol.value = await Protocol.fetchProtocolByID(protocolID);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      Get.context!.loaderOverlay.hide();
    }
  }
}