import 'package:crypto_wallet/core/components/custom_button.dart';
import 'package:crypto_wallet/core/components/custom_text.dart';
import 'package:crypto_wallet/core/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SecureYourWalletScreen extends StatefulWidget {
  const SecureYourWalletScreen({super.key});

  @override
  State<SecureYourWalletScreen> createState() => _SecureYourWalletScreenState();
}

class _SecureYourWalletScreenState extends State<SecureYourWalletScreen> {
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
              CustomText(text: "Secure your wallet", size: 24, weight: FontWeight.bold),
              const SizedBox(height: 10),
              CustomText(
                text: "Before getting started, take a few seconds to learn about your Secret Recovery Phrase and how to keep your wallet safe.",
                size: 16,
                weight: FontWeight.normal,
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: "What is a Secret Recovery Phrase?", size: 16, weight: FontWeight.bold),
                  CustomText(text: "Your Secret Recovery Phrase is a 12-word phrase that is the “master key” to your wallet and your funds", size: 16, weight: FontWeight.normal),
                  const SizedBox(height: 10),
                  CustomText(text: "How do I save my Secret Recovery Phrase?", size: 16, weight: FontWeight.bold),
                  Row(
                    children: [
                      const Icon(
                        Icons.circle,
                        color: firstTextColor,
                        size: 10,
                      ),
                      const SizedBox(width: 5),
                      CustomText(text: "Write down and store in multiple secret places", size: 16, weight: FontWeight.normal),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.circle,
                        color: firstTextColor,
                        size: 10,
                      ),
                      const SizedBox(width: 5),
                      CustomText(text: "Store in a safe deposit box", size: 16, weight: FontWeight.normal),
                    ],
                  ),
                  const SizedBox(height: 10),
                  CustomText(text: "Should I share my Secret Recovery Phrase?", size: 16, weight: FontWeight.bold),
                  CustomText(text: "Never, ever share your Secret Recovery Phrase, not even with us!", size: 16, weight: FontWeight.normal),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: CustomButton(
                            borderRadius: 25,
                            height: 60,
                            borderColor: white,
                            backgroundColor: primary,
                            textColor: white,
                            width: double.infinity,
                            text: "Secure my wallet (recommended)",
                            onPressed: () {},
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: CustomButton(
                            borderRadius: 25,
                            height: 60,
                            borderColor: primary,
                            backgroundColor: white,
                            textColor: primary,
                            width: double.infinity,
                            text: "Remind me later (not recommended)",
                            onPressed: () {
                              context.go('/reminder-set');
                            },
                          ),
                        ),
                      ],
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
