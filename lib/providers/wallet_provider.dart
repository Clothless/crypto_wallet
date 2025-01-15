import 'package:crypto_wallet/providers/rpc_provider.dart';
import 'package:crypto_wallet/services/rpc_service.dart';
import 'package:crypto_wallet/services/secure_storage.dart';
import 'package:crypto_wallet/services/wallet_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web3dart/web3dart.dart';

final walletProvider = StateNotifierProvider<WalletProvider, dynamic>((ref) => WalletProvider(ref));

class WalletProvider extends StateNotifier<dynamic> {
  final Ref ref;
  Web3Client? ethClient;

  WalletProvider(this.ref) : super(null);

  Future<void> connectToRPC() async {
    final x = await RpcService().connectToRPC();
    ethClient = x;
  }

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
}
