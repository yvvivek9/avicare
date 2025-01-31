import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:avicare/utils/utils.dart';
import 'model.dart';

class ProtocolListController extends GetxController {
  final protocolsList = Rx<List<Protocol>>([]);

  @override
  void onInit() {
    fetchProtocolsList();
    super.onInit();
  }

  Future<void> fetchProtocolsList() async {
    try {
      protocolsList.value = await Protocol.fetchProtocolList();
    } catch(e) {
      safePrint(e);
      Fluttertoast.showToast(msg: "Unexpected error occurred!");
    }
  }
}