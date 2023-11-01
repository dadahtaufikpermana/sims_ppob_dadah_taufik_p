class TransactionResponse {
  final int status;
  final String message;
  final TransactionData data;

  TransactionResponse(
      {required this.status, required this.message, required this.data});

  factory TransactionResponse.fromJson(Map<String, dynamic> json) {
    return TransactionResponse(
      status: json['status'],
      message: json['message'],
      data: TransactionData.fromJson(json['data']),
    );
  }
}

class TransactionData {
  final int? offset;
  final int? limit;
  final List<TransactionRecord> records;

  TransactionData(
      {required this.offset, required this.limit, required this.records});

  factory TransactionData.fromJson(Map<String, dynamic> json) {
    var recordList = json['records'] as List;
    List<TransactionRecord> records =
        recordList.map((record) => TransactionRecord.fromJson(record)).toList();

    return TransactionData(
      offset: int.tryParse(json['offset'].toString()) ?? 0,
      limit: int.tryParse(json['limit'].toString()) ?? 0,
      records: (json['records'] as List)
          .map((record) => TransactionRecord.fromJson(record))
          .toList(),
    );
  }
}

class TransactionRecord {
  final String invoiceNumber;
  final String transactionType;
  final String description;
  final int totalAmount;
  final String createdOn;

  TransactionRecord({
    required this.invoiceNumber,
    required this.transactionType,
    required this.description,
    required this.totalAmount,
    required this.createdOn,
  });

  factory TransactionRecord.fromJson(Map<String, dynamic> json) {
    return TransactionRecord(
      invoiceNumber: json['invoice_number'],
      transactionType: json['transaction_type'],
      description: json['description'],
      totalAmount: json['total_amount'],
      createdOn: json['created_on'],
    );
  }
}
