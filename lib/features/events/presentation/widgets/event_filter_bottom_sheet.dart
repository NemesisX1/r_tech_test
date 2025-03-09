import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:repat_event/core/themes/app_colors.dart';
import 'package:repat_event/core/widgets/action_button_widget.dart';

class EventFilterBottomSheet extends StatefulWidget {
  const EventFilterBottomSheet({super.key});

  @override
  State<EventFilterBottomSheet> createState() => _EventFilterBottomSheetState();
}

class _EventFilterBottomSheetState extends State<EventFilterBottomSheet> {
  String? _selectedTimeFilter;
  final List<String> _selectedStatus = ['Paid', 'Completed'];
  String? _selectedEventType;

  @override
  void initState() {
    super.initState();
    _selectedTimeFilter = 'Today';
    _selectedEventType = 'Offline';
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

              // Time & Date section
              const Text(
                'Time & Date',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(12),

              // Time filter chips
              Row(
                children: [
                  _buildTimeFilterChip('Today'),
                  const Gap(8),
                  _buildTimeFilterChip('Tomorrow'),
                  const Gap(8),
                  _buildTimeFilterChip('This week'),
                ],
              ),
              const Gap(16),

              // Calendar picker
              const Text(
                'Choose from calendar',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Gap(8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Ex 01.01.2023',
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

              // Status section
              const Text(
                'Status',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(12),

              // Status filter chips
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildStatusChip('Paid'),
                  _buildStatusChip('Completed'),
                  _buildStatusChip('Write now'),
                  _buildStatusChip('Canceled'),
                  _buildStatusChip('Upcoming'),
                ],
              ),
              const Gap(24),

              // Event Type section
              const Text(
                'Pick Event Type',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(12),

              // Event type filter
              Row(
                spacing: 8,
                children: [
                  Expanded(child: _buildEventTypeChip('Offline')),
                  Expanded(child: _buildEventTypeChip('Online')),
                ],
              ),
              const Gap(24),

              // Bottom buttons
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
                        // Save filters and close
                        context.pop({
                          'timeFilter': _selectedTimeFilter,
                          'status': _selectedStatus,
                          'eventType': _selectedEventType,
                        });
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

  Widget _buildTimeFilterChip(String label) {
    final isSelected = _selectedTimeFilter == label;

    return Expanded(
      child: ActionButton(
        title: label,
        isActionned: isSelected,
        onPressed: () {
          setState(() {
            _selectedTimeFilter = label;
          });
        },
      ),
    );
  }

  Widget _buildStatusChip(String label) {
    final isSelected = _selectedStatus.contains(label);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedStatus.remove(label);
          } else {
            _selectedStatus.add(label);
          }
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
              label,
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

  Widget _buildEventTypeChip(String label) {
    final isSelected = _selectedEventType == label;

    return ActionButton(
      title: label,
      isActionned: isSelected,
      onPressed: () {
        setState(() {
          _selectedEventType = label;
        });
      },
    );
  }
}

void showFilterBottomSheet(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: const EventFilterBottomSheet(),
    ),
  );
}
