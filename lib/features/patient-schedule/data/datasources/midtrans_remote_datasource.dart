import 'dart:convert';

import '../models/response/qris_response_model.dart';
import 'package:http/http.dart' as http;

import '../models/response/qris_status_response_model.dart';

class MidtransRemoteDatasource {
  String generateBasicAuthHeader(String serverKey) {
    final base64Credentials = base64Encode(utf8.encode('$serverKey:'));
    final authHeader = 'Basic $base64Credentials';

    return authHeader;
  }

  Future<QrisResponseModel> generateQrCode(
      String orderId, int grossAmount) async {
    const serverKey = 'SB-Mid-server-DUcigaRuQ94CcM5Co340ZdgX';
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': generateBasicAuthHeader(serverKey),
    };
    final body = jsonEncode({
      "payment_type": "qris",
      "transaction_details": {"order_id": orderId, "gross_amount": grossAmount}
    });

    final response = await http.post(
      Uri.parse('https://api.sandbox.midtrans.com/v2/charge'),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      return QrisResponseModel.fromMap(jsonDecode(response.body));
    } else {
      throw Exception('Failed to generate QR Code');
    }
  }

  Future<QrisStatusResponseModel> checkPaymentStatus(String orderId) async {
    const serverKey = 'SB-Mid-server-DUcigaRuQ94CcM5Co340ZdgX';
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': generateBasicAuthHeader(serverKey),
    };

    final response = await http.get(
      Uri.parse('https://api.sandbox.midtrans.com/v2/$orderId/status'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return QrisStatusResponseModel.fromMap(jsonDecode(response.body));
    } else {
      throw Exception('Failed to check payment status');
    }
  }
}
