import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repat_event/core/themes/app_colors.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({
    required this.title,
    required this.subtitle,
    super.key,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Wrap(
      children: [
        Column(
          children: [
            const Gap(20),
            Align(
              child: SvgPicture.asset(
                'assets/no-upcoming-event.svg',
              ),
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
                  'Ok',
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
    );
  }
}
