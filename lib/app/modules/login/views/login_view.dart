import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final AuthController cAuth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      body: Container(
        color: Color.fromARGB(255, 1, 9, 71),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
             Container(
                // margin: EdgeInsets.all(10),
                color: Color.fromARGB(255, 1, 9, 71),
                height: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 95,
                      height: 95,
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Spacer antara gambar dan teks
                    Container(
                      height: 100,
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Text(
                            "UNIVERSITAS TEKNOKRAT",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            "INDONESIA",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 35,
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .center, // Sesuaikan posisi teks di dalam container
                  children: [
                    Text(
                      "Disiplin, Bermutu, Kreatif, dan Inovatif",
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber[600],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .center, // Sesuaikan posisi teks di dalam container
                  children: [
                    Text(
                      "Sistem Informasi Layanan Akademik",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .center, // Sesuaikan posisi teks di dalam container
                  children: [
                    Text(
                      "Silakan Login terlebih Dahulu",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(40), // Adjust padding as needed
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: controller.cEmail,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.person),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border: InputBorder
                              .none, // Menghilangkan garis bawah teks
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      height: 45.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextField(
                        controller: controller.cPass,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                          border: InputBorder
                              .none, // Menghilangkan garis bawah teks
                        ),
                        obscureText: true,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 180,
                      child: ElevatedButton(
                  onPressed: () async {
                    bool loginResult = await cAuth.login(
                        controller.cEmail.text, controller.cPass.text);
                        if (loginResult) {
                      print('login succes');
                    } else {
                      print('login error');
                    }
                        },
                        child: Text("Login"),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Get.toNamed(Routes.RESET_PASSWORD),
                    child: Text("Reset Password",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    ),
                  ),
                    ),
                    SizedBox(
                  height: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () => Get.toNamed(Routes.SIGNUP),
                      child: Text("Register",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      )
                    )
                  ],
                ),
                  ],
                ),
              ),
          ],
        ),
      ),
      )
    );
  }
}
