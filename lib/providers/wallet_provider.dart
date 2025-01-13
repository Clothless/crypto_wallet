import 'package:crypto_wallet/services/secure_storage.dart';
import 'package:crypto_wallet/services/wallet_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final walletProvider = StateNotifierProvider<WalletProvider, dynamic>(
    (ref) => WalletProvider(ref));

class WalletProvider extends StateNotifier<dynamic> {
  final Ref ref;

  WalletProvider(this.ref) : super(null);

  Future<void> createWallet() async {
    final x = await WalletService().createWallet();
    state = x!;
  }

  Future<bool> saveWallet() async {
    try {
      await createWallet();
      if (state != null) {
        await SecureStorage().saveWallet(state);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> getWallet() async {
    final x = await SecureStorage().getWallet();
    state = x;
  }

  void connectToRPC() async {
    final x = await WalletService().connectToRPC();
    state = x;
  }

  void getWalletBalance() async {
    final x = await WalletService().getWalletBalance();
    state = x;
  }
}
