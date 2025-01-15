import 'package:crypto_wallet/core/components/custom_button.dart';
import 'package:crypto_wallet/core/components/custom_text.dart';
import 'package:crypto_wallet/core/const/colors.dart';
import 'package:crypto_wallet/providers/wallet_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FirstScreen extends ConsumerStatefulWidget {
  const FirstScreen({super.key});

  @override
  ConsumerState<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends ConsumerState<FirstScreen> {
  Future<void> createWallet() async {
    await ref.read(walletProvider.notifier).createWallet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(text: "Let's get started", size: 24, weight: FontWeight.bold),
              const SizedBox(height: 10),
              CustomText(
                text: "Trusted by millions, MetaMask is a secure wallet making the world of web3 accessible to all.",
                size: 16,
                weight: FontWeight.normal,
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(color: primary),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: CustomButton(
                      borderRadius: 25,
                      height: 60,
                      backgroundColor: primary,
                      textColor: white,
                      width: double.infinity,
                      text: "Create a new Wallet",
                      onPressed: () {
                        context.go('/create-password');
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: CustomButton(
                      borderRadius: 25,
                      height: 60,
                      borderColor: primary,
                      backgroundColor: white,
                      textColor: primary,
                      width: double.infinity,
                      text: "Import an existing Wallet",
                      onPressed: () {},
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
