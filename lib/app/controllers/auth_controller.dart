// auth_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  Rx<User?> firebaseUser = Rx<User?>(null);
  Rx<UserData?> userData = Rx<UserData?>(null);

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

  void signup(String emailAddress, String password) async {
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
          Get.back(); //close dialog
          Get.back(); //login
        },
        textConfirm: "OK",
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  void lgin(String emailAddress, String password) async {
    try {
      UserCredential myUser = await auth.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      if (myUser.user!.emailVerified) {
        // Load user data when the authentication status changes
        await loadUserData();

        if (userData.value != null) {
          Get.offAllNamed('/home');
        } else {
          Get.offAllNamed('/user_data_form');
        }
      } else {
        Get.defaultDialog(
          title: "Verifikasi email",
          middleText: "Harap verifikasi email terlebih dahulu",
        );
      }
    } on FirebaseAuthException catch (e) {
      // Handle login exceptions
      print("Login error: $e");
      // You might want to display an error message to the user
    }
  }

  void login(String emailAddress, String password) async {
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
      } else {
        Get.defaultDialog(
          title: "Verifikasi email",
          middleText: "Harap verifikasi email terlebih dahulu",
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.defaultDialog(
          title: "Terjadi kesalahan",
          middleText: "No user found for that email.",
        );
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Get.defaultDialog(
          title: "Terjadi kesalahan",
          middleText: "Wrong password provided for that user.",
        );
        print('Wrong password provided for that user.');
      }
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
