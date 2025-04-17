import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../Controller/services.dart';
import '../Constants/Design.dart';
import '../config/Provider/language_provider.dart';

class LocatorPage extends StatefulWidget {
  const LocatorPage({super.key});
  static const String id = "Locator_page";

  @override
  State<LocatorPage> createState() => _LocatorPageState();
}

class _LocatorPageState extends State<LocatorPage> {
  Position? _currentPosition;
  List<Map<String, dynamic>> _hospitals = [];
  final LocationService _locationService = LocationService();

  @override
  void initState() {
    super.initState();
    _fetchUserLocation();
  }

  Future<void> _fetchUserLocation() async {
    try {
      Position position = await _locationService.determinePosition();
      setState(() {
        _currentPosition = position;
      });

      // Fetch hospitals after getting location
      List<Map<String, dynamic>> hospitals =
      await _locationService.fetchNearbyHospitals(position.latitude, position.longitude);

      setState(() {
        _hospitals = hospitals;
      });
    } catch (e) {
      print("❌ Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    var lan =Provider.of<LanguageProvider>(context, listen: true);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'DERMA',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 24,
                        ),
                      ),
                      Image.asset('assets/logoo.png', width: 28),
                      const Text(
                        'SCAN',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  lan.getTexts("nearLoc"),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _currentPosition == null
                  ? const Center(child: CircularProgressIndicator())
                  : SizedBox(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _hospitals.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: locCard(hospitals: _hospitals, index: index),
                    );
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
