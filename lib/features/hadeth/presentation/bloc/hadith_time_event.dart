// features/hadeth/presentation/bloc/hadith_time_event.dart
part of 'hadith_time_bloc.dart';

@immutable
sealed class HadithTimeEvent {}

class GetHadithTimeEvent extends HadithTimeEvent {
  HadithDetails? hadithDetails;
}
