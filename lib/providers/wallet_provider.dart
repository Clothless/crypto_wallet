import 'package:crypto_wallet/services/secure_storage.dart';
import 'package:crypto_wallet/services/wallet_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/web3dart.dart';

final walletProvider = StateNotifierProvider<WalletProvider, dynamic>((ref) => WalletProvider(ref));

class WalletProvider extends StateNotifier<dynamic> {
  final Ref ref;
  EtherAmount? walletBalance;
  Web3Client? ethClient;
  int transactionsCount = 0;
  EtherAmount? gasPrice;

  WalletProvider(this.ref) : super(null);

  Future<void> createWallet() async {
    final x = await WalletService().createWallet();
    state = x!;
    await getGasPrice();
    await saveWallet();
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
    await getWalletBalance();
    await getGasPrice();
    state = wallet;
    return wallet;
  }

  Future<void> connectToRPC() async {
    final x = await WalletService().connectToRPC();
    ethClient = x;
  }

  Future<void> getWalletBalance() async {
    final x = await WalletService().getWalletBalance();
    walletBalance = x!;
  }

  Future<void> getTransactionsCount() async {
    final x = await WalletService().getTransactionsCount();
    transactionsCount = x!;
    print(transactionsCount);
  }

  Future<void> getGasPrice() async {
    final x = await WalletService().getGasPrice();
    gasPrice = x;
  }

  Future<void> getNetworkId() async {
    final x = await WalletService().getNetworkId();
    print('NetworkId: $x');
  }

  Future<void> sendTransaction({required String toAddress, required String amount}) async {
    final x = await WalletService().sendTransaction(toAddress, amount);
    print('Transaction: $x');
  }
}
