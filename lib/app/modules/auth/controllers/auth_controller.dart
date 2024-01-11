import 'package:get/get.dart';
import 'package:dio/dio.dart';

import '../../../routes/app_pages.dart';

class AuthController extends GetxController {
  static final String apiUrl = "http://localhost/api_sila/connection.php";
  static final String apiReg = "http://localhost/api_sila/register.php";
  final Dio _dio = Dio();

  Future<void> login(String email, String password) async {
    try {
      final response = await _dio.get(apiUrl);
      if (response.statusCode == 200) {
        final List<dynamic> users = response.data;

        final user = users.firstWhere(
          (user) => user['email'] == email && user['password'] == password,
          orElse: () => null,
        );

        if (user != null) {
          print("Login successful");
          // Handle login success
          Get.toNamed(Routes.HOME); // Arahkan ke HomeView setelah login
        } else {
          print("Invalid credentials");
          // Handle invalid credentials
        }
      } else {
        print("Error: ${response.statusCode}");
        // Handle error
      }
    } catch (e) {
      print("Error: $e");
      // Handle error
    }
  }

  Future<void> register({
    required String username,
    required String password,
    required String email,
    required String npm,
    required String agama,
    required String jenisKelamin,
    required String noTelpon,
    required String prodi,
    required DateTime tanggalLahir,
    required String tempatLahir,
  }) async {
    try {
      final response = await _dio.post(
        apiReg,
        data: {
          'username': username,
          'password': password,
          'email': email,
          'npm': npm,
          'agama': agama,
          'jenis_kelamin': jenisKelamin,
          'no_telpon': noTelpon,
          'prodi': prodi,
          'tanggal_lahir': tanggalLahir.toIso8601String(),
          'tempat_lahir': tempatLahir,
        },
      );

      if (response.statusCode == 200) {
        print("Registration successful");
        // Handle registration success
      } else {
        print("Error: ${response.statusCode}");
        // Handle error
      }
    } catch (e) {
      print("Error: $e");
      // Handle error
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
