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
      Wallet wallet = Wallet.createNew(credentials, dotenv.env['PASSWORD']!, rnd);
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
        dotenv.env['GANACHE_HOST']!,
        httpClient,
      );
      // var ethClient = Web3Client(
      //   "${dotenv.env['METAMASK_HOST']!}${dotenv.env['API_KEY']!}",
      //   httpClient,
      // );
      return ethClient;
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      return null;
    }
  }

  //
  // Get wallet address
  Future<EtherAmount?> getWalletBalance() async {
    try {
      final wallet = await SecureStorage().getWallet();
      final rdc = await connectToRPC();
      final balance = await rdc?.getBalance(wallet!.privateKey.address);
      return balance;
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      return null;
    }
  }

  //
  // Send transaction
  Future<String?> sendTransaction(String toAddress, String amount) async {
    try {
      final wallet = await SecureStorage().getWallet();
      final rdc = await connectToRPC();
      final credentials = wallet!.privateKey;
      final gasPrice = await getGasPrice();
      final chainId = await getChainId();
      final weiAmount = (double.parse(amount) * pow(10, 18)).toInt();
      final address = await rdc?.sendTransaction(
        credentials,
        Transaction(
          to: EthereumAddress.fromHex(toAddress),
          gasPrice: gasPrice!,
          maxGas: 100000,
          value: EtherAmount.inWei(BigInt.parse(weiAmount.toString())),
        ),
        chainId: int.parse(chainId!.toString()),
      );
      return address.toString();
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      return null;
    }
  }

  //
  // Sign transaction
  Future<String?> signTransaction(String toAddress, String amount, Wallet wallet) async {
    try {
      final rdc = await connectToRPC();
      final credentials = wallet.privateKey;
      final address = await rdc?.signTransaction(
        credentials,
        Transaction(
          to: EthereumAddress.fromHex(toAddress),
          gasPrice: EtherAmount.inWei(BigInt.one),
          maxGas: 100000,
          value: EtherAmount.inWei(BigInt.parse(amount)),
        ),
        // chainId: int.parse(dotenv.env['CHAIN_ID']!),
      );
      return address.toString();
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      return null;
    }
  }

  //
  // get chain id
  Future<BigInt?> getChainId() async {
    try {
      final rdc = await connectToRPC();
      final chainId = await rdc?.getChainId();
      return chainId;
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      return null;
    }
  }

  //
  // get network id
  Future<int?> getNetworkId() async {
    try {
      final rdc = await connectToRPC();
      final networkId = await rdc?.getNetworkId();
      return networkId;
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      return null;
    }
  }

  //
  // get block number
  Future<int?> getBlockNumber() async {
    try {
      final rdc = await connectToRPC();
      final blockNumber = await rdc?.getBlockNumber();
      return blockNumber;
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      return null;
    }
  }

  //
  // get gas price
  Future<EtherAmount?> getGasPrice() async {
    try {
      final rdc = await connectToRPC();
      final gasPrice = await rdc?.getGasPrice();
      return gasPrice;
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      return null;
    }
  }

  //
  // get transaction count
  Future<int?> getTransactionsCount() async {
    try {
      final wallet = await SecureStorage().getWallet();
      final rdc = await connectToRPC();
      final transactionCount = await rdc?.getTransactionCount(
        EthereumAddress.fromHex(wallet!.privateKey.address.hex),
      );
      return transactionCount;
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      return null;
    }
  }
}
