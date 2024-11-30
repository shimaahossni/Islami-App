// features/prayerTime/presentation/bloc/azkar_state.dart
part of 'azkar_bloc.dart';

@immutable
sealed class azkarState {}

final class azkarInitial extends azkarState {}

//////////////////////////////////////hadith state

final class azkarLoaded extends azkarState {}

final class azkarSuccess extends azkarState {}

final class azkarError extends azkarState {
  final String message;

  azkarError({required this.message});
}
