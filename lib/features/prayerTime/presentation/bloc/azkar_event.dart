// features/prayerTime/presentation/bloc/azkar_event.dart
part of 'azkar_bloc.dart';

@immutable
sealed class AzkarEvent {}

class GetAzkarEvent extends AzkarEvent {
  TodayAzkar? todayAzkar;
}
