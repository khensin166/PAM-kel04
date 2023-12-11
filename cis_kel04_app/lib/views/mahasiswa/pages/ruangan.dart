import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IzinRuangan extends StatefulWidget {
  const IzinRuangan({super.key});

  @override
  State<IzinRuangan> createState() => _IzinRuanganState();
}

class _IzinRuanganState extends State<IzinRuangan> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Request Izin Ruangan"),
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
                    "Izin Ruangan",
                    style: GoogleFonts.poppins(
                        fontSize: 30, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        print("object");
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
                            SizedBox(
                              width: 8,
                            ),
                            Icon(
                              Icons.add,
                              color: Colors.white,
                            )
                          ],
                        ),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
