import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:repat_event/core/themes/app_colors.dart';
import 'package:repat_event/core/widgets/action_button_widget.dart';
import 'package:repat_event/core/widgets/app_error_widget.dart';
import 'package:repat_event/core/widgets/loader_widget.dart';
import 'package:repat_event/features/events/domain/entities/event.dart';
import 'package:repat_event/features/events/presentation/bloc/events_bloc.dart';
import 'package:repat_event/features/events/presentation/widgets/event_card.dart';
import 'package:repat_event/features/events/presentation/widgets/event_filter_bottom_sheet.dart';
import 'package:repat_event/locator.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<EventsBloc>(),
      child: const EventsView(),
    );
  }
}

class EventsView extends StatefulWidget {
  const EventsView({super.key});

  @override
  State<EventsView> createState() => _EventsViewState();
}

class _EventsViewState extends State<EventsView> {
  bool showAllEvents = true;

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
          'Events',
        ),
        actions: [
          IconButton(
            onPressed: () {
              showFilterBottomSheet(context);
            },
            icon: const HeroIcon(
              HeroIcons.funnel,
              style: HeroIconStyle.solid,
              size: 30,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          top: 20,
          right: 20,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ActionButton(
                    isActionned: showAllEvents,
                    title: 'All events',
                    onPressed: () {
                      setState(() {
                        showAllEvents = true;
                      });
                      context.read<EventsBloc>().add(const EventsFetchEvents());
                    },
                  ),
                ),
                const Gap(20),
                Expanded(
                  child: ActionButton(
                    title: 'My events',
                    isActionned: !showAllEvents,
                    onPressed: () {
                      setState(() {
                        showAllEvents = false;
                      });

                      context
                          .read<EventsBloc>()
                          .add(const EventsFetchRegisteredEvents());
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: BlocBuilder<EventsBloc, EventsState>(
                builder: (context, state) {
                  if (state is EventsInitial) {
                    context.read<EventsBloc>().add(const EventsFetchEvents());
                  }

                  if (state is EventsLoading) {
                    return const Loader();
                  }

                  if (state is EventsFetchFailedState) {
                    return const Padding(
                      padding: EdgeInsets.all(23),
                      child: AppErrorWidget(
                        title: 'No events for you :(',
                        subtitle:
                            '''Sorry, events are not available for you, you are in the black list, contact support for a solution''',
                      ),
                    );
                  }

                  if (state is EventsFetchSuccessState) {
                    if (state.events.isEmpty) {
                      if (showAllEvents) {
                        return const Padding(
                          padding: EdgeInsets.all(20),
                          child: AppErrorWidget(
                            title: 'No events for you :(',
                            subtitle:
                                '''Sorry, events are not available for you, you are in the black list, contact support for a solution''',
                          ),
                        );
                      }

                      return Column(
                        children: [
                          const Gap(20),
                          Align(
                            child: SvgPicture.asset(
                              'assets/search-event.svg',
                            ),
                          ),
                          const Gap(24),
                          Text(
                            'Empty Tickets',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Gap(24),
                          const Text(
                            '''
Looks like you don't have a ticket yet.
Start searching for events now by clicking the button below.''',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.gray,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      );
                    }

                    return SingleChildScrollView(
                      padding: const EdgeInsets.only(top: 15),
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: state.events
                            .map(
                              (e) => EventCard(
                                event: e,
                                userMode: !showAllEvents,
                              ),
                            )
                            .toList(),
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
