import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:repat_event/core/themes/app_colors.dart';

class AppSuccessDialog extends StatelessWidget {
  const AppSuccessDialog({
    required this.title,
    required this.subtitle,
    this.showContactButton = true,
    super.key,
  });

  final String title;
  final String subtitle;
  final bool showContactButton;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return AlertDialog(
      backgroundColor: const Color(0xffFDF6E4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
        side: const BorderSide(
          width: 2,
          color: Colors.white,
        ),
      ),
      content: Wrap(
        children: [
          Column(
            children: [
              const Gap(20),
              Stack(
                children: [
                  Align(
                    child: SvgPicture.asset(
                      'assets/successful.svg',
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        context.pop();
                      },
                      child: const Icon(
                        Ionicons.close,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(24),
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Gap(24),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.gray,
                  fontSize: 18,
                ),
              ),
              const Gap(32),
              if (showContactButton)
                SizedBox(
                  width: size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: const Text(
                      'Contact support',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class AppFailedDialog extends StatelessWidget {
  const AppFailedDialog({
    required this.title,
    required this.subtitle,
    super.key,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return AlertDialog(
      backgroundColor: const Color(0xffFDF6E4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
        side: const BorderSide(
          width: 2,
          color: Colors.white,
        ),
      ),
      content: Wrap(
        children: [
          Column(
            children: [
              const Gap(20),
              Stack(
                children: [
                  Align(
                    child: SvgPicture.asset(
                      'assets/no-upcoming-event.svg',
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        context.pop();
                      },
                      child: const Icon(
                        Ionicons.close,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(24),
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Gap(24),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.gray,
                  fontSize: 18,
                ),
              ),
              const Gap(32),
              SizedBox(
                width: size.width,
                child: ElevatedButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: const Text(
                    'Contact support',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
