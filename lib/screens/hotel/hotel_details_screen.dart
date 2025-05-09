import 'package:flightbookapp/core/data/hotels_list.dart';
import 'package:flightbookapp/core/res/app_media.dart';
import 'package:flightbookapp/core/res/styles/app_theme.dart';
import 'package:flightbookapp/core/services/api_service.dart';
import 'package:flightbookapp/screens/payment/payment_screen.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class HotelDetailsScreen extends StatefulWidget {
  const HotelDetailsScreen({super.key});

  @override
  State<HotelDetailsScreen> createState() => _HotelDetailsScreenState();
}

class _HotelDetailsScreenState extends State<HotelDetailsScreen> {
  late int index = 0;
  Map<String, dynamic>? hotel;
  List<Map<String, dynamic>> rooms = [];
  bool isLoading = true;
  String? selectedRoomId;
  double selectedRoomPrice = 0;
  int numberOfNights = 1;
  DateTime checkInDate = DateTime.now().add(const Duration(days: 1));
  DateTime checkOutDate = DateTime.now().add(const Duration(days: 2));

  @override
  void didChangeDependencies() {
    var args = ModalRoute.of(context)!.settings.arguments as Map;
    index = args["index"];
    _fetchHotelDetails();
    super.didChangeDependencies();
  }

  Future<void> _fetchHotelDetails() async {
    // In a real app, fetch hotel and rooms from API using ApiService
    // For now, use static data
    await Future.delayed(
        const Duration(milliseconds: 800)); // Simulate network delay

    setState(() {
      hotel = hotelsList[index];
      rooms = [
        {
          'id': '1',
          'room_type': 'Single',
          'price_per_night': 99.0,
          'capacity': 1,
          'description':
              'Comfortable single room with a queen-sized bed, perfect for solo travelers.',
          'is_available': true,
          'image': 'hotel_room.png'
        },
        {
          'id': '2',
          'room_type': 'Double',
          'price_per_night': 159.0,
          'capacity': 2,
          'description':
              'Spacious double room with two beds, ideal for couples or friends traveling together.',
          'is_available': true,
          'image': 'hotel_room.png'
        },
        {
          'id': '3',
          'room_type': 'Suite',
          'price_per_night': 259.0,
          'capacity': 3,
          'description':
              'Luxury suite with a separate living area, king-sized bed, and premium amenities.',
          'is_available': true,
          'image': 'hotel_room.png'
        },
        {
          'id': '4',
          'room_type': 'Deluxe',
          'price_per_night': 299.0,
          'capacity': 4,
          'description':
              'Our finest accommodation with panoramic views, a jacuzzi, and butler service.',
          'is_available': false,
          'image': 'hotel_room.png'
        }
      ];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 300.0,
                  pinned: true,
                  floating: false,
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: const Icon(
                          FluentSystemIcons.ic_fluent_arrow_left_regular,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    title: Card(
                      color: Colors.white10,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(hotel!["place"],
                            style: AppTheme.headLineStyle4.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: GoogleFonts.oswald().fontFamily)),
                      ),
                    ),
                    background: Image.asset(
                      "assets/images/${hotel!["image"]}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                  // Hotel description
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                hotel!["place"],
                                style: AppTheme.headLineStyle1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                "\$${hotel!["price"]} / night",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const Gap(5),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.grey,
                              size: 16,
                            ),
                            const Gap(5),
                            Text(
                              hotel!["destination"],
                              style: AppTheme.headLineStyle4
                                  .copyWith(color: Colors.grey),
                            ),
                            const Spacer(),
                            _buildRatingStars(4.5),
                          ],
                        ),
                        const Gap(15),
                        const Divider(),
                        const Gap(15),
                        Text(
                          "Description",
                          style: AppTheme.headLineStyle2,
                        ),
                        const Gap(10),
                        Text(
                          "Idéalement situé à proximité des plages locales, notre hôtel offre également un accès facile aux sites touristiques d'Oran, tels que le fort de Santa-Cruz.",
                          style: AppTheme.textStyle,
                        ),
                        const Gap(20),

