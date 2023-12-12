import 'package:cis_kel04_app/controllers/ik_Controller.dart';
import 'package:cis_kel04_app/models/ik_model.dart';
import 'package:cis_kel04_app/views/mahasiswa/pages/izinKeluarDetail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class IzinKeluar extends StatefulWidget {
  const IzinKeluar({super.key});

  @override
  State<IzinKeluar> createState() => _IzinKeluarState();
}

class _IzinKeluarState extends State<IzinKeluar> {
  final IKController _ikController = Get.put(IKController());
  @override
  Widget build(BuildContext context) {
    TextStyle titles = const TextStyle(
        fontStyle: FontStyle.italic, fontWeight: FontWeight.bold);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Request Izin Keluar"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Izin Keluar",
                    style: GoogleFonts.poppins(
                        fontSize: 30, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Get.to(() => const IzinKeluarDetail());
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      child: Container(
                        height: size.height / 15,
                        width: size.width / 2.5,
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Text(
                              "request Izin Keluar",
                              style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Icon(
                              Icons.add,
                              color: Colors.white,
                            )
                          ],
                        ),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: SingleChildScrollView(
                      child: Obx(() {
                        return _ikController.isLoading.value
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : DataTable(
                                columns: <DataColumn>[
                                  DataColumn(
                                    label: Text('No', style: titles),
                                    numeric: true,
                                  ),
                                  DataColumn(
                                    label: Text('Keterangan', style: titles),
                                  ),
                                  DataColumn(
                                    label: Text('Status', style: titles),
                                  ),
                                ],
                                rows: _ikController.data_ik.value
                                    .map((izinKeluar) {
                                  int rowNumber = _ikController.data_ik.value
                                          .indexOf(izinKeluar) +
                                      1;
                                  Color cellColor;
                                  if (izinKeluar.status == 'pending') {
                                    cellColor = Colors.yellow.shade100;
                                  } else if (izinKeluar.status == 'approved') {
                                    cellColor = Colors.green.shade50;
                                  } else if (izinKeluar.status == 'rejected') {
                                    cellColor = Colors.red.shade50;
                                  } else {
                                    // Default color if status is neither 'pending' nor 'accept'
                                    cellColor = Colors.grey;
                                  }
                                  return DataRow(
                                      color:
                                          MaterialStateProperty.all(cellColor),
                                      cells: [
                                        DataCell(Text(rowNumber.toString())),
                                        DataCell(
                                            Text(izinKeluar.keterangan ?? '')),
                                        DataCell(Text(izinKeluar.status ?? '')),
                                      ]);
                                }).toList(),
                              );
                      }),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
