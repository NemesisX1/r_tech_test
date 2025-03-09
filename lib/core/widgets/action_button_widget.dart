import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repat_event/core/themes/app_colors.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    required this.title,
    super.key,
    this.onPressed,
    this.isActionned = false,
  });

  final String title;
  final bool isActionned;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed ?? () {},
      style: (isActionned
              ? ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  side: const BorderSide(
                    color: Color(0xffFFF2CF),
                    width: 2,
                  ),
                )
              : ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffFFF2CF),
                  elevation: 0,
                  side: const BorderSide(
                    width: 2,
                    color: Color(0xffFFF2CF),
                  ),
                ))
          .copyWith(
        elevation: const WidgetStatePropertyAll(0),
      ),
      child: Text(
        title,
        style: GoogleFonts.nunito(
          fontWeight: FontWeight.bold,
          color: isActionned ? Colors.white : Colors.black,
          fontSize: 16,
        ),
      ),
    );
  }
}
