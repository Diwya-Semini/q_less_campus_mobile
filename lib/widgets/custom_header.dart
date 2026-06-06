import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomHeader extends StatelessWidget {
  final String screenTitle;

  const CustomHeader({super.key, required this.screenTitle});

  Future<String> _getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('name') ?? 'Student';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return Row(
      children: [
        const CircleAvatar(
          radius: 22,
          backgroundColor: Colors.grey,
          backgroundImage: NetworkImage(
            'https://media.istockphoto.com/id/2151669184/vector/vector-flat-illustration-in-grayscale-avatar-user-profile-person-icon-gender-neutral.jpg?s=612x612&w=0&k=20&c=UEa7oHoOL30ynvmJzSCIPrwwopJdfqzBs0q69ezQoM8=',
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<String>(
              future: _getUserName(),
              builder: (context, snapshot) {
                final greetingName = snapshot.data ?? 'Student';
                return Text(
                  "Hello $greetingName",
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                  ),
                );
              },
            ),
            Text(
              screenTitle,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
