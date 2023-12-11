import 'package:cis_kel04_app/controllers/ik_Controller.dart';
import 'package:cis_kel04_app/views/widgets/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IzinKeluarDetail extends StatefulWidget {
  const IzinKeluarDetail({super.key});

  @override
  State<IzinKeluarDetail> createState() => _IzinKeluarDetailState();
}

class _IzinKeluarDetailState extends State<IzinKeluarDetail> {
  DateTime dateTime = DateTime(2022, 12, 24, 5, 30);
  final TextEditingController _berangkatController = TextEditingController();
  final TextEditingController _kembaliController = TextEditingController();
  final TextEditingController _keteranganController = TextEditingController();
  final IKController _ikController = Get.put(IKController());

  @override
  Widget build(BuildContext context) {
    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minutes = dateTime.minute.toString().padLeft(2, '0');
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Izin Keluar'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Form Pengisian ik'),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  final date = await pickDate();
                  if (date == null) return;
                  setState(() => dateTime = date);
                },
                child:
                    Text('${dateTime.year}/${dateTime.month}/${dateTime.day}')),
            ElevatedButton(
                onPressed: () async {
                  final time = await pickTime();
                  if (time == null) return;
                  final newDateTime = DateTime(dateTime.year, dateTime.month,
                      dateTime.day, time.hour, time.minute);

                  setState(() => dateTime = newDateTime);
                },
                child: Text('$hours:$minutes')),
          ],
        ),
      ),
    );
  }

  Future pickDateTime() async {
    DateTime? date = await pickDate();
    if (date == null) return;

    TimeOfDay? time = await pickTime();
    if (time == null) return;

    final dateTime =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100));

  Future<TimeOfDay?> pickTime() => showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));
}
