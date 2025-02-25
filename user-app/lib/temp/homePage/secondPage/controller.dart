import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'package:avicare/utils/utils.dart';
import 'package:avicare/model/protocols.dart';

class ProtocolListController extends GetxController {
  final protocolsList = Rx<List<Protocol>>([]);

  @override
  void onInit() {
    fetchProtocolsList();
    super.onInit();
  }

  Future<void> fetchProtocolsList() async {
    try {
      protocolsList.value = await Protocol.listProtocols();
    } catch(e) {
      safePrint(e);
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}