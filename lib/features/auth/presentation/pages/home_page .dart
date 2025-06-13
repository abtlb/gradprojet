import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled3/core/util/app_route.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> icons = [
    {'icon': Icons.school, 'label': 'Learning', 'route': AppRoute.learningStart},
    {'icon': Icons.chat, 'label': 'Chat', 'route': AppRoute.chatHomePath},
    {'icon': Icons.zoom_in, 'label': 'Magnify', 'route': AppRoute.magnifierPath},
    {'icon': Icons.alarm, 'label': 'Alarm', 'route': AppRoute.alarmPath},
    {'icon': Icons.hearing, 'label': 'Sound Detection', 'route': AppRoute.soundDetection},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFE3F2FD),
              Color(0xFFBBDEFB),
              Color(0xFF90CAF9),
              Color(0xFF64B5F6),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              // صورة اليد التعبيرية بدل الأيقونة
              SizedBox(
                width: 350,
                height: 175,
                child: Image.asset('assets/asound.png'),
              ),
              const SizedBox(height: 16),
              Text(
                "Choose Feature ",
                style: GoogleFonts.poppins(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Empowering communication for the deaf and mute community.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: icons.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    final item = icons[index];
                    return _PillButton(
                      icon: item['icon'],
                      label: item['label'],
                      onTap: () => context.go(item['route']),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _PillButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _PillButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  State<_PillButton> createState() => _PillButtonState();
}

class _PillButtonState extends State<_PillButton> {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _scale = 0.95;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _scale = 1.0;
    });
  }

  void _onTapCancel() {
    setState(() {
      _scale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _scale,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOut,
      child: Material(
        color: Colors.white,
        elevation: 6,
        shadowColor: Colors.blueAccent.withOpacity(0.3),
        borderRadius: BorderRadius.circular(40),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(40),
          onTapDown: _onTapDown,
          onTapUp: _onTapUp,
          onTapCancel: _onTapCancel,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.blueAccent.withOpacity(0.15),
                  child: Icon(widget.icon, size: 28, color: Colors.blueAccent),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    widget.label,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      height: 1.3,
                    ),
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
