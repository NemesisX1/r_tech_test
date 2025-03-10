import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:repat_event/core/themes/app_colors.dart';
import 'package:repat_event/core/widgets/action_button_widget.dart';
import 'package:repat_event/features/events/domain/entities/event.dart';
import 'package:repat_event/features/events/domain/entities/event_filter.dart';

class EventFilterBottomSheet extends StatefulWidget {
  const EventFilterBottomSheet({
    super.key,
    this.filter,
  });

  final EventFilter? filter;

  @override
  State<EventFilterBottomSheet> createState() => _EventFilterBottomSheetState();
}

class _EventFilterBottomSheetState extends State<EventFilterBottomSheet> {
  late EventFilter _filter;

  @override
  void initState() {
    super.initState();
    _filter = widget.filter ??
        const EventFilter(
          eventType: EventLocationType.offline,
        );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.lightPeach,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
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
              const Gap(16),
              Center(
                child: Text(
                  'Filter',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Gap(24),
              const Text(
                'Choose from calendar',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  readOnly: true,
                  onTap: () {
                    showDatePicker(
                      context: context,
                      firstDate: DateTime(2023),
                      lastDate: DateTime(2026),
                    ).then((date) {
                      if (date != null) {
                        setState(() {
                          _filter = _filter.copyWith(timeFilter: date);
                        });
                      }
                    });
                  },
                  decoration: InputDecoration(
                    hintText: _filter.timeFilter != null
                        ? DateFormat('dd.MM.yyyy').format(_filter.timeFilter!)
                        : 'Ex 01.01.2023',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: const Icon(
                      Icons.calendar_today,
                      color: Color(0xFFEBB85E),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
              const Gap(24),
              const Text(
                'Status',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildStatusChip(EventStatus.paid),
                  _buildStatusChip(EventStatus.completed),
                  _buildStatusChip(EventStatus.upcoming),
                  _buildStatusChip(EventStatus.canceled),
                ],
              ),
              const Gap(24),
              const Text(
                'Pick Event Type',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(12),
              Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: _buildEventTypeChip(
                      EventLocationType.offline,
                    ),
                  ),
                  Expanded(
                    child: _buildEventTypeChip(
                      EventLocationType.online,
                    ),
                  ),
                ],
              ),
              const Gap(24),
              Row(
                spacing: 12,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        context.pop(context);
                      },
                      child: const Text(
                        'Cancel',
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
                        context.pop(_filter);
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(EventStatus label) {
    final isSelected = _filter.status.contains(label);

    return GestureDetector(
      onTap: () {
        setState(() {
          final newStatus = List<EventStatus>.from(_filter.status);
          if (isSelected) {
            newStatus.remove(label);
          } else {
            newStatus.add(label);
          }
          _filter = _filter.copyWith(status: newStatus);
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.secondary,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: AppColors.secondary,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label.name,
              style: TextStyle(
                fontFamily: 'SFProDisplay',
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (isSelected)
              const Padding(
                padding: EdgeInsets.only(left: 4),
                child: Icon(
                  Ionicons.close,
                  color: Colors.white,
                  size: 16,
                ),
              )
            else
              const Padding(
                padding: EdgeInsets.only(left: 4),
                child: Icon(
                  Ionicons.add,
                  color: AppColors.green,
                  size: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventTypeChip(EventLocationType label) {
    final isSelected = _filter.eventType == label;

    return ActionButton(
      title: label.name,
      isActionned: isSelected,
      onPressed: () {
        setState(() {
          _filter = _filter.copyWith(eventType: label);
        });
      },
    );
  }
}

Future<EventFilter?> showFilterBottomSheet(
  BuildContext context, {
  EventFilter? filter,
}) {
  return showModalBottomSheet<EventFilter?>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: EventFilterBottomSheet(
        filter: filter,
      ),
    ),
  );
}
