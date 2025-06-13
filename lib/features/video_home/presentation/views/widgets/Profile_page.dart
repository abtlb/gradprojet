import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  final String name;
  final String username;

  const ProfilePage({
    super.key,
    required this.name,
    required this.username,
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            children: [
              // AppBar
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
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
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Edit',
                      style: GoogleFonts.poppins(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),

              // Profile
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.blue.shade100,
                  child: const Icon(Icons.person,
                      size: 60, color: Colors.black),
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  name,
                  style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              const SizedBox(height: 4),
              Center(
                child: Text(
                  "@$username",
                  style: GoogleFonts.poppins(
                      color: Colors.black54, fontSize: 14),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Container(
                  height: 4,
                  width: 90,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  contactAction(Icons.chat_bubble_outline, "Chat"),
                  contactAction(Icons.videocam, "Video"),
                ],
              ),
              const SizedBox(height: 30),

              // About Section
              sectionTitle("About"),
              userInfoCard("Email", "$username@example.com"),
              userInfoCard("Status", "Busy studying Flutter 💻"),
              userInfoCard("Lives in", "Cairo, Egypt"),
              userInfoCard("Works at", "Flutter Developer @ TechSoft"),

              const SizedBox(height: 30),
              sectionTitle("More actions"),
              infoTile(Icons.image, "Media, links and docs", trailing: "0"),
              infoTile(Icons.star_border, "Starred messages", trailing: "0"),
              infoTile(Icons.notifications_none, "Notifications"),
              infoTile(Icons.color_lens_outlined, "Chat theme"),
              infoTile(Icons.download_outlined, "Save to Photos",
                  trailing: "Default"),
              infoTile(Icons.lock_outline, "Encryption",
                  subtitle:
                  "Messages and calls are end-to-end encrypted."),

              const SizedBox(height: 20),

              // Block Button
              ListTile(
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                leading: const Icon(Icons.block, color: Colors.red),
                title: Text("Block Contact",
                    style: GoogleFonts.poppins(
                        color: Colors.red, fontWeight: FontWeight.w500)),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget contactAction(IconData icon, String label) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(14),
          child: Icon(icon, color: Colors.blueAccent),
        ),
        const SizedBox(height: 8),
        Text(label,
            style: GoogleFonts.poppins(fontSize: 13, color: Colors.black)),
      ],
    );
  }

  Widget infoTile(IconData icon, String title,
      {String? trailing, String? subtitle}) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(title,
          style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black)),
      subtitle: subtitle != null
          ? Text(subtitle,
          style: GoogleFonts.poppins(fontSize: 13, color: Colors.black54))
          : null,
      trailing: trailing != null
          ? Text(trailing,
          style:
          GoogleFonts.poppins(fontSize: 13, color: Colors.black54))
          : const Icon(Icons.arrow_forward_ios,
          size: 16, color: Colors.black54),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: GoogleFonts.poppins(
            fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
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
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
