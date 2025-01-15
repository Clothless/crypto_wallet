import 'package:crypto_wallet/core/components/custom_button.dart';
import 'package:crypto_wallet/core/components/custom_text.dart';
import 'package:crypto_wallet/core/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReminderSetScreen extends StatefulWidget {
  const ReminderSetScreen({super.key});

  @override
  State<ReminderSetScreen> createState() => _ReminderSetScreenState();
}

class _ReminderSetScreenState extends State<ReminderSetScreen> {
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: primary),
                  ),
                ),
              ),
              CustomText(text: "Reminder set!", size: 24, weight: FontWeight.bold),
              const SizedBox(height: 10),
              CustomText(
                text: "If you get locked out of the app or get a new device, you will lose your funds. Be sure to back up your Secret Recovery Phrase in Settings > Security & Privacy.",
                size: 16,
                weight: FontWeight.normal,
                overflow: TextOverflow.visible,
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 20),
              CustomText(
                text: "Keep a reminder of your Secret Recovery Phrase somewhere safe. If you lose it, no one can help you get it back. Even worse, you won’t be able access to your wallet ever again.",
                size: 16,
                weight: FontWeight.normal,
                overflow: TextOverflow.visible,
                textAlign: TextAlign.left,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: CustomButton(
                  borderRadius: 25,
                  height: 60,
                  fontWeight: FontWeight.bold,
                  backgroundColor: darkPrimary,
                  textColor: white,
                  width: double.infinity,
                  text: "Done",
                  onPressed: () {
                    context.go('/');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
