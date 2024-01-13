// auth_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  Rx<User?> firebaseUser = Rx<User?>(null);
  Rx<UserData?> userData = Rx<UserData?>(null);
  RxString error = RxString('');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController npmController = TextEditingController();
  final TextEditingController agamaController = TextEditingController();
  final TextEditingController jenisKelaminController = TextEditingController();
  final TextEditingController noTeleponController = TextEditingController();
  final TextEditingController prodiController = TextEditingController();
  final TextEditingController tempatLahirController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  void setError(String message) {
    error.value = message;
  }

  void clearError() {
    error.value = '';
  }

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(streamAuthStatus);
    firebaseUser.listen((user) {
      if (user != null) {
        loadUserData();
      }
    });
  }

  String? get currentUserEmail => firebaseUser.value?.email; // Add this getter

  Stream<User?> get streamAuthStatus => auth.authStateChanges();

  Future<bool> signup(String emailAddress, String password) async {
    try {
      UserCredential myUser = await auth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      await myUser.user!.sendEmailVerification();
      Get.defaultDialog(
        title: "Verifikasi email",
        middleText: "Kami telah mengirimkan verifikasi ke email $emailAddress.",
        onConfirm: () {
          Get.back(); // close dialog
          Get.back(); // login
        },
        textConfirm: "OK",
      );
      return true; // Signup success
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';

      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
        print('The account already exists for that email.');
      } else {
        errorMessage = 'An error occurred: ${e.message}';
        print('Error during signup: ${e.message}');
      }

      Get.snackbar(
        'Signup Error',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false; // Signup failed
    } catch (e) {
      print(e);
      return false; // Signup failed
    }
  }

  Future<bool> login(String emailAddress, String password) async {
    try {
      UserCredential myUser = await auth.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      if (myUser.user!.emailVerified) {
        if (await userDataIsComplete(myUser.user!.email!)) {
          Get.offAllNamed('/home');
        } else {
          Get.offAllNamed('/user_data_form');
        }
        return true; // Login success
      } else {
        Get.defaultDialog(
          title: "Verifikasi email",
          middleText: "Harap verifikasi email terlebih dahulu",
        );
        return false; // Email not verified
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';

      if (e.code == 'user-not-found') {
        errorMessage = "No user found for that email.";
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        errorMessage = "Wrong password provided for that user.";
        print('Wrong password provided for that user.');
      } else {
        errorMessage = "An error occurred: ${e.message}";
        print('Error during login: ${e.message}');
      }

      Get.snackbar(
        'Login Error',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false; // Login failed
    }
  }

  Future<bool> userDataIsComplete(String email) async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('complete_profiles')
          .where('email', isEqualTo: email)
          .get();

      return snapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking user data completeness: $e');
      return false;
    }
  }

  void logout() async {
    try {
      await auth.signOut();
      // Clear user sessions and credentials
      await clearUserData();
      Get.offAllNamed('/login');
    } catch (e) {
      print('Error during logout: $e');
    }
  }

  Future<void> clearUserData() async {
    firebaseUser.value = null;
    userData.value = null;
  }

  void resetPassword(String email) async {
    if (email != "" && GetUtils.isEmail(email)) {
      try {
        await auth.sendPasswordResetEmail(email: email);
        Get.defaultDialog(
          title: "Berhasil",
          middleText: "Kami telah mengirimkan reset password ke $email",
          onConfirm: () {
            Get.back();
            Get.back();
          },
          textConfirm: "OK",
        );
      } catch (e) {
        Get.defaultDialog(
          title: "Terjadi kesalahan",
          middleText: "Tidak dapat melakukan reset password.",
        );
      }
    } else {
      Get.defaultDialog(
        title: "Terjadi kesalahan",
        middleText: "Email tidak valid",
      );
    }
  }

  void printUserData(UserData userData) {
    print("Data Pengguna Lengkap:");
    print("Nama: ${userData.nama}");
    print("NPM: ${userData.npm}");
    print("Agama: ${userData.agama}");
    print("Jenis Kelamin: ${userData.jenisKelamin}");
    print("Nomor Telepon: ${userData.noTelepon}");
    print("Program Studi: ${userData.prodi}");
    print("Tempat Lahir: ${userData.tempatLahir}");
    print("Tanggal Lahir: ${userData.tanggalLahir}");

    // Get.offAllNamed('/home');
  }

  Future<void> loadUserData() async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('complete_profiles')
          .where('email', isEqualTo: auth.currentUser?.email)
          .get();

      if (snapshot.docs.isNotEmpty) {
        userData.value = UserData.fromMap(
            snapshot.docs.first.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  Future<void> saveUserDataToFirestore(UserData userData) async {
    try {
      await FirebaseFirestore.instance
          .collection('complete_profiles')
          .doc(auth.currentUser?.email)
          .set({
        'nama': userData.nama,
        'npm': userData.npm,
        'agama': userData.agama,
        'jenisKelamin': userData.jenisKelamin,
        'noTelepon': userData.noTelepon,
        'prodi': userData.prodi,
        'tempatLahir': userData.tempatLahir,
        'tanggalLahir': userData.tanggalLahir,
        'email': auth.currentUser?.email,
      });

      // Load the updated user data
      await loadUserData();
      print("Data Pengguna Lengkap:");
      print("Nama: ${userData.nama}");
      print("NPM: ${userData.npm}");
      print("Agama: ${userData.agama}");
      print("Jenis Kelamin: ${userData.jenisKelamin}");
      print("Nomor Telepon: ${userData.noTelepon}");
      print("Program Studi: ${userData.prodi}");
      print("Tempat Lahir: ${userData.tempatLahir}");
      print("Tanggal Lahir: ${userData.tanggalLahir}");

      // Jika penyimpanan sukses, mungkin tampilkan pesan atau lakukan sesuatu
      print('Data berhasil disimpan ke Firestore');
    } catch (e) {
      // Jika terjadi kesalahan, tampilkan pesan atau lakukan sesuatu
      print('Terjadi kesalahan: $e');
    }
  }
}
