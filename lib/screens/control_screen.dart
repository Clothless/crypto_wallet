import 'package:crypto_wallet/providers/wallet_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/web3dart.dart';

class ControlScreen extends ConsumerStatefulWidget {
  const ControlScreen({super.key});

  @override
  ConsumerState<ControlScreen> createState() => _ControlScreenState();
}

class _ControlScreenState extends ConsumerState<ControlScreen> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Check for existing wallet when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(walletProvider.notifier).getWallet();
    });
  }

  Future<void> createWallet() async {
    setState(() {
      isLoading = true;
    });
    await ref.read(walletProvider.notifier).createWallet();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final walletState = ref.watch(walletProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ref.read(walletProvider) == null
                ? Column(
                    children: [
                      const Text('Control Screen'),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          await createWallet();
                        },
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.blue,
                              )
                            : const Text('Create Wallet'),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      const Text('Wallet Address:'),
                      Text(walletState.privateKey.address.toString()),
                      const SizedBox(height: 20),
                      const Text('Wallet Balance:'),
                      Text(ref.read(walletProvider.notifier).walletBalance!.getValueInUnit(EtherUnit.ether).toString()),
                      const SizedBox(height: 20),
                      const Text('Gas Price:'),
                      Text((ref.read(walletProvider.notifier).gasPrice!.getValueInUnit(EtherUnit.gwei)).toString()),
                      const SizedBox(height: 20),
                      const Text('Transactions Count:'),
                      Text(ref.read(walletProvider.notifier).transactionsCount.toString()),
                      ElevatedButton(
                          onPressed: () async {
                            print("Yes you taped here!");
                            await ref.read(walletProvider.notifier).sendTransaction(toAddress: "0xaD6ebED117A6bD4ad0B99C6278c8B9aB6f1009D7", amount: "0.01");
                            await ref.read(walletProvider.notifier).getWalletBalance();
                            print("yes it's done!!!");
                          },
                          child: Text("Testing button"))
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
