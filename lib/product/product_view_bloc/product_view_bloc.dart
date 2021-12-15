import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coflow/home/home_service/home_service.dart';
import 'package:coflow/product/product_view_bloc/product_view_event.dart';
import 'package:coflow/product/product_view_bloc/product_view_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductViewBloc extends Bloc<ProductViewEvent, ProductViewState> {
  HomeService homeService = HomeService();
  ProductViewBloc() : super(InitialProductViewState()) {
    on(productViewEventControl);
  }
  Future<void> productViewEventControl(
      ProductViewEvent event, Emitter<ProductViewState> emit) async {
    if (event is AddToDbProductViewEvent) {
      emit(LoadingAddToDbProductViewState());
      try {
        await homeService.addProductToDb(event.productModel);
        emit(SuccsesAddToDbProductViewState());
      } on FirebaseException catch (e) {}
    } else if (event is UpdateToDbProductViewEvent) {
      emit(LoadingUpdateToDbProductViewState());
      try {
        await homeService.updateProductToDb(event.productModel);
        emit(SuccsesUpdateToDbProductViewState());
      } on FirebaseException catch (e) {}
    } else if (event is DeleteToDbProductViewEvent) {
      emit(LoadingDeleteToDbProductViewState());
      try {
        await homeService.deleteProductToDb(event.productModel);
        emit(SuccsesDeleteToDbProductViewState());
      } on FirebaseException catch (e) {}
    } else if (state is PushToHomeScrrenProductViewEvent) {
      emit(PushToHomeScreenProductViewState());
    }
  }
}
