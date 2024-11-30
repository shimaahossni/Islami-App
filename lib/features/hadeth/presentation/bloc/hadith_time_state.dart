// features/hadeth/presentation/bloc/hadith_time_state.dart
part of 'hadith_time_bloc.dart';

@immutable
sealed class HadithTimeState {}

final class HadithTimeInitial extends HadithTimeState {}

//////////////////////////////////////hadith state

final class HadithTimeLoaded extends HadithTimeState {}

final class HadithTimeSuccess extends HadithTimeState {}

final class HadithTimeError extends HadithTimeState {
  final String message;

  HadithTimeError({required this.message});
}