                        // Date selection
                        Text(
                          "Select Dates",
                          style: AppTheme.headLineStyle2,
                        ),
                        const Gap(10),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => _selectDate(true),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "CHECK-IN",
                                        style: AppTheme.headLineStyle4
                                            .copyWith(color: Colors.grey),
                                      ),
                                      const Gap(5),
                                      Text(
                                        "${checkInDate.day}/${checkInDate.month}/${checkInDate.year}",
                                        style: AppTheme.headLineStyle3,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const Gap(10),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => _selectDate(false),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "CHECK-OUT",
                                        style: AppTheme.headLineStyle4
                                            .copyWith(color: Colors.grey),
                                      ),
                                      const Gap(5),
                                      Text(
                                        "${checkOutDate.day}/${checkOutDate.month}/${checkOutDate.year}",
                                        style: AppTheme.headLineStyle3,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Gap(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Total: $numberOfNights night${numberOfNights > 1 ? 's' : ''}",
                              style: AppTheme.headLineStyle3
                                  .copyWith(color: AppTheme.primaryColor),
                            ),
                          ],
                        ),
                        const Gap(25),

                        // Room selection
                        Text(
                          "Available Rooms",
                          style: AppTheme.headLineStyle2,
                        ),
                      ],
                    ),
                  ),

                  // Room list
                  ...rooms.map((room) => _buildRoomCard(room)).toList(),

                  const Gap(80), // Space for the bottom button
                ]))
              ],
            ),
      bottomSheet: isLoading
          ? null
          : Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Price",
                          style: AppTheme.headLineStyle4,
                        ),
                        Text(
                          "\$${(selectedRoomPrice * numberOfNights).toStringAsFixed(2)}",
                          style: AppTheme.headLineStyle2
                              .copyWith(color: AppTheme.primaryColor),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: selectedRoomId == null
                          ? null
                          : () {
                              // Navigate to payment screen with hotel and room information
                              final bookingData = {
                                'type': 'hotel',
                                'hotel_name': hotel!['place'],
                                'destination': hotel!['destination'],
                                'room_type': rooms.firstWhere((r) =>
                                    r['id'] == selectedRoomId)['room_type'],
                                'check_in':
                                    "${checkInDate.day}/${checkInDate.month}/${checkInDate.year}",
                                'check_out':
                                    "${checkOutDate.day}/${checkOutDate.month}/${checkOutDate.year}",
                                'nights': numberOfNights,
                                'image': hotel!['image'],
                              };

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PaymentScreen(
                                      ticket: bookingData,
                                      amount:
                                          selectedRoomPrice * numberOfNights),
                                ),
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        disabledBackgroundColor: Colors.grey,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "Book Now",
                          style: AppTheme.textStyle.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> _selectDate(bool isCheckIn) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isCheckIn ? checkInDate : checkOutDate,
      firstDate: isCheckIn ? DateTime.now() : checkInDate,
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          checkInDate = picked;
          // Ensure checkout is after checkin
          if (checkOutDate.isBefore(checkInDate) ||
              checkOutDate.isAtSameMomentAs(checkInDate)) {
            checkOutDate = checkInDate.add(const Duration(days: 1));
          }
        } else {
          checkOutDate = picked;
        }

        // Calculate nights
        numberOfNights = checkOutDate.difference(checkInDate).inDays;
      });
    }
  }

  Widget _buildRoomCard(Map<String, dynamic> room) {
    final bool isAvailable = room['is_available'];
    final bool isSelected = selectedRoomId == room['id'];

    return GestureDetector(
      onTap: isAvailable
          ? () {
              setState(() {
                selectedRoomId = room['id'];
                selectedRoomPrice = room['price_per_night'];
              });
            }
          : null,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? AppTheme.primaryColor : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Stack(
                children: [
                  Image.asset(
                    "assets/images/${room['image']}",
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  if (!isAvailable)
                    Container(
                      height: 150,
                      width: double.infinity,
                      color: Colors.black.withOpacity(0.6),
                      child: const Center(
                        child: Text(
                          "Not Available",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        room['room_type'],
                        style: AppTheme.headLineStyle2,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "\$${room['price_per_night']} / night",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  const Gap(5),
                  Row(
                    children: [
                      const Icon(
                        Icons.person,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const Gap(5),
                      Text(
                        "Max ${room['capacity']} ${room['capacity'] > 1 ? 'persons' : 'person'}",
                        style: AppTheme.headLineStyle4
                            .copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                  const Gap(8),
                  Text(
                    room['description'],
                    style: AppTheme.textStyle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(8),
                  if (isAvailable && isSelected)
                    Text(
                      "Selected",
                      style: AppTheme.headLineStyle4.copyWith(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingStars(double rating) {
    return Row(
      children: [
        ...List.generate(5, (index) {
          return Icon(
            index < rating.floor()
                ? Icons.star
                : (index == rating.floor() && rating % 1 > 0)
                    ? Icons.star_half
                    : Icons.star_border,
            color: const Color(0xFFFFC107),
            size: 18,
          );
        }),
        const Gap(5),
        Text(
          rating.toString(),
          style: AppTheme.headLineStyle4.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}
