import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Screens/homepage.dart';
import 'Screens/onboardingscreen.dart'; // Your Home Page
 const apiKey = 'AIzaSyB7oMDw2XRUz-yWwfCiWCLrulbKY_1uKWo'; // Replace with your actual API key
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green.shade700,
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          headlineLarge: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green.shade800),
          bodyLarge: GoogleFonts.poppins(fontSize: 16, color: Colors.green.shade900),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green.shade700,
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
        ),
      ),
      home: OnboardingScreen(),
      routes: {
        '/home': (context) => ChatScreen(), // Your main screen
      },
    );
  }
}
