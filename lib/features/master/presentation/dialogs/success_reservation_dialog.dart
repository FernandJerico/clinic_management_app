import 'package:clinic_management_app/core/components/buttons.dart';
import 'package:clinic_management_app/core/extensions/build_context_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

import '../../../setting/data/datasource/cwb_print.dart';
import '../bloc/data_patient/data_patient_bloc.dart';

class SuccessReservationDialog extends StatefulWidget {
  final int queueNumber;
  final String? patientName;
  final String? doctorName;
  final String? jam;
  const SuccessReservationDialog(
      {super.key,
      required this.queueNumber,
      required this.patientName,
      this.doctorName,
      this.jam});

  @override
  State<SuccessReservationDialog> createState() =>
      _SuccessReservationDialogState();
}

class _SuccessReservationDialogState extends State<SuccessReservationDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    context
                        .read<DataPatientBloc>()
                        .add(const DataPatientEvent.getPatients());
                  },
                  icon: const Icon(Icons.close)),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    height: 200,
                    width: 200,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.blue),
                    child: Center(
                      child: Text(
                        widget.queueNumber.toString(),
                        style: GoogleFonts.poppins(
                            fontSize: 100,
                            fontWeight: FontWeight.w900,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                      child: Text(
                    'Berikut Adalah\nNomor Antrian Pasien',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  )),
                  const SizedBox(height: 24),
                  Button.filled(
                      onPressed: () async {
                        final printValue = await CwbPrint.instance.printAntrian(
                          noAntrian: int.parse(widget.queueNumber.toString())
                              .toString(),
                          namaPasien: widget.patientName.toString(),
                          namaDokter: widget.doctorName.toString(),
                          jam: widget.jam.toString(),
                        );
                        await PrintBluetoothThermal.writeBytes(printValue);
                        if (context.mounted) {
                          context.pop();
                        }
                      },
                      label: 'Print'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
