class Transaction {
  final String transactionHash;
  final String fromAddress;
  final String toAddress;
  final String amount;
  final String timestamp;
  final String status;
  final String gasPrice;
  final String gasUsed;
  final String blockNumber;
  final String currency;

  Transaction({
    required this.transactionHash,
    required this.fromAddress,
    required this.toAddress,
    required this.amount,
    required this.timestamp,
    required this.status,
    required this.gasPrice,
    required this.gasUsed,
    required this.blockNumber,
    required this.currency,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      transactionHash: json['transactionHash'],
      fromAddress: json['fromAddress'],
      toAddress: json['toAddress'],
      amount: json['amount'],
      timestamp: json['timestamp'],
      status: json['status'],
      gasPrice: json['gasPrice'],
      gasUsed: json['gasUsed'],
      blockNumber: json['blockNumber'],
      currency: json['currency'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transactionHash': transactionHash,
      'fromAddress': fromAddress,
      'toAddress': toAddress,
      'amount': amount,
      'timestamp': timestamp,
      'status': status,
      'gasPrice': gasPrice,
      'gasUsed': gasUsed,
      'blockNumber': blockNumber,
      'currency': currency,
    };
  }
}
