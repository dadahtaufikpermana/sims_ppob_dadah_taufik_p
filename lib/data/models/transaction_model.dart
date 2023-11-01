class TransactionModel {
  final int status;
  final String message;
  final TransactionDataList data;

  TransactionModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      status: json['status'],
      message: json['message'],
      data: TransactionDataList.fromJson(json['data']),
    );
  }
}

class TransactionDataList {
  final int offset;
  final int limit;
  final List<TransactionData> records;

  TransactionDataList({
    required this.offset,
    required this.limit,
    required this.records,
  });

  factory TransactionDataList.fromJson(Map<String, dynamic> json) {
    return TransactionDataList(
      offset: json['offset'],
      limit: json['limit'],
      records: (json['records'] as List).map((item) => TransactionData.fromJson(item)).toList(),
    );
  }
}

class TransactionData {
  final String invoiceNumber;
  final String transactionType;
  final String description;
  final int totalAmount;
  final String createdOn;

  TransactionData({
    required this.invoiceNumber,
    required this.transactionType,
    required this.description,
    required this.totalAmount,
    required this.createdOn,
  });

  factory TransactionData.fromJson(Map<String, dynamic> json) {
    return TransactionData(
      invoiceNumber: json['invoice_number'],
      transactionType: json['transaction_type'],
      description: json['description'],
      totalAmount: json['total_amount'],
      createdOn: json['created_on'],
    );
  }
}
