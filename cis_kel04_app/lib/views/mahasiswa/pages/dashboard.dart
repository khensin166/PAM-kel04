import 'package:cis_kel04_app/controllers/MhsAuthenticationController.dart';
import 'package:cis_kel04_app/models/mahasiswa.dart';
import 'package:cis_kel04_app/views/mahasiswa/pages/izinKeluar.dart';
import 'package:cis_kel04_app/views/mahasiswa/pages/ruangan.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/card_widgets.dart';

class MhsDashboard extends StatefulWidget {
  const MhsDashboard({super.key});

  @override
  State<MhsDashboard> createState() => _MhsDashboardState();
}

class _MhsDashboardState extends State<MhsDashboard> {
  final MhsAuthenticationController _mhsAuthenticationController =
      Get.put(MhsAuthenticationController());

  late Future<MahasiswaModel?> _mahasiswaFuture;

  @override
  void initState() {
    super.initState();
    _mahasiswaFuture = _mhsAuthenticationController.getDashboardData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cis App'),
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.dashboard),
          )
        ],
      ),
      body: FutureBuilder<MahasiswaModel?>(
        future: _mahasiswaFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error fetching data'),
            );
          } else {
            MahasiswaModel? mahasiswa = snapshot.data;

            return Center(
              child: Container(
                padding: EdgeInsets.fromLTRB(16, 41, 16, 16),
                color: Colors.white,
                child: ListView(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Selamat Datang",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w800),
                        ),
                        Icon(
                          Icons.notifications,
                          color: Colors.grey,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        mahasiswa?.nama ?? "No Name",
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w800),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Apa yang ingin anda lakukan hari ini?",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Container(
                      height: 10,
                    ),
                    jobs_item(context)
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Container jobs_item(BuildContext context) {
    final MhsAuthenticationController _mhsAuthenticationController =
        Get.put(MhsAuthenticationController());

    return Container(
      height: MediaQuery.of(context).size.height,
      child: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 30,
        mainAxisSpacing: 30,
        crossAxisCount: 2,
        children: [
          card_widgets(
            hintCard: 'req izin ruangan',
            image: 'assets/room.png',
            onPressed: () {
              Get.to(() => const IzinRuangan());
            },
            color: Color(0xffE9FFEB),
          ),
          card_widgets(
            hintCard: 'req surat',
            image: 'assets/surat.png',
            onPressed: () {},
            color: Color(0xffE9FFEB),
          ),
          card_widgets(
            hintCard: 'req izin keluar',
            image: 'assets/exit.png',
            onPressed: () {
              Get.to(() => const IzinKeluar());
            },
            color: Color(0xffE9FFEB),
          ),
          card_widgets(
            hintCard: 'req izin bermalam',
            image: 'assets/ib.png',
            onPressed: () {},
            color: Color(0xffE9FFEB),
          ),
          card_widgets(
            hintCard: 'beli kaos',
            image: 'assets/baju.png',
            onPressed: () {},
            color: Color(0xffE9FFEB),
          ),
          card_widgets(
            hintCard: 'logout',
            image: 'assets/logout.png',
            onPressed: () {
              _mhsAuthenticationController.logout();
            },
            color: Colors.red.shade50,
          ),
        ],
      ),
    );
  }
}
