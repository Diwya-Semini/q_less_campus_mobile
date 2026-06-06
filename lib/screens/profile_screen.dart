// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:battery_plus/battery_plus.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:image_picker/image_picker.dart';
// import '../services/api_service.dart';
// import 'login_screen.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   String _userName = "Student";
//   String _batteryLevel = "Checking...";
//   String _networkStatus = "Checking...";
//   String _locationMessage = "Tap to verify location";
//   File? _profileImage;
//   bool _isLoadingLocation = false;

//   final Battery _battery = Battery();
//   final ImagePicker _picker = ImagePicker();

//   @override
//   void initState() {
//     super.initState();
//     _loadUserData();
//     _checkSystemHardware();
//   }

//   // 1. Load the user's name from the Vault
//   Future<void> _loadUserData() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _userName = prefs.getString('user_name') ?? "Student";
//     });
//   }

//   // 2. Hardware Sensor: Battery & Network
//   Future<void> _checkSystemHardware() async {
//     // Check Battery
//     try {
//       final level = await _battery.batteryLevel;
//       setState(() => _batteryLevel = "$level%");
//     } catch (e) {
//       setState(() => _batteryLevel = "Error reading battery");
//     }

//     // Check Network
//     try {
//       final connectivityResult = await Connectivity().checkConnectivity();
//       setState(() {
//         if (connectivityResult.contains(ConnectivityResult.wifi)) {
//           _networkStatus = "Connected (WiFi)";
//         } else if (connectivityResult.contains(ConnectivityResult.mobile)) {
//           _networkStatus = "Connected (Mobile Data)";
//         } else if (connectivityResult.contains(ConnectivityResult.none)) {
//           _networkStatus = "Offline - Check Connection";
//         } else {
//           _networkStatus = "Connected";
//         }
//       });
//     } catch (e) {
//       setState(() => _networkStatus = "Unknown Status");
//     }
//   }

//   // 3. Hardware Sensor: Camera
//   Future<void> _takeProfilePicture() async {
//     try {
//       final XFile? image = await _picker.pickImage(source: ImageSource.camera);
//       if (image != null) {
//         setState(() {
//           _profileImage = File(image.path);
//         });
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Failed to open camera.')),
//       );
//     }
//   }

//   // 4. Hardware Sensor: Geolocation (GPS)
//   Future<void> _verifyLocation() async {
//     setState(() => _isLoadingLocation = true);
    
//     try {
//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           setState(() {
//             _locationMessage = "Location permission denied";
//             _isLoadingLocation = false;
//           });
//           return;
//         }
//       }

//       if (permission == LocationPermission.deniedForever) {
//         setState(() {
//           _locationMessage = "Location permanently denied";
//           _isLoadingLocation = false;
//         });
//         return;
//       }

//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high
//       );
      
//       setState(() {
//         _locationMessage = "Lat: ${position.latitude.toStringAsFixed(4)}, Lng: ${position.longitude.toStringAsFixed(4)}";
//         _isLoadingLocation = false;
//       });
//     } catch (e) {
//       setState(() {
//         _locationMessage = "Failed to get location";
//         _isLoadingLocation = false;
//       });
//     }
//   }

//   Future<void> _handleLogout() async {
//     await ApiService.logout();
//     if (!mounted) return;
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (context) => const LoginScreen()),
//       (route) => false,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//     final brandOrange = theme.colorScheme.primary;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Profile & System', style: TextStyle(fontWeight: FontWeight.bold)),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             // --- PROFILE PICTURE SECTION (CAMERA SENSOR) ---
//             GestureDetector(
//               onTap: _takeProfilePicture,
//               child: Stack(
//                 alignment: Alignment.bottomRight,
//                 children: [
//                   CircleAvatar(
//                     radius: 60,
//                     backgroundColor: isDark ? Colors.grey[800] : Colors.grey[300],
//                     backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
//                     child: _profileImage == null
//                         ? Icon(Icons.person, size: 60, color: isDark ? Colors.white54 : Colors.grey[600])
//                         : null,
//                   ),
//                   CircleAvatar(
//                     backgroundColor: brandOrange,
//                     radius: 20,
//                     child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               _userName,
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black),
//             ),
//             const SizedBox(height: 40),

//             // --- SYSTEM STATUS DASHBOARD ---
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 "System Diagnostics",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: brandOrange),
//               ),
//             ),
//             const SizedBox(height: 15),

//             // Network Card
//             _buildSystemCard(
//               icon: Icons.wifi,
//               title: "Network Status",
//               value: _networkStatus,
//               isDark: isDark,
//               color: _networkStatus.contains('Offline') ? Colors.red : Colors.green,
//             ),
//             const SizedBox(height: 10),

//             // Battery Card
//             _buildSystemCard(
//               icon: Icons.battery_charging_full,
//               title: "Battery Level",
//               value: _batteryLevel,
//               isDark: isDark,
//               color: Colors.blue,
//             ),
//             const SizedBox(height: 10),

//             // Location Card
//             InkWell(
//               onTap: _verifyLocation,
//               borderRadius: BorderRadius.circular(15),
//               child: _buildSystemCard(
//                 icon: Icons.location_on,
//                 title: "Campus Location",
//                 value: _isLoadingLocation ? "Locating..." : _locationMessage,
//                 isDark: isDark,
//                 color: brandOrange,
//                 trailing: const Icon(Icons.refresh, color: Colors.grey),
//               ),
//             ),

//             const SizedBox(height: 40),

//             // Logout Button
//             SizedBox(
//               width: double.infinity,
//               height: 55,
//               child: ElevatedButton.icon(
//                 onPressed: _handleLogout,
//                 icon: const Icon(Icons.logout),
//                 label: const Text("Log Out", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.redAccent,
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSystemCard({
//     required IconData icon,
//     required String title,
//     required String value,
//     required bool isDark,
//     required Color color,
//     Widget? trailing,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(15),
//       decoration: BoxDecoration(
//         color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: isDark ? [] : [
//           BoxShadow(color: Colors.grey.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 4))
//         ],
//       ),
//       child: Row(
//         children: [
//           CircleAvatar(
//             backgroundColor: color.withValues(alpha: 0.2),
//             child: Icon(icon, color: color),
//           ),
//           const SizedBox(width: 15),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey)),
//                 const SizedBox(height: 4),
//                 Text(
//                   value,
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: isDark ? Colors.white : Colors.black,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           if (trailing != null) trailing,
//         ],
//       ),
//     );
//   }
// }