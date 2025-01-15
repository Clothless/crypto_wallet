import 'package:crypto_wallet/core/components/custom_button.dart';
import 'package:crypto_wallet/core/components/custom_text.dart';
import 'package:crypto_wallet/core/components/custom_text_form_field.dart';
import 'package:crypto_wallet/core/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

TextEditingController newPasswordController = TextEditingController();
TextEditingController confirmPasswordController = TextEditingController();
bool isPasswordVisible = false;

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
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
              CustomText(text: "Create a password", size: 24, weight: FontWeight.bold),
              const SizedBox(height: 10),
              CustomText(
                text: "This password will unlock your MetaMask wallet only on this device. MetaMask can not recover this password.",
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: "New password",
                              size: 16,
                              weight: FontWeight.bold,
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                              icon: CustomText(
                                text: "Show",
                                size: 14,
                                weight: FontWeight.normal,
                                color: primary,
                              ),
                            ),
                          ],
                        ),
                        CustomTextFormField(
                          text: "",
                          borderWidth: 1,
                          controller: newPasswordController,
                          borderColor: grey,
                          maxLines: 1,
                          leftPadding: 10,
                          rightPadding: 10,
                          obscureText: isPasswordVisible,
                          topLeftRadius: 10,
                          topRightRadius: 10,
                          bottomLeftRadius: 10,
                          bottomRightRadius: 10,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(text: "Confirm password", size: 16, weight: FontWeight.bold),
                        CustomTextFormField(
                          text: "",
                          borderWidth: 1,
                          controller: confirmPasswordController,
                          borderColor: grey,
                          maxLines: 1,
                          leftPadding: 10,
                          rightPadding: 10,
                          obscureText: isPasswordVisible,
                          topLeftRadius: 10,
                          topRightRadius: 10,
                          bottomLeftRadius: 10,
                          bottomRightRadius: 10,
                        ),
                      ],
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
                        context.go('/secure-your-wallet');
                      },
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
