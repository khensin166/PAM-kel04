import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class button_widget extends StatefulWidget {
  const button_widget({
    Key? key,
    required this.size,
    required this.hintText,
    required this.onPressed,
    required this.value,
  }) : super(key: key);

  final Size size;
  final String hintText;
  final VoidCallback onPressed;
  final bool value;

  @override
  State<button_widget> createState() => _button_widgetState();
}

class _button_widgetState extends State<button_widget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF21899C),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 10.0,
      ),
      child: Container(
        height: widget.size.height / 13,
        alignment: Alignment.center,
        child: Obx(() {
          return widget.value
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                )
              : Text(
                  widget.hintText,
                  style: GoogleFonts.inter(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                );
        }),
      ),
    );
  }
}
