import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:repat_event/core/themes/app_colors.dart';
import 'package:repat_event/core/widgets/loader_widget.dart';
import 'package:repat_event/features/events/domain/entities/event.dart';

class EventTicketBuyBottomSheet extends StatefulWidget {
  const EventTicketBuyBottomSheet({
    required this.event,
    required this.onCancelBooking,
    super.key,
  });

  final Event event;
  final Future<void> Function(int ticketCount) onCancelBooking;

  @override
  State<EventTicketBuyBottomSheet> createState() =>
      _EventTicketBuyBottomSheetState();
}

class _EventTicketBuyBottomSheetState extends State<EventTicketBuyBottomSheet> {
  int ticketCount = 1;
  String? promoCode;
  bool isApplePaySelected = true;
  final TextEditingController nameController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Container(
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
          const Gap(44),
          Row(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://images.unsplash.com/photo-1623794104296-b80b3992066d?q=80&w=2070&auto=format&fit=crop',
                    fit: BoxFit.fitHeight,
                    height: size.height * 0.1,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 7,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat('d MMM • h a')
                              .format(widget.event.startDate),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        if (widget.event.type == EventLocationType.online)
                          Text(
                            'Online',
                            style: GoogleFonts.nunito(),
                          ),
                      ],
                    ),
                    Text(
                      widget.event.title,
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
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
                          '\$${widget.event.pricing}',
                          style: const TextStyle(
                            color: Color(0xff111827),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            fontFamily: 'SFProDisplay',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Ticket Counter
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Choose the ticket',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                spacing: 5,
                children: [
                  IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.lightPeach,
                      side: const BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                      shape: const CircleBorder(),
                      elevation: 10,
                    ),
                    onPressed: () {
                      if (ticketCount > 1) {
                        setState(() => ticketCount--);
                      }
                    },
                    icon: const Icon(
                      Ionicons.remove,
                      size: 20,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    '$ticketCount',
                    style: const TextStyle(fontSize: 16),
                  ),
                  IconButton(
                    onPressed: () => setState(() => ticketCount++),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.lightPeach,
                      side: const BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                      shape: const CircleBorder(),
                      elevation: 10,
                    ),
                    icon: const Icon(
                      Ionicons.add,
                      size: 20,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Gap(16),
          const Text(
            'Payment methods',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Gap(12),
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.gray.withValues(alpha: .5),
              ),
            ),
            child: RadioListTile(
              value: true,
              groupValue: isApplePaySelected,
              onChanged: (value) => setState(() => isApplePaySelected = true),
              title: Row(
                children: [
                  const Text('Apple Pay'),
                  const Spacer(),
                  Brand(
                    Brands.apple_pay,
                    size: 50,
                  ),
                  const Gap(8),
                ],
              ),
              contentPadding: EdgeInsets.zero,
            ),
          ),
          const Gap(12),
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.gray.withValues(alpha: .5),
              ),
            ),
            child: RadioListTile(
              value: false,
              groupValue: isApplePaySelected,
              onChanged: (value) => setState(() => isApplePaySelected = false),
              title: Row(
                children: [
                  const Text('Credit Card'),
                  const Spacer(),
                  Brand(
                    Brands.visa,
                    size: 50,
                  ),
                  const Gap(8),
                  Brand(
                    Brands.mastercard,
                    size: 50,
                  ),
                  const Gap(8),
                ],
              ),
              contentPadding: EdgeInsets.zero,
            ),
          ),
          const Gap(24),
          ElevatedButton(
            onPressed: () {
              if (!_isLoading) {
                setState(() {
                  _isLoading = true;
                });

                widget.onCancelBooking(ticketCount).then(
                  (_) {
                    if (context.mounted) context.pop(true);
                  },
                ).catchError(
                  (_) {
                    if (context.mounted) context.pop(false);
                  },
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFB42318),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: _isLoading
                ? const Loader(
                    color: Colors.white,
                    size: 50,
                  )
                : Text(
                    '''Buy (Total : € ${(ticketCount * widget.event.pricing).toStringAsFixed(2)})''',
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
          ),
          const Gap(16),
        ],
      ),
    );
  }
}

Future<bool?> showEventTicketBuyBottomSheet(
  BuildContext context,
  Event event,
  Future<void> Function(int ticketCount) onCancelBooking,
) {
  return showModalBottomSheet<bool?>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: EventTicketBuyBottomSheet(
        event: event,
        onCancelBooking: onCancelBooking,
      ),
    ),
  );
}
