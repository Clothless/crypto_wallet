import 'package:crypto_wallet/core/models/rpc_model.dart';
import 'package:crypto_wallet/services/secure_storage.dart';
import 'package:crypto_wallet/services/wallet_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/web3dart.dart';

final walletProvider = StateNotifierProvider<WalletProvider, dynamic>((ref) => WalletProvider(ref));
final rpcProvider = StateNotifierProvider<RPCProvider, RPC?>((ref) => RPCProvider(ref));

class WalletProvider extends StateNotifier<dynamic> {
  final Ref ref;
  Web3Client? ethClient;

  WalletProvider(this.ref) : super(null);

  Future<void> createWallet() async {
    final x = await WalletService().createWallet();
    state = x!;
    await saveWallet();
    await ref.read(rpcProvider.notifier).getAllInfo();
  }

  Future<bool> saveWallet() async {
    try {
      if (state != null) {
        await SecureStorage().saveWallet(state!);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<Wallet?> getWallet() async {
    final wallet = await SecureStorage().getWallet();
    state = wallet;
    await ref.read(rpcProvider.notifier).getAllInfo();
    return wallet;
  }

  Future<void> connectToRPC() async {
    final x = await WalletService().connectToRPC();
    ethClient = x;
  }

  Future<void> sendTransaction({required String toAddress, required String amount}) async {
    final x = await WalletService().sendTransaction(toAddress, amount);
    print('Transaction: $x');
  }
}

class RPCProvider extends StateNotifier<RPC?> {
  final Ref ref;
  Web3Client? ethClient;

  RPCProvider(this.ref) : super(RPC());

  Future<void> connectToRPC() async {
    final x = await WalletService().connectToRPC();
    ethClient = x;
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
    final x = await WalletService().getWalletBalance();
    state!.walletBalance = x!;
    state = state;
  }

  Future<void> getTransactionsCount() async {
    final x = await WalletService().getTransactionsCount();
    state!.transactionCount = x!;
    state = state;
  }

  Future<void> getGasPrice() async {
    final x = await WalletService().getGasPrice();
    state!.gasPrice = x;
    state = state;
  }

  Future<void> getNetworkId() async {
    final x = await WalletService().getNetworkId();
    state!.networkId = x!;
    state = state;
  }
}
