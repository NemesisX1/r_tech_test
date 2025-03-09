part of 'reviews_bloc.dart';

sealed class ReviewsState extends Equatable {
  const ReviewsState();
  
  @override
  List<Object> get props => [];
}

final class ReviewsInitial extends ReviewsState {}
