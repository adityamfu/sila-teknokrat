import 'package:get/get.dart';

import '../controllers/surat_controller.dart';

class SuratBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SuratController>(
      () => SuratController(),
    );
  }
}
