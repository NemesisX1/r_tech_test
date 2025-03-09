import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: SvgPicture.asset(
            'assets/logo.svg',
            theme: const SvgTheme(
              xHeight: 20,
            ),
          ),
        ),
        title: const Text(
          'Search',
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.push('/notifications');
            },
            icon: const HeroIcon(
              HeroIcons.bell,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const HeroIcon(
              HeroIcons.userCircle,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
