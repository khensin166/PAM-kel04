import 'package:cis_kel04_app/views/mahasiswa/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class button extends StatelessWidget {
  const button({
    super.key,
    required this.size,
    required this.hintText,
  });

  final Size size;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF21899C),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 10.0,
      ),
      child: Container(
        height: size.height / 13,
        alignment: Alignment.center,
        child: Text(
          hintText,
          style: GoogleFonts.inter(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
