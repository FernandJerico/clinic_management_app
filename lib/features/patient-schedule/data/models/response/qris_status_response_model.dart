import 'dart:convert';

class QrisStatusResponseModel {
  final String? statusCode;
  final String? statusMessage;
  final String? transactionId;
  final String? maskedCard;
  final String? orderId;
  final String? paymentType;
  final DateTime? transactionTime;
  final String? transactionStatus;
  final String? fraudStatus;
  final String? approvalCode;
  final String? signatureKey;
  final String? bank;
  final String? grossAmount;
  final String? channelResponseCode;
  final String? channelResponseMessage;
  final String? cardType;
  final String? paymentOptionType;
  final String? shopeepayReferenceNumber;
  final String? referenceId;

  QrisStatusResponseModel({
    this.statusCode,
    this.statusMessage,
    this.transactionId,
    this.maskedCard,
    this.orderId,
    this.paymentType,
    this.transactionTime,
    this.transactionStatus,
    this.fraudStatus,
    this.approvalCode,
    this.signatureKey,
    this.bank,
    this.grossAmount,
    this.channelResponseCode,
    this.channelResponseMessage,
    this.cardType,
    this.paymentOptionType,
    this.shopeepayReferenceNumber,
    this.referenceId,
  });

  factory QrisStatusResponseModel.fromJson(String str) =>
      QrisStatusResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory QrisStatusResponseModel.fromMap(Map<String, dynamic> json) =>
      QrisStatusResponseModel(
        statusCode: json["status_code"],
        statusMessage: json["status_message"],
        transactionId: json["transaction_id"],
        maskedCard: json["masked_card"],
        orderId: json["order_id"],
        paymentType: json["payment_type"],
        transactionTime: json["transaction_time"] == null
            ? null
            : DateTime.parse(json["transaction_time"]),
        transactionStatus: json["transaction_status"],
        fraudStatus: json["fraud_status"],
        approvalCode: json["approval_code"],
        signatureKey: json["signature_key"],
        bank: json["bank"],
        grossAmount: json["gross_amount"],
        channelResponseCode: json["channel_response_code"],
        channelResponseMessage: json["channel_response_message"],
        cardType: json["card_type"],
        paymentOptionType: json["payment_option_type"],
        shopeepayReferenceNumber: json["shopeepay_reference_number"],
        referenceId: json["reference_id"],
      );

  Map<String, dynamic> toMap() => {
        "status_code": statusCode,
        "status_message": statusMessage,
        "transaction_id": transactionId,
        "masked_card": maskedCard,
        "order_id": orderId,
        "payment_type": paymentType,
        "transaction_time": transactionTime?.toIso8601String(),
        "transaction_status": transactionStatus,
        "fraud_status": fraudStatus,
        "approval_code": approvalCode,
        "signature_key": signatureKey,
        "bank": bank,
        "gross_amount": grossAmount,
        "channel_response_code": channelResponseCode,
        "channel_response_message": channelResponseMessage,
        "card_type": cardType,
        "payment_option_type": paymentOptionType,
        "shopeepay_reference_number": shopeepayReferenceNumber,
        "reference_id": referenceId,
      };
}
