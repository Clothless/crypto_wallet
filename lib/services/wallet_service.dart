import 'dart:math';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/web3dart.dart';

class WalletService {
  //
  // Creating a new wallet
  Future<Wallet?> createWallet() async {
    try {
      var rnd = Random.secure();
      final credentials = EthPrivateKey.createRandom(rnd);
      Wallet wallet = Wallet.createNew(credentials, dotenv.env['PASSWORD']!, rnd);
      return wallet;
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
      return null;
    }
  }

  //
  // TODO: Import wallet
  

  
}
