import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:repat_event/core/dialogs/app_dialog.dart';
import 'package:repat_event/core/themes/app_colors.dart';
import 'package:repat_event/features/events/domain/entities/event.dart';
import 'package:repat_event/features/events/presentation/view/events_details.dart';
import 'package:repat_event/features/events/presentation/widgets/event_cancel_bottom_sheet.dart';
import 'package:repat_event/features/events/presentation/widgets/event_cancel_reason_bottom_sheet.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    required this.event,
    required this.userMode,
    super.key,
  });
  final Event event;
  final bool userMode;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    final isPassed = event.startDate.millisecondsSinceEpoch <
        DateTime.now().millisecondsSinceEpoch;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        context.push(
          '/events-details',
          extra: EventsDetailsPageParams(
            event: event,
            userMode: userMode,
          ),
        );
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: size.height * 0.17,
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: isPassed
                ? const BorderSide(
                    color: Colors.transparent,
                  )
                : const BorderSide(
                    color: Colors.white,
                    width: 1.5,
                  ),
          ),
          elevation: 2,
          color: const Color(0xffFFF9EF),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment:
                  userMode ? MainAxisAlignment.start : MainAxisAlignment.center,
              children: [
                Center(
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Hero(
                            tag: event.id,
                            child: SizedBox(
                              child: CachedNetworkImage(
                                imageUrl: event.pictureUrl!,
                                fit: BoxFit.fitHeight,
                                width: size.width * 0.3,
                              ),
                            ),
                          ),
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: size.width * 0.32,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            spacing: 10,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Ionicons.calendar_number,
                                    size: 16,
                                  ),
                                  const Gap(5),
                                  Text(
                                    DateFormat('d MMM yyy • h a')
                                        .format(event.startDate),
                                    style: const TextStyle(
                                      color: Color(0xff111827),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                      fontFamily: 'SFProDisplay',
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                event.title,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: GoogleFonts.poppins(
                                  height: 1.2,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24,
                                ),
                              ),
                              Row(
                                spacing: 5,
                                children: [
                                  const Icon(
                                    Ionicons.ticket,
                                    size: 16,
                                  ),
                                  Text(
                                    (event.ticketType == EventTicketType.free)
                                        ? 'Free'
                                        : '€ ${event.pricing.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      color: Color(0xff111827),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Online',
                              style: GoogleFonts.nunito(
                                color: event.type == EventLocationType.online
                                    ? AppColors.gray
                                    : Colors.transparent,
                              ),
                            ),
                            if (userMode) ...[
                              if (event.startDate.millisecondsSinceEpoch >
                                  DateTime.now().millisecondsSinceEpoch)
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: AppColors.blue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Text(
                                    'Paid',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 10,
                                    ),
                                  ),
                                )
                              else
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: AppColors.green,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Text(
                                    'Completed',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                if (userMode) ...[
                  const Gap(10),
                  const Divider(),
                  const Gap(10),
                  if (!isPassed && event.status != EventStatus.completed)
                    SizedBox(
                      width: size.width,
                      child: OutlinedButton(
                        onPressed: () async {
                          final hasCanceled =
                              await showEventCancelBottomSheet(context);

                          if (hasCanceled != null &&
                              hasCanceled &&
                              context.mounted) {
                            final reason =
                                await showEventCancelReasonBottomSheet(
                              context,
                              event,
                            );

                            if (reason != null && context.mounted) {
                              unawaited(
                                showDialog<void>(
                                  context: context,
                                  builder: (_) => const AppSuccessDialog(
                                    title: 'Successful!',
                                    subtitle:
                                        '''You have successfully canceled the event. 80% of the fonds will be returned to your account.''',
                                  ),
                                ).whenComplete(
                                  () {
                                    if (context.mounted) context.go('/events');
                                  },
                                ),
                              );
                            } else {
                              if (context.mounted) {
                                unawaited(
                                  showDialog<void>(
                                    context: context,
                                    builder: (_) => const AppFailedDialog(
                                      title: 'Failed to cancel !',
                                      subtitle:
                                          '''We weren't able to cancel you booking. Please try again later''',
                                    ),
                                  ).whenComplete(
                                    () {
                                      if (context.mounted) {
                                        context.go('/events');
                                      }
                                    },
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
                          ),
                        ),
                      ),
                    ),
                  if (isPassed || event.status == EventStatus.completed)
                    SizedBox(
                      width: size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          context.push('/reviews');
                        },
                        child: const Text(
                          'Reviews',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
