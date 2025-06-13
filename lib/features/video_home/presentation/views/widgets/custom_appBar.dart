import 'package:flutter/material.dart';
import 'package:untitled3/core/util/styles.dart';
import 'package:untitled3/core/util/widgets/custom_iconButton.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            offset: const Offset(0, 3),
            blurRadius: 8,
          ),
        ],
      ),
      padding: const EdgeInsets.only(
        top: 50,
        left: 30,
        right: 30,
        bottom: 12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Material(
                color: Colors.transparent,
                shape: const CircleBorder(),
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () => context.go('/main'),
                  splashColor: Colors.blue.withOpacity(0.3),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back, color: Colors.blue, size: 28),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Chats',
                style: Styles.textStyle30.copyWith(
                  color: Colors.blue.shade700,
                  height: 1.2,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          // زر الملف الشخصي مع تصميم أفضل
          Material(
            color: Colors.blue.shade50,
            shape: const CircleBorder(),
            elevation: 3,
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () {
                Scaffold.of(context).openEndDrawer();
              },
              splashColor: Colors.blue.withOpacity(0.3),
              child: Padding(
                padding: const EdgeInsets.all(6), // تحكم في المساحة الداخلية
                child: Icon(
                  Icons.account_circle_rounded,
                  color: Colors.blue.shade700,
                  size: 36,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
