import 'package:get/get.dart';

import '../controllers/pkl_controller.dart';

class PklBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PklController>(
      () => PklController(),
    );
  }
}
