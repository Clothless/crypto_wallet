import 'package:crypto_wallet/core/components/custom_button.dart';
import 'package:crypto_wallet/core/components/custom_text.dart';
import 'package:crypto_wallet/core/const/colors.dart';
import 'package:crypto_wallet/core/models/rpc_model.dart';
import 'package:crypto_wallet/providers/rpc_provider.dart';
import 'package:crypto_wallet/providers/wallet_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:web3dart/web3dart.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Check for existing wallet when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(walletProvider.notifier).getWallet();
      await ref.read(rpcProvider.notifier).getAllInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    final walletState = ref.watch(walletProvider);
    final rpcState = ref.watch(rpcProvider);

    return Scaffold(
      backgroundColor: white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            // TODO: it needs to be a drop down menu
            // where you can select which account you are interacting with
            CustomText(text: "Account 1", size: 16, weight: FontWeight.bold),
            // const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  child: CustomText(
                    text: walletState.privateKey.address.toString(),
                    size: 14,
                    weight: FontWeight.normal,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.content_copy_rounded),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: "${(rpcState as RPC).walletBalance!.getInEther.toString()} ETH",
                  size: 32,
                  weight: FontWeight.bold,
                ),
              ],
            ),
            const SizedBox(height: 20),
            //
            // Actions available
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: darkPrimary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.shopping_cart_outlined,
                          color: white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CustomText(
                        text: "Buy & Sell",
                        size: 12,
                        weight: FontWeight.normal,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: darkPrimary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.swap_horiz_rounded,
                          color: white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CustomText(
                        text: "Swap",
                        size: 12,
                        weight: FontWeight.normal,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: darkPrimary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.send_rounded,
                          color: white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CustomText(
                        text: "Send",
                        size: 12,
                        weight: FontWeight.normal,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: darkPrimary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.call_received_rounded,
                          color: white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CustomText(
                        text: "Receive",
                        size: 12,
                        weight: FontWeight.normal,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            //
            const SizedBox(height: 40),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomText(text: "Transactions", size: 16, weight: FontWeight.bold),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
