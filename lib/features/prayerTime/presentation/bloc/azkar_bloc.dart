// features/prayerTime/presentation/bloc/azkar_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:islami/features/prayerTime/data/model/today_azkar/array.dart';
import 'package:islami/features/prayerTime/data/model/today_azkar/today_azkar.dart';
import 'package:islami/features/prayerTime/data/repo/azkarrepo.dart';
import 'package:meta/meta.dart';
part 'azkar_event.dart';
part 'azkar_state.dart';

class AzkarBloc extends Bloc<AzkarEvent, azkarState> {
  AzkarBloc() : super(azkarInitial()) {
    on<GetAzkarEvent>(loadAzkar);
  }
  List<Array> azkarDetails = [];

  loadAzkar(AzkarEvent event, Emitter<azkarState> emit) async {
    emit(azkarLoaded());
    try {
      await AzkarRepo.loadAzkar().then((Value) {
        if (Value != null) {
          azkarDetails = Value.array ?? [];
          emit(azkarSuccess());
        } else {
          emit(azkarError(message: "Error in loading azkar"));
        }
      });
    } on Exception catch (e) {
      emit(azkarError(message: e.toString()));
    }
  }
}
