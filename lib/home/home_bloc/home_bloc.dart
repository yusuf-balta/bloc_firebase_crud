import 'package:coflow/home/home_service/home_service.dart';
import 'package:coflow/login/login_services/login_service.dart';

import 'package:coflow/models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  LoginService loginService = LoginService();
  HomeService homeService = HomeService();
  HomeBloc() : super(InitialHomeState()) {
    on(homeEventControl);
  }
  Future<void> homeEventControl(
      HomeEvent event, Emitter<HomeState> emit) async {
    if (event is InitialHomeEvent) {
      emit(LoadingHomeState());
      List<ProductModel> listProduct = [];
      try {
        final products = await homeService.getProductFromDb();

        products.docs.forEach((doc) {
          listProduct
              .add(ProductModel.fromMap(doc.data() as Map<String, dynamic>));
        });
        emit(SuccsesHomeState(productsModel: listProduct));
      } catch (e) {
        emit(FailedHomeState(error: e.toString()));
      }
    } else if (event is LogoutHomeEvent) {
      emit(LogoutLoadingHomeState());
      try {
        await loginService.logoutUser();
        emit(LogoutSuccsesHomeState());
      } on FirebaseAuthException catch (e) {}
    } else if (event is PushToLoginScreenHomeEvent) {
      emit(PushToLoginScreenHomeState());
    }
  }
}
