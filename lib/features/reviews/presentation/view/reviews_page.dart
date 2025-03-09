import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:ionicons/ionicons.dart';
import 'package:repat_event/core/themes/app_colors.dart';

import 'package:repat_event/features/reviews/presentation/bloc/reviews_bloc.dart';
import 'package:repat_event/features/reviews/presentation/widgets/write_review_bottom_sheet.dart';

class ReviewsPage extends StatelessWidget {
  const ReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: const ReviewsView(),
      create: (_) => ReviewsBloc(),
    );
  }
}

class ReviewsView extends StatelessWidget {
  const ReviewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightPeach,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const HeroIcon(
            HeroIcons.chevronLeft,
          ),
        ),
        title: const Text('Reviews'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Gap(16),

              // Average rating and stars
              Row(
                children: [
                  // Average rating number
                  const Text(
                    '4.8',
                    style: TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Rating bars
                  Expanded(
                    child: Column(
                      children: [
                        _buildRatingBar(5, 0.85),
                        const Gap(4),
                        _buildRatingBar(4, 0.7),
                        const Gap(4),
                        _buildRatingBar(3, 0.4),
                        const Gap(4),
                        _buildRatingBar(2, 0.3),
                        const Gap(4),
                        _buildRatingBar(1, 0.05),
                      ],
                    ),
                  ),
                ],
              ),

              // Stars row
              Row(
                children: [
                  ...List.generate(
                    4,
                    (index) => const Icon(
                      Ionicons.star,
                      color: Color(0xFFEBB85E),
                      size: 32,
                    ),
                  ),
                  const Icon(
                    Ionicons.star,
                    color: Color(0xFFE0E0E0),
                    size: 32,
                  ),
                ],
              ),

              const Gap(24),

              // Reviews list
              _buildReviewItem(
                name: 'Daniel Hamilton',
                rating: 5,
                timeAgo: '3 days ago',
                comment:
                    '''Lorem ipsum dolor sit amet consectetur. Est pharetra dui interdum lacus varius vulputate scelerisque nec. Orci duis mattis lacus faucibus porta gravida urna sed tempus.''',
                hasImages: true,
              ),

              const Divider(height: 40),

              _buildReviewItem(
                name: "Kevin O'connell",
                rating: 5,
                timeAgo: '7 days ago',
                comment:
                    '''Lorem ipsum dolor sit amet consectetur. Ligula sagittis sapien mauris parturient nec risus ultricies morbi consequat. Posuere ultrices ut nec risus non et semper vel. Sem vitae nunc eget in tempor. Diam amet vitae in accumsan eget.''',
                hasImages: false,
              ),

              const Gap(200),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 24,
        ),
        decoration: BoxDecoration(
          color: AppColors.lightPeach,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            showWriteReviewBottomSheet(context);
          },
          child: const Text(
            'Write reviews',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRatingBar(int ratingNumber, double percentage) {
    return Row(
      children: [
        SizedBox(
          width: 12,
          child: Text(
            '$ratingNumber',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Stack(
              children: [
                Container(
                  height: 8,
                  color: const Color(0xFFE0E0E0),
                ),
                FractionallySizedBox(
                  widthFactor: percentage,
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEBB85E),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReviewItem({
    required String name,
    required int rating,
    required String timeAgo,
    required String comment,
    required bool hasImages,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Reviewer info and rating
        Row(
          children: [
            // Profile image
            CircleAvatar(
              radius: 30,
              backgroundImage: CachedNetworkImageProvider(
                name == 'Daniel Hamilton'
                    ? 'https://randomuser.me/api/portraits/men/32.jpg'
                    : 'https://randomuser.me/api/portraits/men/47.jpg',
              ),
            ),
            const SizedBox(width: 12),

            // Name and rating
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(4),
                  Row(
                    children: [
                      ...List.generate(
                        rating,
                        (index) => const Icon(
                          Ionicons.star,
                          color: Color(0xFFEBB85E),
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        timeAgo,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),

        const Gap(16),

        // Review comment
        Text(
          comment,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
            height: 1.5,
          ),
        ),

        if (comment.length > 100)
          GestureDetector(
            onTap: () {
              // Toggle showing full comment
            },
            child: const Text(
              'Less',
              style: TextStyle(
                color: Color(0xFF1A1A1A),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

        if (hasImages) ...[
          const Gap(16),

          // Image gallery
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                  width: 120,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: const DecorationImage(
                      image: CachedNetworkImageProvider(
                        'https://images.unsplash.com/photo-1623794104296-b80b3992066d?q=80&w=2070&auto=format&fit=crop',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ],
    );
  }
}
