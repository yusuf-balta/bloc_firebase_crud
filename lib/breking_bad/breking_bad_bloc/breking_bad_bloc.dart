import 'package:coflow/breking_bad/breking_bad_bloc/breking_bad_state.dart';
import 'package:coflow/breking_bad/breking_bad_service/breking_bad_service.dart';
import 'package:coflow/models/breking_bad_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'breking_bad_event.dart';

class BrekingBadBloc extends Bloc<BrekingBadEvent, BrekingBadState> {
  BrekingBadService brekingBadService = BrekingBadService();
  BrekingBadBloc() : super(InitialBrekingBadState()) {
    on(brekingBadEventControl);
  }
  Future<void> brekingBadEventControl(
      BrekingBadEvent event, Emitter<BrekingBadState> emit) async {
    if (event is InitialBrekingBadEvent) {
      List<BrekingBadModel> listBrekingBad = [];
      emit(LoadingBrekingBadState());
      try {
        final response = await brekingBadService.getHttp();

        if (response != null) {
          listBrekingBad = (response.data as List)
              .map((e) => BrekingBadModel.fromMap(e))
              .toList();
        }
        emit(SuccsesBrekingBadState(listBrekingBadModels: listBrekingBad));
      } catch (e) {}
    }
  }
}
