import 'package:flightbookapp/core/services/api_service.dart';
import 'package:flightbookapp/core/utils/app_routes.dart';
import 'package:flightbookapp/core/widgets/ticket_view.dart';
import 'package:flightbookapp/screens/home/widgets/hotel_card.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flightbookapp/core/res/app_media.dart';
import 'package:flightbookapp/core/res/styles/app_theme.dart';
import 'package:flightbookapp/core/widgets/app_texts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _tickets = [];
  List<Map<String, dynamic>> _hotels = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final tickets = await ApiService.getFlights();
      final hotels = await ApiService.getHotels();

      setState(() {
        _tickets = tickets;
        _hotels = hotels;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GradientText(
                            'FlightBook',
                            style: GoogleFonts.poppins(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),
                            colors: const [
                              Color.fromARGB(255, 247, 109, 205),
                              Colors.blue
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Book your tickets",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                      Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                              image: AssetImage(AppMedia.logo),
                              fit: BoxFit.fitHeight,
                            ),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFFF4F6FD)),
                    child: const Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(FluentSystemIcons.ic_fluent_search_regular),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Search")
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AppTexts(
                    newFeature: true,
                    titleText: "Upcoming Flights",
                    descText: "View all",
                    func: () => Navigator.pushNamed(
                        context, AppRoutes.allTicketsScreen),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _error != null
                          ? Center(child: Text('Error: $_error'))
                          : SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: _tickets
                                    .map((singleTicket) => TicketView(
                                          ticket: singleTicket,
                                          isDefault: false,
                                        ))
                                    .toList(),
                              )),
                  const SizedBox(
                    height: 20,
                  ),
                  AppTexts(
                    titleText: "Hotels",
                    descText: "View all",
                    func: () {
                      Navigator.pushNamed(context, AppRoutes.allHotelsScreen);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _error != null
                          ? Center(child: Text('Error: $_error'))
                          : SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: _hotels
                                    .map((singleHotel) =>
                                        HotelCard(hotel: singleHotel))
                                    .toList(),
                              ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
