import 'package:flutter/material.dart';

class AppSnackBar {
  static void showSuccess(BuildContext context, String message) {
    _show(context, message, isError: false);
  }

  static void showError(BuildContext context, String message) {
    _show(context, message, isError: true);
  }

  static void showInfo(BuildContext context, String message) {
    _show(context, message, isError: false, isInfo: true);
  }

  static void _show(BuildContext context, String message, {required bool isError, bool isInfo = false}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color iconColor = const Color(0xFF10B981);
    IconData iconData = Icons.check_circle_rounded;

    if (isError) {
      iconColor = const Color(0xFFEF4444);
      iconData = Icons.error_outline_rounded;
    } else if (isInfo) {
      iconColor = const Color(0xFF06B6D4);
      iconData = Icons.info_outline_rounded;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        margin: const EdgeInsets.only(bottom: 90, left: 16, right: 16),
        duration: const Duration(seconds: 3),
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E293B) : const Color(0xFF0F172A),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isError
                  ? const Color(0xFFEF4444).withOpacity(0.5)
                  : (isInfo ? const Color(0xFF06B6D4).withOpacity(0.5) : Theme.of(context).colorScheme.primary.withOpacity(0.4)),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.35),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(iconData, color: iconColor, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
