import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repat_event/core/themes/app_colors.dart';
import 'package:repat_event/features/events/data/repositories/events_repository_impl.dart';
import 'package:repat_event/features/events/domain/entities/event.dart';
import 'package:repat_event/locator.dart';

class EventCancelReasonBottomSheet extends StatefulWidget {
  const EventCancelReasonBottomSheet({
    super.key,
    required this.event,
  });

  final Event event;
  @override
  State<EventCancelReasonBottomSheet> createState() =>
      _EventCancelReasonBottomSheetState();
}

class _EventCancelReasonBottomSheetState
    extends State<EventCancelReasonBottomSheet> {
  String? _selectedReason;
  final TextEditingController _otherReasonController = TextEditingController();

  final eventRepository = locator<EventsRepositoryImpl>();

  // List of cancellation reasons
  final List<String> _cancellationReasons = [
    'I have another event, so it colides',
    "I'm sick, can't come",
    'I have an urgent need',
    'I have no transportation to come',
    'I have no friends to come',
    'I want to book another event',
    'I just want to cancel',
  ];

  @override
  void initState() {
    super.initState();
    _selectedReason = _cancellationReasons[0];
  }

  @override
  void dispose() {
    _otherReasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.lightPeach,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
            const Center(
              child: Text(
                'Please select the reason for cancellation:',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Gap(16),

            ...List.generate(_cancellationReasons.length, (index) {
              final reason = _cancellationReasons[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedReason = reason;
                    });
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: _selectedReason == reason
                                ? const Color(0xFFEBB85E)
                                : Colors.grey.shade400,
                            width: 2,
                          ),
                        ),
                        child: _selectedReason == reason
                            ? Center(
                                child: Container(
                                  width: 14,
                                  height: 14,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFFEBB85E),
                                  ),
                                ),
                              )
                            : null,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          reason,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

            const Gap(8),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Other',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Gap(8),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
              ),
              child: TextField(
                controller: _otherReasonController,
                maxLines: 4,
                maxLength: 2000,
                decoration: const InputDecoration(
                  hintText: 'Enter your reason here...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(12),
                  counterText: '',
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),

            // Character count
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${_otherReasonController.text.length}/2,000 maximum characters allowed',
                style: TextStyle(
                  fontFamily: 'SFProDisplay',
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            const Gap(24),

            // Cancel booking button
            ElevatedButton(
              onPressed: () {
                // Process cancellation
                final reason = _otherReasonController.text.isNotEmpty
                    ? _otherReasonController.text
                    : _selectedReason;

                eventRepository
                    .cancelUserBookingFromEvent(
                  eventId: widget.event.id,
                  userId: FirebaseAuth.instance.currentUser!.uid,
                  reason: reason,
                )
                    .then((value) {
                  if (context.mounted) context.pop(reason);
                }).catchError((error) {
                  if (context.mounted) context.pop();
                });
              },
              child: const Text(
                'Cancel Booking',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const Gap(16),
          ],
        ),
      ),
    );
  }
}

Future<String?> showEventCancelReasonBottomSheet(
  BuildContext context,
  Event event,
) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: EventCancelReasonBottomSheet(
        event: event,
      ),
    ),
  );
}
