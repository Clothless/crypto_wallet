import 'dart:math';
import 'package:crypto_wallet/services/secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/web3dart.dart';

class WalletService {
  //
  // Creating a new wallet
  Future<Wallet?> createWallet() async {
    try {
      var rnd = Random.secure();
      final credentials = EthPrivateKey.createRandom(rnd);
      Wallet wallet =
          Wallet.createNew(credentials, dotenv.env['PASSWORD']!, rnd);
      return wallet;
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
      return null;
    }
  }

  //
  // Connecting to RPC
  Future<Web3Client?> connectToRPC() async {
    try {
      final httpClient = Client();
      var ethClient = Web3Client(
        "${dotenv.env['METAMASK_HOST']!}${dotenv.env['API_KEY']!}",
        httpClient,
      );
      return ethClient;
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      return null;
    }
  }

  //
  // Get wallet address
  Future<String?> getWalletBalance() async {
    try {
      final wallet = await SecureStorage().getWallet();
      final rdc = await connectToRPC();
      final address = await rdc?.getBalance(wallet!.privateKey.address);
      return address.toString();
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      return null;
    }
  }
}
