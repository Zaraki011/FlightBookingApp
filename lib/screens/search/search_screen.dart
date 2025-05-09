import 'package:flightbookapp/core/res/styles/app_theme.dart';
import 'package:flightbookapp/core/widgets/app_texts.dart';
import 'package:flightbookapp/screens/search/widgets/app_text_icon.dart';
import 'package:flightbookapp/screens/search/widgets/find_tickets.dart';
import 'package:flightbookapp/screens/search/widgets/tickets_tabs.dart';
import 'package:flightbookapp/screens/search/widgets/ticket_promotion.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            "What are\nyou looking for?",
            style: AppTheme.headLineStyle1.copyWith(fontSize: 32),
          ),
          const SizedBox(
            height: 20,
          ),
          const TicketsTabs(
            firstTab: "All tickets",
            secondTab: "Hotels",
          ),
          const SizedBox(
            height: 24,
          ),
          const AppTextIcon(
            icon: Icons.flight_takeoff_rounded,
            text: "Departure",
          ),
          const SizedBox(
            height: 20,
          ),
          const AppTextIcon(
            icon: Icons.flight_land_rounded,
            text: "Arrival",
          ),
          const SizedBox(
            height: 24,
          ),
          const FindTickets(),
          const SizedBox(
            height: 40,
          ),
          AppTexts(
            titleText: "Upcoming Flights",
            descText: "View all",
            func: () {},
          ),
          const SizedBox(
            height: 15,
          ),
          const TicketPromotion()
        ],
      ),
    );
  }
}
