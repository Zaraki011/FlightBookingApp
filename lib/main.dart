import 'package:flightbookapp/core/res/styles/app_theme.dart';
import 'package:flightbookapp/core/utils/app_routes.dart';
import 'package:flightbookapp/screens/auth/login_screen.dart';
import 'package:flightbookapp/screens/auth/register_screen.dart';
import 'package:flightbookapp/screens/home/all_hotels_screen.dart';
import 'package:flightbookapp/screens/home/all_tickets_screen.dart';
import 'package:flightbookapp/screens/hotel/hotel_details_screen.dart';
import 'package:flightbookapp/screens/ticket/ticket_screen.dart';
import 'package:flutter/material.dart';
import 'package:flightbookapp/core/bottom_nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlightBook',
      theme: ThemeData(
        // fontFamily: GoogleFonts.poppins().fontFamily,
        primaryColor: primary,
        useMaterial3: true,
        // textTheme: GoogleFonts.poppinsTextTheme(
        //   Theme.of(context).textTheme,
        // ),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        AppRoutes.homeScreen: (context) => const BottomNavBar(),
        AppRoutes.allTicketsScreen: (context) => const AllTicketsScreen(),
        AppRoutes.ticketScreen: (context) => const TicketScreen(),
        AppRoutes.allHotelsScreen: (context) => const AllHotelsScreen(),
        AppRoutes.hotelDetailsScreen: (context) => const HotelDetailsScreen(),
        AppRoutes.loginScreen: (context) => const LoginScreen(),
        AppRoutes.registerScreen: (context) => const RegisterScreen(),
      },
    );
  }
}
