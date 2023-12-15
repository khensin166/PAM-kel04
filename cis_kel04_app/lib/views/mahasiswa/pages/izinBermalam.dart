import 'package:cis_kel04_app/views/mahasiswa/pages/izinBermalamDetail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controllers/ib_Controller.dart';

class IzinBermalam extends StatefulWidget {
  const IzinBermalam({super.key});

  @override
  State<IzinBermalam> createState() => _IzinBermalamState();
}

class _IzinBermalamState extends State<IzinBermalam> {
  final IBController _ibController = Get.put(IBController());

  @override
  Widget build(BuildContext context) {
    TextStyle titles = const TextStyle(
        fontStyle: FontStyle.italic, fontWeight: FontWeight.bold);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Request Izin Bermalam"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Histori Izin Bermalam",
                    style: GoogleFonts.poppins(
                        fontSize: 30, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Get.to(() => const IzinBermalamDetail());
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      child: Container(
                        height: size.height / 15,
                        width: size.width / 3,
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Text(
                              "request IB",
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
                        return _ibController.isLoading.value
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : DataTable(
                                columnSpacing: 40,
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
                                  DataColumn(
                                    label: Text('Action', style: titles),
                                  ),
                                ],
                                rows: _ibController.data_ib.value
                                    .map((izinBermalam) {
                                  int rowNumber = _ibController.data_ib.value
                                          .indexOf(izinBermalam) +
                                      1;
                                  Color cellColor;
                                  if (izinBermalam.status == 'pending') {
                                    cellColor = Colors.yellow.shade100;
                                  } else if (izinBermalam.status ==
                                      'approved') {
                                    cellColor = Colors.green.shade50;
                                  } else if (izinBermalam.status ==
                                      'rejected') {
                                    cellColor = Colors.red.shade50;
                                  } else if (izinBermalam.status == 'cancel') {
                                    // Default color if status is neither 'pending' nor 'accept'
                                    cellColor = Colors.grey;
                                  } else {
                                    cellColor = Colors.grey;
                                  }
                                  return DataRow(
                                      color:
                                          MaterialStateProperty.all(cellColor),
                                      cells: [
                                        DataCell(Text(rowNumber.toString())),
                                        DataCell(Text(
                                            izinBermalam.keterangan ?? '')),
                                        DataCell(
                                            Text(izinBermalam.status ?? '')),
                                        DataCell(TextButton(
                                          onPressed: (izinBermalam.status ==
                                                      'pending' ||
                                                  izinBermalam.status ==
                                                      'approved')
                                              ? () {
                                                  _ibController.updateStatus(
                                                      izinBermalam.id,
                                                      'cancel');
                                                }
                                              : null,
                                          child: Text('cancel'),
                                        )),
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
