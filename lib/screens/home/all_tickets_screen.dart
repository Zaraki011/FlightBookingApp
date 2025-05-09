import 'package:flightbookapp/core/services/api_service.dart';
import 'package:flightbookapp/core/res/styles/app_theme.dart';
import 'package:flightbookapp/core/widgets/ticket_view.dart';
import 'package:flightbookapp/screens/ticket/flight_details_screen.dart';
import 'package:flutter/material.dart';

class AllTicketsScreen extends StatefulWidget {
  const AllTicketsScreen({super.key});

  @override
  State<AllTicketsScreen> createState() => _AllTicketsScreenState();
}

class _AllTicketsScreenState extends State<AllTicketsScreen> {
  List<Map<String, dynamic>> _tickets = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchTickets();
  }

  Future<void> _fetchTickets() async {
    try {
      final tickets = await ApiService.getFlights();
      setState(() {
        _tickets = tickets;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
      print('Error fetching tickets: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      appBar: AppBar(
        title: const Text("All Tickets"),
        backgroundColor: AppTheme.bgColor,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text('Error: $_error'))
              : ListView(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: _tickets
                            .map((singleTicket) => GestureDetector(
                                  onTap: () {
                                    // Navigate to flight details screen
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => FlightDetailsScreen(
                                          ticket: singleTicket,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.only(bottom: 16),
                                      child: TicketView(
                                        wholeScreen: true,
                                        ticket: singleTicket,
                                        isDefault: false,
                                      )),
                                ))
                            .toList(),
                      ),
                    )
                  ],
                ),
    );
  }
}
