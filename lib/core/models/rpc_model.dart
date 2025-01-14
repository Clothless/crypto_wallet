import 'package:web3dart/web3dart.dart';

class RPC {
  EtherAmount? walletBalance;
  EtherAmount? gasPrice;
  int? transactionCount;
  int? networkId;

  RPC({this.walletBalance, this.gasPrice, this.transactionCount, this.networkId});

  factory RPC.fromJson(Map<String, dynamic> json) {
    return RPC(
      walletBalance: EtherAmount.inWei(BigInt.parse(json['walletBalance'])),
      gasPrice: EtherAmount.inWei(BigInt.parse(json['gasPrice'])),
      transactionCount: json['transactionCount'],
      networkId: json['networkId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'walletBalance': walletBalance!.getInEther.toString(),
      'gasPrice': gasPrice!.getInEther.toString(),
      'transactionCount': transactionCount,
      'networkId': networkId,
    };
  }
}
