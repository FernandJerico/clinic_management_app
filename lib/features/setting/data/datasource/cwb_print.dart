import 'package:clinic_management_app/core/extensions/int_ext.dart';
import 'package:clinic_management_app/features/history/data/models/response/history_transaction_response_model.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:intl/intl.dart';

import '../../../patient-schedule/data/models/response/service_order_response_model.dart';

class CwbPrint {
  CwbPrint._init();

  static final CwbPrint instance = CwbPrint._init();

  Future<List<int>> printOrder(
    HistoryTransaction transaction,
    List<ServiceOrder> services,
  ) async {
    List<int> bytes = [];

    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);

    bytes += generator.reset();
    bytes += generator.text('Klinik Pratama Fuji',
        styles: const PosStyles(
          bold: true,
          align: PosAlign.center,
          height: PosTextSize.size1,
          width: PosTextSize.size1,
        ));

    bytes += generator.text('Jl. Evakuasi No.60, RT.01/RW.04',
        styles: const PosStyles(bold: true, align: PosAlign.center));
    bytes += generator.text(
        'Kalitanjung Timur, Harjamukti,\nKota Cirebon, Jawa Barat.',
        styles: const PosStyles(bold: true, align: PosAlign.center));
    bytes += generator.text(
        'Date : ${DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now())}',
        styles: const PosStyles(bold: false, align: PosAlign.center));
    bytes += generator.text('WA: 0851-7171-5191 | IG: @klinikpratamafuji',
        styles: const PosStyles(bold: true, align: PosAlign.center));

    bytes += generator.hr(ch: '-');

    bytes += generator.feed(1);
    bytes += generator.text('Layanan & Obat:',
        styles: const PosStyles(bold: false, align: PosAlign.left));
    //for from data
    for (final service in services) {
      bytes += generator.text(service.name!,
          styles: const PosStyles(align: PosAlign.left));

      bytes += generator.row([
        PosColumn(
          text: '${service.price!.currencyFormatRp} x ${service.quantity}',
          width: 8,
          styles: const PosStyles(align: PosAlign.left),
        ),
        PosColumn(
          text: service.price!.currencyFormatRp,
          width: 4,
          styles: const PosStyles(align: PosAlign.right),
        ),
      ]);
    }

    bytes += generator.hr(ch: '-');

    bytes += generator.feed(1);

    bytes += generator.row([
      PosColumn(
        text: 'Total',
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: transaction.totalPrice!.currencyFormatRp,
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += generator.row([
      PosColumn(
        text: 'Bayar',
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: transaction.totalPrice!.currencyFormatRp,
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += generator.row([
      PosColumn(
        text: 'Pembayaran',
        width: 8,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: transaction.paymentMethod!,
        width: 4,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += generator.hr(ch: '-');

    bytes += generator.feed(1);
    bytes += generator.text('Terima kasih',
        styles: const PosStyles(bold: false, align: PosAlign.center));
    bytes += generator.feed(3);

    return bytes;
  }

  Future<List<int>> printAntrian({
    required String noAntrian,
    required String namaPasien,
    required String namaDokter,
    required String jam,
  }) async {
    List<int> bytes = [];

    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);

    bytes += generator.reset();
    bytes += generator.text('Klinik Pratama Fuji',
        styles: const PosStyles(
          bold: true,
          align: PosAlign.center,
          height: PosTextSize.size1,
          width: PosTextSize.size1,
        ));

    bytes += generator.text('Jl. Evakuasi No.60, RT.01/RW.04',
        styles: const PosStyles(bold: true, align: PosAlign.center));
    bytes += generator.text(
        'Kalitanjung Timur, Harjamukti,\nKota Cirebon, Jawa Barat.',
        styles: const PosStyles(bold: true, align: PosAlign.center));
    bytes += generator.text(
        'Date : ${DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now())}',
        styles: const PosStyles(bold: false, align: PosAlign.center));
    bytes += generator.text('WA: 0851-7171-5191 | IG: @klinikpratamafuji',
        styles: const PosStyles(bold: true, align: PosAlign.center));

    bytes += generator.feed(2);

    bytes += generator.text('Nomor Antrian:',
        styles: const PosStyles(bold: true, align: PosAlign.center));
    bytes += generator.text(noAntrian,
        styles: const PosStyles(
          bold: true,
          align: PosAlign.center,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ));

    bytes += generator.feed(2);

    bytes += generator.text('Nama Pasien: $namaPasien',
        styles: const PosStyles(bold: false, align: PosAlign.left));
    bytes += generator.text('Nama Dokter: $namaDokter',
        styles: const PosStyles(bold: false, align: PosAlign.left));
    bytes += generator.text('Jam: $jam',
        styles: const PosStyles(bold: false, align: PosAlign.left));

    bytes += generator.feed(2);

    bytes += generator.text('Terima kasih',
        styles: const PosStyles(bold: false, align: PosAlign.center));
    bytes += generator.feed(3);

    return bytes;
  }
}
