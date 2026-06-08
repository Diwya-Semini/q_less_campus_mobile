import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'dart:async';

import 'package:q_less_campus/providers/auth_provider.dart';
import 'package:q_less_campus/screens/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _networkStatus = 'Checking Wi-Fi...';
  late StreamSubscription<List<ConnectivityResult>> _networkSub;

  // hardware Sensor/Capability States
  final Battery _battery = Battery();
  final ImagePicker _picker = ImagePicker();

  int _batteryLevel = 100;
  String _isCharging = 'Discharging';
  File? _profileImage;

  // Geolocation States
  String _gpsCoordinates = 'Location not tracked';
  StreamSubscription<Position>? _gpsSubscription;

  late StreamSubscription<BatteryState> _batterySub;

  @override
  void initState() {
    super.initState();
    _initSystemTelemetry();
  }

  @override
  void dispose() {
    _networkSub.cancel();
    _batterySub.cancel();
    _gpsSubscription?.cancel();
    super.dispose();
  }

  void _initSystemTelemetry() async {
    // Network connectivity check
    final List<ConnectivityResult> initNet = await Connectivity()
        .checkConnectivity();
    _updateNet(initNet);
    _networkSub = Connectivity().onConnectivityChanged.listen(_updateNet);

    // Battery levels check
    final int bLevel = await _battery.batteryLevel;
    setState(() => _batteryLevel = bLevel);
    _batterySub = _battery.onBatteryStateChanged.listen((state) {
      if (mounted) {
        setState(
          () => _isCharging = state == BatteryState.charging
              ? 'Charging'
              : 'Discharging',
        );
      }
    });
  }

  void _updateNet(List<ConnectivityResult> results) {
    setState(() {
      if (results.contains(ConnectivityResult.wifi)) {
        _networkStatus = 'Connected to  Wi-Fi';
      } else {
        _networkStatus = 'Offline Mode: Disconnected';
      }
    });
  }

  // camera sensor capturing picture
  Future<void> _captureProfilePicture() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 70,
      );

      if (pickedFile != null) {
        setState(() {
          _profileImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      debugPrint("Camera capture rejected: $e");
    }
  }

  // track geo locations
  Future<void> _toggleGPSTracking() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() => _gpsCoordinates = "GPS is disabled on device");
        return;
      }

      // Request location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() => _gpsCoordinates = "Permissions denied");
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() => _gpsCoordinates = "Permissions permanently denied");
        return;
      }

      // If active, cancel existing stream to toggle it off
      if (_gpsSubscription != null) {
        await _gpsSubscription!.cancel();
        setState(() {
          _gpsSubscription = null;
          _gpsCoordinates = "Tracking Stopped";
        });
        return;
      }

      // Start listening to live location updates
      _gpsSubscription =
          Geolocator.getPositionStream(
            locationSettings: const LocationSettings(
              accuracy: LocationAccuracy.high,
              distanceFilter: 2,
            ),
          ).listen((Position position) {
            if (mounted) {
              setState(() {
                _gpsCoordinates =
                    "Lat: ${position.latitude.toStringAsFixed(4)}, Lng: ${position.longitude.toStringAsFixed(4)}";
              });
            }
          });

      setState(() => _gpsCoordinates = "Initializing GPS stream...");
    } catch (e) {
      setState(() => _gpsCoordinates = "GPS error occurred.");
    }
  }

  Future<void> _handleLogout() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider
        .logout(); // Triggers your API logout and wipes shared preferences

    if (mounted) {
      // Wipes the navigation backstack and redirects directly to LoginScreen widget
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false, // This wipes out all previous tabs/history
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color orangeAccent = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF121212)
          : const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text(
          "Student System Panel",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 54,
                    backgroundColor: orangeAccent.withValues(alpha: 0.1),
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : null,
                    child: _profileImage == null
                        ? Icon(
                            Icons.person_outline_rounded,
                            size: 50,
                            color: orangeAccent,
                          )
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _captureProfilePicture,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: orangeAccent,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            Consumer<AuthProvider>(
              builder: (context, authProvider, child) {
                final String studentName =
                    authProvider.currentUserName ?? 'Student';

                return Column(
                  children: [
                    Text(
                      studentName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],
                );
              },
            ),

            const SizedBox(height: 35),

            // system sensors
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: isDark
                    ? []
                    : [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "LIVE HARDWARE CAPABILITIES & LOGS",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const Divider(height: 20),

                  // 1. Live Connectivity Channel Monitor
                  _hardwareRow(Icons.wifi, "Network Telemetry", _networkStatus),
                  const SizedBox(height: 18),

                  // 2. battery monitor
                  _hardwareRow(
                    Icons.battery_std_rounded,
                    "Battery Subsystem",
                    "$_batteryLevel% ($_isCharging)",
                  ),
                  const SizedBox(height: 18),

                  // 3. gps location
                  _hardwareRow(
                    Icons.location_on_rounded,
                    "Canteen Proximity GPS",
                    _gpsCoordinates,
                  ),
                  const SizedBox(height: 20),

                  // GPS tracking trigger button
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: orangeAccent,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _toggleGPSTracking,
                      icon: Icon(
                        _gpsSubscription == null
                            ? Icons.gps_fixed_rounded
                            : Icons.gps_off_rounded,
                        size: 16,
                      ),
                      label: Text(
                        _gpsSubscription == null
                            ? "Start Proximity Tracking"
                            : "Stop Proximity Tracking",
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // log out btn
                  GestureDetector(
                    onTap: _handleLogout,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.redAccent.withValues(alpha: 0.15),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.redAccent.withValues(alpha: 0.08),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.logout_rounded,
                              color: Colors.redAccent,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Expanded(
                            child: Text(
                              "Sign Out Account",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.grey.shade400,
                            size: 14,
                          ),
                        ],
                      ),
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

  Widget _hardwareRow(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFFFDA750), size: 20),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
