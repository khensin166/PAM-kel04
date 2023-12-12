import 'package:cis_kel04_app/constants/constants.dart';
import 'package:cis_kel04_app/controllers/ik_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IzinKeluarDetail extends StatefulWidget {
  const IzinKeluarDetail({Key? key}) : super(key: key);

  @override
  State<IzinKeluarDetail> createState() => _IzinKeluarDetailState();
}

class _IzinKeluarDetailState extends State<IzinKeluarDetail> {
  DateTime berangkatDateTime = DateTime(2022, 12, 24, 5, 30);
  DateTime kembaliDateTime = DateTime(2022, 12, 24, 5, 30);

  final TextEditingController _keteranganController = TextEditingController();
  final IKController _ikController = Get.put(IKController());

  @override
  Widget build(BuildContext context) {
    final berangkatHours = berangkatDateTime.hour.toString().padLeft(2, '0');
    final berangkatMinutes =
        berangkatDateTime.minute.toString().padLeft(2, '0');

    final kembaliHours = kembaliDateTime.hour.toString().padLeft(2, '0');
    final kembaliMinutes = kembaliDateTime.minute.toString().padLeft(2, '0');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Izin Keluar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            const Text(
              'Request Izin Keluar',
              style: heading1,
            ),
            const SizedBox(
              height: 20,
            ),
            _buildDateTimePicker(
              label: 'Rencana Berangkat',
              dateTime: berangkatDateTime,
              onDateTimeChanged: (date) {
                setState(() => berangkatDateTime = date);
              },
            ),
            _buildDateTimePicker(
              label: 'Rencana Kembali',
              dateTime: kembaliDateTime,
              onDateTimeChanged: (date) {
                setState(() => kembaliDateTime = date);
              },
            ),
            const Text(
              'Keterangan',
              style: heading2,
            ),
            TextField(
              controller: _keteranganController,
              maxLines: 20,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_keteranganController.text.isNotEmpty) {
                  await _ikController.createDataIK(
                    keterangan: _keteranganController.text,
                    berangkat: berangkatDateTime,
                    kembali: kembaliDateTime,
                  );
                }
              },
              child: Text('Kirim'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateTimePicker({
    required String label,
    required DateTime dateTime,
    required Function(DateTime) onDateTimeChanged,
  }) {
    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minutes = dateTime.minute.toString().padLeft(2, '0');

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: heading2,
          textAlign: TextAlign.left,
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () async {
            final date = await pickDateTime(dateTime);
            if (date == null) return;
            onDateTimeChanged(date);
          },
          child: Text(
              '${dateTime.year}/${dateTime.month}/${dateTime.day} $hours:$minutes'),
        ),
      ],
    );
  }

  Future<DateTime?> pickDateTime(DateTime initialDateTime) async {
    DateTime? date = await pickDate(initialDateTime);
    if (date == null) return null;

    TimeOfDay? time = await pickTime(initialDateTime);
    if (time == null) return null;

    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  Future<DateTime?> pickDate(DateTime initialDate) => showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
      );

  Future<TimeOfDay?> pickTime(DateTime initialTime) => showTimePicker(
        context: context,
        initialTime:
            TimeOfDay(hour: initialTime.hour, minute: initialTime.minute),
      );
}
