import 'package:flightbookapp/core/res/styles/app_theme.dart';
import 'package:flightbookapp/core/widgets/ticket_view.dart';
import 'package:flightbookapp/screens/payment/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:gap/gap.dart';

import '../../core/res/styles/app_theme.dart' show AppTheme;

class FlightDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> ticket;

  const FlightDetailsScreen({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      appBar: AppBar(
        backgroundColor: AppTheme.bgColor,
        elevation: 0,
        title: Text('Flight Details', style: AppTheme.headLineStyle2),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Flight ticket card
            TicketView(
              ticket: ticket,
              isDefault: false,
              wholeScreen: true,
            ),
            const Gap(30),
            // Flight information
            buildSectionTitle('Flight Information'),
            buildInfoRow('Flight Number', 'FLT-${ticket['number']}'),
            buildInfoRow('Date', ticket['date']),
            buildInfoRow('Departure', ticket['departure_time']),
            buildInfoRow('Duration', ticket['flying_time']),
            const Gap(30),
            // Passenger information
            buildSectionTitle('Passenger Information'),
            buildInfoRow('Class', 'Economy'),
            buildInfoRow('Seat', 'Not assigned'),
            buildInfoRow('Baggage', '20 kg'),
            const Gap(30),
            // Price information
            buildSectionTitle('Price Details'),
            buildInfoRow('Base Fare', '\$199'),
            buildInfoRow('Tax & Fee', '\$24'),
            buildInfoRow('Total', '\$223'),
            const Gap(40),
            // Book button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to payment screen
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              PaymentScreen(ticket: ticket, amount: 223.0)));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Continue to Payment',
                  style: AppTheme.textStyle.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTheme.headLineStyle2,
        ),
        const Gap(10),
        const Divider(),
        const Gap(10),
      ],
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTheme.headLineStyle4,
          ),
          Text(
            value,
            style:
                AppTheme.headLineStyle4.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
