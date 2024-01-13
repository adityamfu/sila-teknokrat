import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../surat/views/surat_view.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          //menu2
          Container(
            height: 150,
            width: 2000,
            padding: EdgeInsets.all(15),
            color: Color.fromARGB(255, 194, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 120,
                  width: 90,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: IconButton(
                          onPressed: () {
                            Get.to(SuratView());
                          },
                          icon: Icon(
                            Icons.file_copy_rounded,
                            size: 30,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Buat Surat /Dokumen",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 120,
                  width: 90,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: IconButton(
                          onPressed: () {
                            // Get.offAllNamed(Routes.PKL);
                          },
                          icon: Icon(
                            Icons.group_sharp,
                            size: 30,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Pkl",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 120,
                  width: 90,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: IconButton(
                          onPressed: () {
                            // Get.offAllNamed(Routes.HOME);
                          },
                          icon: Icon(
                            Icons.school,
                            size: 30,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Skripsi",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 120,
                  width: 90,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: IconButton(
                          onPressed: () {
                            // Get.offAllNamed(Routes.UNGGAHDOK);
                          },
                          icon: Icon(
                            Icons.dashboard,
                            size: 30,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Unggah Dokumen",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          //menu3
          Container(
            height: 130,
            width: 2000,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 174, 174, 174),
              borderRadius: BorderRadius.circular(5.0),
            ),
            margin: EdgeInsets.all(6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  margin: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(10.0), // Ubah sesuai keinginan
                    image: DecorationImage(
                      image: AssetImage('assets/images/baner1.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: 200,
                  height: 200,
                  margin: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(10.0), // Ubah sesuai keinginan
                    image: DecorationImage(
                      image: AssetImage('assets/images/baner2.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Get.offAllNamed(Routes.DATA);
              },
              child: Text('Data'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Get.offAllNamed(Routes.SETTING);
            },
            child: Text("seting"),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),

        //botombar
      ),
    );
  }
}
