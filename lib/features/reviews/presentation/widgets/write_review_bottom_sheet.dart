import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:repat_event/core/themes/app_colors.dart';

class ReviewWritingBottomSheet extends StatefulWidget {
  const ReviewWritingBottomSheet({super.key});

  @override
  State<ReviewWritingBottomSheet> createState() =>
      _ReviewWritingBottomSheetState();
}

class _ReviewWritingBottomSheetState extends State<ReviewWritingBottomSheet> {
  int rating = 3;
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.lightPeach,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
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
              'How was your\nexperience in\nSaurabh Kumar?',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Gap(20),

          // Rating display
          Row(
            children: [
              const Text(
                'Your rating',
                style: TextStyle(
                  color: Color(0xFF192E44),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Gap(10),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEAA4B),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  '$rating.0',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const Gap(15),

          // Star rating
          Row(
            children: List.generate(5, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    rating = index + 1;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Icon(
                    Ionicons.star,
                    color: index < rating
                        ? const Color(0xFFEEAA4B)
                        : Colors.grey[300],
                    size: 36,
                  ),
                ),
              );
            }),
          ),
          const Gap(20),

          // Other comments section
          const Text(
            'Other',
            style: TextStyle(
              color: Color(0xFF192E44),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Gap(8),
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: TextField(
              controller: _commentController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10),
              ),
              maxLines: null,
            ),
          ),
          const Gap(12),

          // Character count
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${_commentController.text.length}/2,000 maximum characters allowed',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ),
          const Gap(12),

          // Add photo button
          OutlinedButton(
            onPressed: () {},
            child: const Text(
              'Add photo',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Gap(15),

          // Bottom buttons
          Row(
            children: [
              // Cancel button
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const Gap(10),

              // Save button
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Gap(16),
        ],
      ),
    );
  }
}

Future<String?> showWriteReviewBottomSheet(BuildContext context) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: const ReviewWritingBottomSheet(),
    ),
  );
}
