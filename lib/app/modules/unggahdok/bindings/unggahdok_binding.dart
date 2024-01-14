import 'package:get/get.dart';

import '../controllers/unggahdok_controller.dart';

class UnggahdokBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UnggahdokController>(
      () => UnggahdokController(),
    );
  }
}
