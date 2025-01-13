import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:web3dart/credentials.dart';

class SecureStorage {
  final dynamic storage = const FlutterSecureStorage();

//
// Save wallet
  Future<bool> saveWallet(Wallet wallet) async {
    try {
      await storage.write(
          key: dotenv.env['STORAGE_WALLET_KEY'], value: wallet.toJson());
      return true;
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      return false;
    }
  }

  //
  // Get wallet
  Future<Wallet?> getWallet() async {
    try {
      final wallet = await storage.read(key: dotenv.env['STORAGE_WALLET_KEY']);
      return Wallet.fromJson(wallet.toString(), dotenv.env['PASSWORD']!);
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      return null;
    }
  }
}
