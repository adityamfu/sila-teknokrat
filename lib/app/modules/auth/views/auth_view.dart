import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import 'register_widget.dart';

class AuthView extends StatelessWidget {
  final AuthController _authController = Get.put(AuthController());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authentication'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                _authController.login(
                  emailController.text,
                  passwordController.text,
                );
              },
              child: Text('Login'),
            ),
            SizedBox(
                height: 16), // Jarak antara tombol login dan tombol register
            TextButton(
              onPressed: () {
                // Arahkan ke widget pendaftaran (RegisterWidget)
                Get.to(() => RegisterWidget());
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
