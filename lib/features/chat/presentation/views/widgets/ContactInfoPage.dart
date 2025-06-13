import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactInfoPage extends StatelessWidget {
  final String firstName;
  final String secondName;
  final String dateOfBirth;

  const ContactInfoPage({
    super.key,
    required this.firstName,
    required this.secondName,
    required this.dateOfBirth,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE3F2FD), Color(0xFFFFFFFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Contact Info',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.blue.shade100,
                  child: const Icon(Icons.person, size: 60, color: Colors.black),
                ),
              ),
              const SizedBox(height: 20),

              userInfoCard("First Name", firstName),
              userInfoCard("Second Name", secondName),
              userInfoCard("Date of Birth", dateOfBirth),
            ],
          ),
        ),
      ),
    );
  }

  Widget userInfoCard(String label, String value) {
    return Card(
      elevation: 3,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Text(
              "$label: ",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                fontSize: 15,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                value,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
