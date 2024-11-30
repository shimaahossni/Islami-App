// features/hadeth/presentation/bloc/hadith_time_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:islami/features/hadeth/data/model/response/hadith_details/hadith.dart';
import 'package:islami/features/hadeth/data/model/response/hadith_details/hadith_details.dart';
import 'package:islami/features/hadeth/data/repo/authrepo.dart';
import 'package:meta/meta.dart';
part 'hadith_time_event.dart';
part 'hadith_time_state.dart';

class HadithTimeBloc extends Bloc<HadithTimeEvent, HadithTimeState> {
  HadithTimeBloc() : super(HadithTimeInitial()) {
    on<GetHadithTimeEvent>(loadHadith);
  }
  List<Hadith>? hadithDetails = [];

  loadHadith(GetHadithTimeEvent event, Emitter<HadithTimeState> emit) async {
    emit(HadithTimeLoaded());
    try {
      await AuthRepo.loadHadith().then((Value) {
        if (Value != null) {
          hadithDetails = Value.data?.hadiths ?? [];
          emit(HadithTimeSuccess());
        } else {
          emit(HadithTimeError(message: "Error in loading hadith"));
        }
      });
    } on Exception catch (e) {
      emit(HadithTimeError(message: e.toString()));
    }
  }
}
