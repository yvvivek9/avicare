import 'package:avicare_web/utils/utils.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:avicare_web/models/protocol.dart';
import 'widgets/new_protocol.dart';
import 'widgets/update_protocol.dart';

class ProtocolsPageController extends GetxController {
  final protocols = Rx<List<Protocol>>([]);

  @override
  void onInit() {
    super.onInit();
    fetchProtocolList();
  }

  Future<void> fetchProtocolList() async {
    try {
      protocols.value = await Protocol.listProtocols();
    } catch(e) {
      showErrorSnackBar(content: e.toString());
    }
  }

  Future<void> handleAddProtocol() async {
    await showDialog(context: Get.context!, builder: (ctx) => NewProtocolDialog());
    fetchProtocolList();
  }

  Future<void> handleDeleteProtocol(Protocol protocol) async {
    try {
      final confirmation = await requestConfirmation(title: "Confirm deletion", content: "${protocol.name} protocol will be permanently deleted.");
      if (!confirmation) return;
      await Protocol.deleteProtocol(protocol);
      fetchProtocolList();
    } catch(e) {
      showErrorSnackBar(content: e.toString());
    }
  }

  Future<void> handleUpdateProtocol(Protocol protocol) async {
    await showDialog(context: Get.context!, builder: (ctx) => UpdateProtocolDialog(protocol: protocol));
    fetchProtocolList();
  }
}