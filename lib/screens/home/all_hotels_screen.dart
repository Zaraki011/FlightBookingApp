import 'package:flightbookapp/core/services/api_service.dart';
import 'package:flightbookapp/core/res/styles/app_theme.dart';
import 'package:flightbookapp/screens/home/widgets/grid_hotel_card.dart';
import 'package:flutter/material.dart';

class AllHotelsScreen extends StatefulWidget {
  const AllHotelsScreen({super.key});

  @override
  State<AllHotelsScreen> createState() => _AllHotelsScreenState();
}

class _AllHotelsScreenState extends State<AllHotelsScreen> {
  List<Map<String, dynamic>> _hotels = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchHotels();
  }

  Future<void> _fetchHotels() async {
    try {
      final hotels = await ApiService.getHotels();
      setState(() {
        _hotels = hotels;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
      print('Error fetching hotels: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      appBar: AppBar(
        title: const Text("All Hotels"),
        backgroundColor: AppTheme.bgColor,
      ),
      body: _isLoading 
          ? const Center(child: CircularProgressIndicator())
          : _error != null 
              ? Center(child: Text('Error: $_error'))
              : Container(
                  margin: const EdgeInsets.only(left: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 0.0,
                            mainAxisSpacing: 14.0,
                            childAspectRatio: 0.6),
                        itemCount: _hotels.length,
                        itemBuilder: (context, index) {
                          var singleHotel = _hotels[index];
                          return GridHotelCard(hotel: singleHotel, index: index);
                        }),
                  ),
                ),
    );
  }
}
