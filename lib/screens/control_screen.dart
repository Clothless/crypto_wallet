import 'package:crypto_wallet/providers/rpc_provider.dart';
import 'package:crypto_wallet/providers/wallet_provider.dart';
import 'package:crypto_wallet/screens/first_screen.dart';
import 'package:crypto_wallet/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    final rpcState = ref.watch(rpcProvider);
    if(ref.read(walletProvider) == null){
      return const FirstScreen();
    }else{
      return const HomeScreen();
    }

    
  }
}
