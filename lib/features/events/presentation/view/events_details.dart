import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:repat_event/core/dialogs/app_dialog.dart';
import 'package:repat_event/core/themes/app_colors.dart';
import 'package:repat_event/core/widgets/app_text_button_widget.dart';
import 'package:repat_event/features/events/domain/entities/event.dart';
import 'package:repat_event/features/events/presentation/widgets/event_cancel_bottom_sheet.dart';
import 'package:repat_event/features/events/presentation/widgets/event_cancel_reason_bottom_sheet.dart';
import 'package:repat_event/features/events/presentation/widgets/event_ticket_buy_bottom_sheet.dart';

class EventsDetailsPageParams {
  const EventsDetailsPageParams({
    required this.event,
    this.userMode = false,
  });

  final Event event;
  final bool userMode;
}

class EventsDetails extends StatelessWidget {
  const EventsDetails({
    required this.params,
    super.key,
  });
  final EventsDetailsPageParams params;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    final isEventPassed = params.event.startDate.millisecondsSinceEpoch <
        DateTime.now().millisecondsSinceEpoch;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const HeroIcon(
            HeroIcons.chevronLeft,
          ),
        ),
        title: const Text('Event Details'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Ionicons.paper_plane_outline,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 20,
          top: 20,
          right: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: params.event.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: params.event.pictureUrl!,
                ),
              ),
            ),
            const Gap(20),
            Text(
              params.event.title,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            if (params.event.attendeeIDs!
                .contains(FirebaseAuth.instance.currentUser!.uid))
              const Text('You are a participant.'),
            const Gap(20),
            Column(
              spacing: 24,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    const Icon(
                      Ionicons.calendar_clear,
                      color: AppColors.black,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 2,
                      children: [
                        Text(
                          DateFormat('d MMM yyyy, EEEE')
                              .format(params.event.startDate),
                          style: const TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '''${DateFormat('HH:mm').format(params.event.startDate)} - ${DateFormat('HH:mm').format(params.event.endDate)}''',
                          style: const TextStyle(
                            color: AppColors.gray,
                          ),
                        ),
                        const AppTextButton(
                          title: 'Add to calendar',
                        ),
                      ],
                    ),
                  ],
                ),
                if (params.event.type == EventLocationType.offline)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      const Icon(
                        Ionicons.location,
                        color: AppColors.black,
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: size.width * 0.6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 2,
                          children: [
                            Text(
                              params.event.location!,
                              style: const TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Text(
                              'Offline',
                              style: TextStyle(
                                color: AppColors.gray,
                              ),
                            ),
                            const AppTextButton(
                              title: 'View on maps',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    const Icon(
                      Ionicons.people,
                      color: AppColors.black,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 2,
                      children: [
                        Text(
                          params.event.attendeeIDs?.length.toString() ?? '0',
                          style: const TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Text(
                          'Attendees',
                          style: TextStyle(
                            color: AppColors.gray,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const Gap(30),
            Text(
              'Event Details',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Gap(8),
            Text(
              params.event.description,
              style: const TextStyle(
                color: AppColors.gray,
              ),
            ),
            Gap(size.width * 0.4),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        decoration: BoxDecoration(
          color: const Color(0xffFFF9EF),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          spacing: 30,
          children: [
            if (params.userMode) ...[
              if (!isEventPassed)
                Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                      final hasCanceled =
                          await showEventCancelBottomSheet(context);

                      if (hasCanceled != null &&
                          hasCanceled &&
                          context.mounted) {
                        final reason = await showEventCancelReasonBottomSheet(
                          context,
                          params.event,
                        );

                        if (reason != null && context.mounted) {
                          unawaited(
                            showDialog(
                              context: context,
                              builder: (_) => const AppSuccessDialog(
                                title: 'Successful!',
                                subtitle:
                                    '''You have successfully canceled the event. 80% of the fonds will be returned to your account.''',
                              ),
                            ),
                          );
                        } else {
                          if (context.mounted) {
                            unawaited(
                              showDialog(
                                context: context,
                                builder: (_) => const AppFailedDialog(
                                  title: 'Failed to cancel !',
                                  subtitle:
                                      '''We weren't able to cancel you booking. Please try again later''',
                                ),
                              ),
                            );
                          }
                        }
                      }
                    },
                    child: const Text(
                      'Cancel Booking',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ] else if (params.event.pricing > 0 && !isEventPassed)
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Price',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '€ ${params.event.pricing.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            if (isEventPassed || params.event.status == EventStatus.completed)
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    context.push('/reviews');
                  },
                  child: const Text(
                    'Reviews',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            else if (!params.userMode)
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    showEventTicketBuyBottomSheet(context, params.event).then(
                      (value) {
                        if (context.mounted) {
                          if (value != null) {
                            showDialog<void>(
                              context: context,
                              builder: (_) {
                                if (!value) {
                                  return const AppFailedDialog(
                                    title: '''Payment was'nt successful!''',
                                    subtitle:
                                        '''We failed to complete your payment. Please try again.''',
                                  );
                                }
                                return const AppSuccessDialog(
                                  title: 'Payment was successful!',
                                  subtitle:
                                      'We are waiting for you at the event.',
                                  showContactButton: false,
                                );
                              },
                            ).whenComplete(() {
                              if (context.mounted) context.go('/events');
                            });
                          }
                        }
                      },
                    );
                  },
                  child: const Text(
                    'Tickets',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
