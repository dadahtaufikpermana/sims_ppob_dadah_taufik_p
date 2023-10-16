class TopUpModel {
  final int status;
  final String message;
  final TopUpData data;

  TopUpModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory TopUpModel.fromJson(Map<String, dynamic> json) {
    return TopUpModel(
      status: json['status'] as int,
      message: json['message'] as String,
      data: TopUpData.fromJson(json['data']),
    );
  }
}

class TopUpData {
  final double balance;

  TopUpData({
    required this.balance,
  });

  factory TopUpData.fromJson(Map<String, dynamic> json) {
    return TopUpData(
      balance: (json['balance'] as num).toDouble(),
    );
  }
}
