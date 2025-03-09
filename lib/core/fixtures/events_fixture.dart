// ignore_for_file: lines_longer_than_80_chars

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repat_event/features/events/data/models/event_model.dart';
import 'package:repat_event/features/events/domain/entities/event.dart';
import 'package:repat_event/locator.dart';
import 'package:uuid/uuid.dart';

final List<Event> eventsFixture = [
  // Past events with completed status
  Event(
    id: const Uuid().v4(),
    title: 'Past Tech Conference',
    startDate: DateTime(2024, 12, 10, 9),
    endDate: DateTime(2024, 12, 10, 17),
    status: EventStatus.completed,
    ticketType: EventTicketType.paid,
    type: EventLocationType.offline,
    pricing: 199.99,
    location: 'London Tech Hub, 123 Tech Street, London, UK',
    pictureUrl:
        'https://images.unsplash.com/photo-1540575467063-178a50c2df87?q=80&w=2070&auto=format&fit=crop',
    description:
        'A comprehensive tech conference covering the latest trends in software development.',
    rating: 4.9,
  ),
  Event(
    id: const Uuid().v4(),
    title: 'Past Web Development Workshop',
    startDate: DateTime(2025, 1, 15, 10),
    endDate: DateTime(2025, 1, 15, 16),
    status: EventStatus.completed,
    ticketType: EventTicketType.free,
    type: EventLocationType.online,
    pictureUrl:
        'https://images.unsplash.com/photo-1573164713988-8665fc963095?q=80&w=2069&auto=format&fit=crop',
    description:
        'Learn about modern web development techniques and frameworks.',
    rating: 4.6,
  ),
  Event(
    id: const Uuid().v4(),
    title: 'Data Science Symposium',
    startDate: DateTime(2025, 2, 15, 9),
    endDate: DateTime(2025, 2, 15, 17),
    status: EventStatus.upcoming,
    ticketType: EventTicketType.paid,
    type: EventLocationType.offline,
    pricing: 249.99,
    location:
        'Berlin Convention Center, Alexanderstraße 11, 10178 Berlin, Germany',
    pictureUrl:
        'https://images.unsplash.com/photo-1551288049-bebda4e38f71?q=80&w=2070&auto=format&fit=crop',
    description:
        'A comprehensive symposium on the latest advancements in data science, big data analytics, and their applications across industries.',
    rating: 4.8,
  ),
  Event(
    id: const Uuid().v4(),
    title: 'Cloud Computing Workshop',
    startDate: DateTime(2025, 3, 1, 10),
    endDate: DateTime(2025, 3, 1, 16),
    status: EventStatus.upcoming,
    ticketType: EventTicketType.free,
    type: EventLocationType.online,
    pictureUrl:
        'https://images.unsplash.com/photo-1544197150-b99a580bb7a8?q=80&w=2070&auto=format&fit=crop',
    description:
        'Learn about modern cloud architecture, serverless computing, and best practices for cloud migration strategies.',
    rating: 4.5,
  ),
  Event(
    id: const Uuid().v4(),
    title: 'Flutter Conference 2025',
    startDate: DateTime(2025, 5, 10, 9),
    endDate: DateTime(2025, 5, 10, 17),
    status: EventStatus.upcoming,
    ticketType: EventTicketType.paid,
    type: EventLocationType.offline,
    pricing: 299.99,
    location: 'Moscone Center, 747 Howard St, San Francisco, CA 94103',
    pictureUrl:
        'https://images.unsplash.com/photo-1591115765373-5207764f72e7?q=80&w=2070&auto=format&fit=crop',
    description:
        'Join us for the biggest Flutter conference of 2025! Learn from experts, network with fellow developers, and discover the latest in Flutter development.',
  ),
  Event(
    id: const Uuid().v4(),
    title: 'AI & ML Workshop',
    startDate: DateTime(2025, 6, 15, 14),
    endDate: DateTime(2025, 6, 15, 18),
    status: EventStatus.upcoming,
    ticketType: EventTicketType.free,
    type: EventLocationType.online,
    pictureUrl:
        'https://images.unsplash.com/photo-1485827404703-89b55fcc595e?q=80&w=2070&auto=format&fit=crop',
    description:
        'A hands-on workshop covering the fundamentals of AI and Machine Learning. Perfect for beginners!',
  ),
  Event(
    id: const Uuid().v4(),
    title: 'Blockchain Summit',
    startDate: DateTime(2025, 3, 22, 10),
    endDate: DateTime(2025, 3, 22, 16),
    rating: 4.7,
    status: EventStatus.upcoming,
    ticketType: EventTicketType.paid,
    type: EventLocationType.offline,
    pricing: 399.99,
    location: 'Marina Bay Sands, 10 Bayfront Avenue, Singapore 018956',
    pictureUrl:
        'https://images.unsplash.com/photo-1639762681485-074b7f938ba0?q=80&w=2070&auto=format&fit=crop',
    description:
        'Explore the future of blockchain technology with industry leaders and innovative startups.',
  ),
  Event(
    id: const Uuid().v4(),
    title: 'Startup Pitch Night',
    startDate: DateTime(2025, 7, 8, 18, 30),
    endDate: DateTime(2025, 7, 8, 22),
    status: EventStatus.paid,
    ticketType: EventTicketType.paid,
    type: EventLocationType.offline,
    pricing: 149.99,
    location: 'Station F, 5 Parvis Alan Turing, 75013 Paris, France',
    pictureUrl:
        'https://images.unsplash.com/photo-1475721027785-f74eccf877e2?q=80&w=2070&auto=format&fit=crop',
    description:
        'Watch promising startups pitch their ideas to investors. Network with entrepreneurs and VCs.',
  ),
  Event(
    id: const Uuid().v4(),
    title: 'UX/UI Design Bootcamp',
    startDate: DateTime(2025, 8, 20, 9),
    endDate: DateTime(2025, 8, 25, 17),
    status: EventStatus.upcoming,
    ticketType: EventTicketType.paid,
    type: EventLocationType.online,
    pricing: 599.99,
    pictureUrl:
        'https://images.unsplash.com/photo-1586717791821-3f44a563fa4c?q=80&w=2070&auto=format&fit=crop',
    description:
        'Intensive 5-day bootcamp covering modern UX/UI design principles and tools.',
  ),
  Event(
    id: const Uuid().v4(),
    title: 'Mobile App Security Conference',
    startDate: DateTime(2025, 9, 15, 9),
    endDate: DateTime(2025, 9, 16, 17),
    status: EventStatus.upcoming,
    ticketType: EventTicketType.paid,
    type: EventLocationType.offline,
    pricing: 449.99,
    location:
        'ExCeL London, Royal Victoria Dock, 1 Western Gateway, London E16 1XL',
    pictureUrl:
        'https://images.unsplash.com/photo-1563986768609-322da13575f3?q=80&w=2070&auto=format&fit=crop',
    description:
        'Learn about the latest mobile app security threats and best practices for secure development.',
  ),
  Event(
    id: const Uuid().v4(),
    title: 'Web3 Development Workshop',
    startDate: DateTime(2025, 10, 5, 10),
    endDate: DateTime(2025, 10, 5, 16),
    status: EventStatus.upcoming,
    ticketType: EventTicketType.free,
    type: EventLocationType.online,
    pictureUrl:
        'https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?q=80&w=2070&auto=format&fit=crop',
    description:
        'Get started with Web3 development. Learn about smart contracts, DApps, and more.',
  ),
  Event(
    id: const Uuid().v4(),
    title: 'Tech Leadership Summit',
    startDate: DateTime(2025, 11, 12, 9),
    endDate: DateTime(2025, 11, 13, 17),
    status: EventStatus.upcoming,
    ticketType: EventTicketType.paid,
    type: EventLocationType.offline,
    pricing: 699.99,
    location:
        'Dubai World Trade Centre, Sheikh Zayed Rd, Trade Centre, Dubai, UAE',
    pictureUrl:
        'https://images.unsplash.com/photo-1542744173-8e7e53415bb0?q=80&w=2070&auto=format&fit=crop',
    description:
        'Two-day summit focused on technology leadership, team management, and scaling engineering organizations.',
  ),
];

Future<void> seedEvents() async {
  final eventsCollection = locator<FirebaseFirestore>().collection('events');

  // Add each event to Firestore
  for (final event in eventsFixture) {
    final model = EventModel.fromEntity(event)..createdAt = DateTime.now();
    await eventsCollection.add(model.toMap());
  }
}
