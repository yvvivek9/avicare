import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'package:avicare/utils/utils.dart';
import 'package:avicare/model/protocols.dart';

class ProtocolDetailsController extends GetxController {
  final protocol = Protocol(id: "", name: " -- ", exercises: [], description: "", image: "").obs;

  Future<void> fetchProtocolDetails(String protocolName) async {
    try {
      Get.context!.loaderOverlay.show();
      final list = await Protocol.listProtocols();
      final found = list.firstWhereOrNull((e) => e.id == protocolName);
      if (found == null) {
        Get.back();
        Fluttertoast.showToast(msg: "Protocol not found.");
      }
      protocol.value = found!;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      Get.context!.loaderOverlay.hide();
    }
  }
}