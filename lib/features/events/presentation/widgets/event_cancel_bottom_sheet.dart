import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repat_event/core/themes/app_colors.dart';

class EventCancelBottomSheet extends StatelessWidget {
  const EventCancelBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.lightPeach,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 50,
                height: 7,
                decoration: BoxDecoration(
                  color: const Color(0xff9CA3AF),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const Gap(24),
            Center(
              child: Text(
                'Cancel Booking',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Gap(24),
            const Text(
              '''Are you sure you want to cancel your reservation for this event?''',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: AppColors.gray,
              ),
            ),
            const Gap(24),
            Row(
              spacing: 12,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      context.pop(false);
                    },
                    child: const Text(
                      'Don’t Cancel',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.pop(true);
                    },
                    child: const Text(
                      'Yes, Cancel',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Gap(18),
          ],
        ),
      ),
    );
  }
}

Future<bool?> showEventCancelBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: const EventCancelBottomSheet(),
    ),
  );
}
