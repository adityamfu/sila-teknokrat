import 'package:get/get.dart';

import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/surat/bindings/surat_binding.dart';
import '../modules/surat/views/surat_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/complete_profile.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/pkl/bindings/pkl_binding.dart';
import '../modules/pkl/views/pkl_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/reset_password/bindings/reset_password_binding.dart';
import '../modules/reset_password/views/reset_password_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/suket/bindings/suket_binding.dart';
import '../modules/suket/views/suket_view.dart';
import '../modules/unggahdok/bindings/unggahdok_binding.dart';
import '../modules/unggahdok/views/unggahdok_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(name: '/user_data_form', page: () => UserDataFormPage()),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.SURAT,
      page: () => SuratView(),
      binding: SuratBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.SUKET,
      page: () => const SuketView(),
      binding: SuketBinding(),
    ),
    GetPage(
      name: _Paths.PKL,
      page: () => const PklView(),
      binding: PklBinding(),
    ),
    GetPage(
      name: _Paths.UNGGAHDOK,
      page: () => const UnggahdokView(),
      binding: UnggahdokBinding(),
    ),
  ];
}
