import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:repat_event/features/auth/presentation/view/auth_page.dart';
import 'package:repat_event/features/events/domain/entities/event.dart';
import 'package:repat_event/features/events/presentation/view/events_details.dart';
import 'package:repat_event/features/events/presentation/view/events_page.dart';
import 'package:repat_event/features/notifications/presentation/view/notifications_page.dart';
import 'package:repat_event/features/reviews/presentation/view/reviews_page.dart';
import 'package:repat_event/features/search/presentation/view/search_page.dart';

final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

final router = GoRouter(
  initialLocation: FirebaseAuth.instance.currentUser == null ? '/' : '/events',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AuthPage(),
    ),
    GoRoute(
      path: '/notifications',
      builder: (context, state) => const NotificationsPage(),
    ),
    GoRoute(
      path: '/events-details',
      builder: (context, state) {
        final params = state.extra as EventsDetailsPageParams?;

        return EventsDetails(
          params: params!,
        );
      },
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) =>
          ScaffoldWithMainNavigationBar(child: child),
      routes: <RouteBase>[
        GoRoute(
          path: '/search',
          builder: (context, state) => const SearchPage(),
        ),
        GoRoute(
          path: '/feed',
          builder: (context, state) => const Scaffold(),
        ),
        GoRoute(
          path: '/events',
          builder: (context, state) => const EventsPage(),
        ),
        GoRoute(
          path: '/contact',
          builder: (context, state) => const Scaffold(),
        ),
        GoRoute(
          path: '/chat',
          builder: (context, state) => const Scaffold(),
        ),
      ],
    ),
    GoRoute(
      path: '/reviews',
      builder: (context, state) => const ReviewsPage(),
    ),
  ],
);

class ScaffoldWithMainNavigationBar extends StatelessWidget {
  const ScaffoldWithMainNavigationBar({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: child,
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
            ),
            color: Colors.transparent,
          ),
          child: const _MainNavigationBar(),
        ),
      ),
    );
  }
}

class _MainNavigationBar extends StatelessWidget {
  const _MainNavigationBar();

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Ionicons.search_outline,
          ),
          activeIcon: Icon(
            Ionicons.search,
          ),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Ionicons.newspaper_outline,
          ),
          activeIcon: Icon(
            Ionicons.newspaper,
          ),
          label: 'Feed',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Ionicons.calendar_clear_outline,
          ),
          activeIcon: Icon(
            Ionicons.calendar_clear,
          ),
          label: 'Events',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Ionicons.people_outline,
          ),
          activeIcon: Icon(
            Ionicons.people,
          ),
          label: 'Contacts',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Ionicons.chatbox_ellipses_outline,
          ),
          activeIcon: Icon(
            Ionicons.chatbox_ellipses,
          ),
          label: 'Chat',
        ),
      ],
      currentIndex: _calculateSelectedIndex(context),
      onTap: (index) => _onDestinationSelected(index, context),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    if (location.startsWith('/search')) {
      return 0;
    }
    if (location.startsWith('/feed')) {
      return 1;
    }
    if (location.startsWith('/events')) {
      return 2;
    }

    if (location.startsWith('/contact')) {
      return 3;
    }

    if (location.startsWith('/chat')) {
      return 4;
    }

    return 0;
  }

  void _onDestinationSelected(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/search');
      case 1:
        context.go('/feed');
      case 2:
        context.go('/events');
      case 3:
        context.go('/contact');
      case 4:
        context.go('/chat');
    }
  }
}
