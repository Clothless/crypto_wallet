import 'package:crypto_wallet/core/models/rpc_model.dart';
import 'package:crypto_wallet/services/rpc_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web3dart/web3dart.dart';

final rpcProvider = StateNotifierProvider<RPCProvider, RPC?>((ref) => RPCProvider(ref));

class RPCProvider extends StateNotifier<RPC?> {
  final Ref ref;
  Web3Client? ethClient;

  RPCProvider(this.ref) : super(RPC());

  Future<void> connectToRPC() async {
    final x = await RpcService().connectToRPC();
    ethClient = x;
  }

  // Send transaction
  Future<String?> sendTransaction(String toAddress, String amount) async {
    final x = await RpcService().sendTransaction(toAddress, amount);
    return x;
  }

  // Get all info
  Future<void> getAllInfo() async {
    if (ethClient == null) {
      await connectToRPC();
    }
    await getWalletBalance();
    await getTransactionsCount();
    await getGasPrice();
    await getNetworkId();
  }

  Future<void> getWalletBalance() async {
    final x = await RpcService().getWalletBalance();
    state!.walletBalance = x ?? EtherAmount.zero();
    state = state;
  }

  Future<void> getTransactionsCount() async {
    final x = await RpcService().getTransactionsCount();
    state!.transactionCount = x!;
    state = state;
  }

  Future<void> getGasPrice() async {
    final x = await RpcService().getGasPrice();
    state!.gasPrice = x;
    state = state;
  }

  Future<void> getNetworkId() async {
    final x = await RpcService().getNetworkId();
    state!.networkId = x!;
    state = state;
  }
}
