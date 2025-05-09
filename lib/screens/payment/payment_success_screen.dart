import 'package:flightbookapp/core/bottom_nav_bar.dart';
import 'package:flightbookapp/core/res/styles/app_theme.dart';
import 'package:flightbookapp/core/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final Map<String, dynamic> ticket;
  final double amount;

  const PaymentSuccessScreen({
    super.key,
    required this.ticket,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Success animation
              Container(
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
                child: const Icon(
                  Icons.check,
                  size: 100,
                  color: Colors.white,
                ),
              ),
              const Gap(30),

              // Success text
              Text(
                'Payment Successful!',
                style: AppTheme.headLineStyle1,
              ),
              const Gap(15),
              Text(
                'Your flight ticket has been booked successfully.',
                textAlign: TextAlign.center,
                style: AppTheme.textStyle,
              ),
              const Gap(15),
              Text(
                'Amount Paid: \$${amount.toStringAsFixed(2)}',
                style: AppTheme.headLineStyle2.copyWith(
                  color: Colors.green,
                ),
              ),

              const Spacer(),

              // Return to home button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate back to home
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const BottomNavBar()),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Back to Home',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
