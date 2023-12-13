import 'package:cis_kel04_app/models/ik_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class IzinData extends StatelessWidget {
  const IzinData({
    super.key,
    required this.izinKeluarModel,
    required this.onApprovePressed,
    required this.onRejectPressed,
  });

  final IzinKeluarModel izinKeluarModel;
  final VoidCallback onApprovePressed;
  final VoidCallback onRejectPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
      padding: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            izinKeluarModel.mahasiswa!.nama!,
            style: GoogleFonts.poppins(),
          ),
          Text(
            izinKeluarModel.mahasiswa!.email!,
            style: GoogleFonts.poppins(fontSize: 10),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            izinKeluarModel.keterangan!,
          ),
          Row(
            children: [
              IconButton(
                onPressed: onApprovePressed,
                icon: Icon(
                  Icons.check,
                  color: Colors.green,
                ),
              ),
              IconButton(
                onPressed: onRejectPressed,
                icon: Icon(Icons.close),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
