class BalanceModel {
  final int status;
  final String message;
  final int balance;

  BalanceModel({
    required this.status,
    required this.message,
    required this.balance,
  });

  factory BalanceModel.fromJson(Map<String, dynamic> json) {
    return BalanceModel(
      status: json['status'],
      message: json['message'],
      balance: json['data']['balance'],
    );
  }
}
